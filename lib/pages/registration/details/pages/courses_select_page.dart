/*
 *  Copyright (c) 2020 - 2023
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_timetable/blocs/course_settings/course_setting_bloc.dart';
import 'package:school_timetable/models/courses/year.dart';
import 'package:school_timetable/widgets/autocomplete_field/autocomplete_field.dart';
import 'package:school_timetable/widgets/autocomplete_field/courses_props.dart';
import 'package:school_timetable/blocs/courses/courses_bloc.dart';
import 'package:school_timetable/models/academic_year.dart';
import 'package:school_timetable/models/courses/courses.dart';
import 'package:school_timetable/models/courses/course.dart';
import 'package:school_timetable/widgets/round_check_box.dart';

class CoursesSelectPage extends StatefulWidget {
  const CoursesSelectPage({Key? key}) : super(key: key);

  @override
  State<CoursesSelectPage> createState() => _CoursesSelectPageState();
}

class _CoursesSelectPageState extends State<CoursesSelectPage> {
  Course? selectedCourse;
  TextEditingController _courseEditingController = TextEditingController();
  final _openDropDownProgKeyYears = GlobalKey<DropdownSearchState<Year>>();
  FocusNode _focusNode = FocusNode();
  AcademicYear? academicYear;
  Course? finalChoice;
  bool _yearsFieldrequired = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_focusListener);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusListener);
    _courseEditingController.dispose();
    super.dispose();
  }

  // This function is triggered when the clear buttion is pressed
  void _clearTextField() {
    // Clear everything in the text field
    _courseEditingController.clear();
    _openDropDownProgKeyYears.currentState?.changeSelectedItems([]);
    selectedCourse = null;
    finalChoice = null;
    _yearsFieldrequired = false;
    // Call setState to update the UI
    setState(() {});
  }

  void _focusListener() {
    if (_focusNode.hasFocus) {
      Future.delayed(
        Duration(microseconds: 400),
        () => _liftMeUp(),
      );
    }
  }

  void _liftMeUp() {
    if (mounted) {
      Scrollable.ensureVisible(
        context,
        alignment: 0.5,
        alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtEnd,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
      );
    }
  }

  void onNext(BuildContext context) {
    if (finalChoice == null) {
      setState(() {
        _yearsFieldrequired = true;
      });
    } else {
      context
          .read<CourseSettingBloc>()
          .chosenCourse(academicYear!, finalChoice!);
    }
  }

  @override
  Widget build(BuildContext context) {
    //MediaQueryData mediaQuery = MediaQuery.of(context);
    //return Container();
    return MultiBlocProvider(
      providers: [
        BlocProvider<CoursesBloc>(
            create: (context) =>
                CoursesBloc(coursesRepository: context.read())..load())
      ],
      child: BlocBuilder<CoursesBloc, CoursesState>(
        builder: (context, state) {
          return state.when(
            fetched: (academicYears, courses) =>
                _body(academicYears, courses, context),
            fetching: () => Center(child: CircularProgressIndicator()),
            error: () => Container(),
          );
        },
      ),
    );
  }

  Widget _body(
      List<AcademicYear> academicYears, Courses courses, BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    this.academicYear = academicYears[0];
    return SizedBox(
      height: mediaQuery.size.height,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 15.0, right: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    height: (mediaQuery.size.height - mediaQuery.padding.top) *
                        0.02),
                Center(
                  child: Text(
                    AppLocalizations.of(context)?.course_page_label ?? '',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
                SizedBox(
                    height: (mediaQuery.size.height - mediaQuery.padding.top) *
                        0.1),
                Text(
                  AppLocalizations.of(context)?.select_academic_label ?? '',
                  style: Theme.of(context).textTheme.headline2,
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: DropdownSearch<AcademicYear>(
                    items: academicYears,
                    compareFn: (i, s) => i == s,
                    itemAsString: (server) => server.label,
                    selectedItem: academicYears[0],
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      baseStyle: TextStyle(fontSize: 16),
                      dropdownSearchDecoration: InputDecoration(
                        filled: true,
                        contentPadding:
                            const EdgeInsets.fromLTRB(20, 20, 20, 20),
                      ),
                    ),
                    popupProps: PopupProps.menu(
                      fit: FlexFit.loose,
                      showSelectedItems: true,
                      //showSearchBox: true,
                      menuProps: MenuProps(
                        elevation: 0,
                      ),
                      searchFieldProps: TextFieldProps(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25)),
                        )),
                      ),
                    ),
                    clearButtonProps: ClearButtonProps(isVisible: false),
                    onChanged: (academicYear) {
                      this.academicYear = academicYear;
                    },
                  ),
                ),

                SizedBox(
                    height: (mediaQuery.size.height - mediaQuery.padding.top) *
                        0.025),
                Text(
                  AppLocalizations.of(context)?.select_course_label ?? '',
                  style: Theme.of(context).textTheme.headline2,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: AutoCompleteField(
                    textEditingController: _courseEditingController,
                    focusNode: _focusNode,
                    fieldProps: CoursesProps(
                      labelText: AppLocalizations.of(context)
                              ?.select_course_label_hint ??
                          '',
                      courses: courses,
                      onSelected: (Course value) {
                        this.selectedCourse = value;
                      },
                      suffixIcon: _courseEditingController.text.isEmpty
                          ? null // Show nothing if the text field is empty
                          : IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: _clearTextField,
                            ),
                    ),
                  ),
                ),
                // SizedBox(
                //     height:
                //         (mediaQuery.size.height - mediaQuery.padding.top) * 0.15),
                //DoneSettingsButton(),
                SizedBox(
                    height: (mediaQuery.size.height - mediaQuery.padding.top) *
                        0.025),
                Text(
                  AppLocalizations.of(context)?.select_year_label ?? '',
                  style: Theme.of(context).textTheme.headline2,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: DropdownSearch<Year>.multiSelection(
                    key: _openDropDownProgKeyYears,
                    items: selectedCourse?.years ?? [],
                    enabled: selectedCourse != null,
                    compareFn: (i, s) => i == s,
                    itemAsString: (year) => year.label,
                    dropdownDecoratorProps: DropDownDecoratorProps(
                        baseStyle: TextStyle(fontSize: 16),
                        dropdownSearchDecoration: InputDecoration(
                          filled: true,
                          labelText: selectedCourse?.years != null
                              ? AppLocalizations.of(context)
                                      ?.select_year_label_hint ??
                                  ''
                              : " ",
                          contentPadding:
                              const EdgeInsets.fromLTRB(20, 20, 20, 20),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                        )),
                    popupProps: PopupPropsMultiSelection.menu(
                      fit: FlexFit.loose,
                      showSelectedItems: true,
                      selectionWidget: (context, text, isSelected) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: RoundCheckBox(
                              value: isSelected,
                              uncheckedColor:
                                  Theme.of(context).unselectedWidgetColor,
                              checkedColor: Theme.of(context).selectedRowColor,
                              onChanged: (bool? v) {
                                if (v == null) v = false;
                                setState(() {
                                  isSelected = v!;
                                });
                              }),
                        );
                      },
                      menuProps: MenuProps(
                        elevation: 0,
                        //backgroundColor: Colors.white70,
                        shape: RoundedRectangleBorder(
                          // side: BorderSide(
                          //   color: Colors.greenAccent,
                          // ),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      searchFieldProps: TextFieldProps(
                        decoration: const InputDecoration(
                            //iconColor: Colors.white,
                            border: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(25)),
                        )),
                      ),
                      //itemBuilder: _universityBuilder,
                    ),
                    // items: serversUny.keys.toList(),

                    clearButtonProps: ClearButtonProps(
                        isVisible: true,
                        onPressed: () {
                          _openDropDownProgKeyYears.currentState
                              ?.changeSelectedItems([]);
                          finalChoice = null;
                        }),
                    autoValidateMode: AutovalidateMode.always,
                    validator: (years) {
                      if (_yearsFieldrequired) {
                        return 'required filed';
                      }
                      return null;
                    },
                    onChanged: (years) {
                      if (years.isNotEmpty) {
                        _yearsFieldrequired = false;
                        finalChoice = Course(
                            years: years,
                            label: selectedCourse?.label ?? "",
                            tipo: selectedCourse?.tipo ?? "",
                            tipoID: selectedCourse?.tipoID ?? "",
                            valore: selectedCourse?.valore ?? "",
                            cdlId: selectedCourse?.cdlId ?? "",
                            scuola: selectedCourse?.scuola ?? "",
                            defaultGrid: selectedCourse?.defaultGrid ?? "",
                            pubPeriodi: selectedCourse?.pubPeriodi ?? [],
                            periodi: selectedCourse?.periodi ?? [],
                            facoltaId: selectedCourse?.facoltaId ?? "",
                            facoltaCode: selectedCourse?.facoltaCode ?? "");
                      }
                    },
                  ),
                ),
                SizedBox(
                    height: (mediaQuery.size.height - mediaQuery.padding.top) *
                        0.05),
                //DoneSettingsButton(),
                ElevatedButton(
                  onPressed:
                      selectedCourse == null ? null : () => onNext(context),
                  child: const Icon(
                    Icons.arrow_forward,
                    size: 50,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
