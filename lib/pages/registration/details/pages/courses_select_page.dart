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
import 'package:school_timetable/models/courses/school.dart';
import 'package:school_timetable/models/courses/year.dart';
import 'package:school_timetable/repositories/configuration_repository.dart';
import 'package:school_timetable/widgets/autocomplete_field/autocomplete_field.dart';
import 'package:school_timetable/widgets/autocomplete_field/courses_props.dart';
import 'package:school_timetable/blocs/courses/courses_bloc.dart';
import 'package:school_timetable/models/academic_year.dart';
import 'package:school_timetable/models/courses/courses.dart';
import 'package:school_timetable/models/courses/course.dart';
import 'package:school_timetable/widgets/loading_widget.dart';
import 'package:school_timetable/widgets/round_check_box.dart';

class CoursesSelectPage extends StatefulWidget {
  const CoursesSelectPage({Key? key}) : super(key: key);

  @override
  State<CoursesSelectPage> createState() => _CoursesSelectPageState();
}

class _CoursesSelectPageState extends State<CoursesSelectPage> {
  final TextEditingController _courseEditingController =
      TextEditingController();
  final _openDropDownProgKeyYears = GlobalKey<DropdownSearchState<Year>>();
  final FocusNode _focusNode = FocusNode();

  Course? selectedCourse;
  AcademicYear? selectedAcademicYear;
  Course? finalChoice;
  bool _yearsFieldRequired = false;

  //Menu
  List<AcademicYear> academicYears = [];
  Courses courses = const Courses(elencoCorsi: []);
  List<Course> studyCourses = [];
  List<Year>? years;

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
    _yearsFieldRequired = false;
    // Call setState to update the UI
    setState(() {});
  }

  void _focusListener() {
    if (_focusNode.hasFocus) {
      Future.delayed(
        const Duration(microseconds: 400),
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
        _yearsFieldRequired = true;
      });
    } else {
      context
          .read<CourseSettingBloc>()
          .chosenCourse(selectedAcademicYear!, finalChoice!);
    }
  }

  Future<void> _onGetYears(BuildContext context, String courseValue) async {
    final code = await context.read<ConfigurationRepository>().getServer();
    if (mounted) {
      context.read<CoursesBloc>().getYears(
          courseValue, selectedAcademicYear!.value, code.toUpperCase());
    }
  }

  void _filterStudyCourses(School? school) {
    if (school != null) {
      setState(() {
        studyCourses = courses.elencoCorsi
            .where((element) => element.scuola == school.valore)
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CoursesBloc>(
          create: (context) =>
              CoursesBloc(coursesRepository: context.read())..load(),
        )
      ],
      child: BlocConsumer<CoursesBloc, CoursesState>(
        listener: (context, state) =>
            state.whenOrNull(fetched: (academicYears, courses) {
          this.academicYears = academicYears;
          this.courses = courses;
          studyCourses = courses.elencoCorsi;
          return null;
        }, fetchedYears: (years) {
          this.years = years;
          return null;
        }),
        builder: (ctx, state) {
          // return state.when(
          //   fetched: (academicYears, courses) =>
          //       _body(academicYears, courses, context),
          //   fetching: () => Center(child: CircularProgressIndicator()),
          //   error: () => Container(),
          // );
          return state.maybeWhen(
              fetching: () => const LoadingWidget(), orElse: () => _body(ctx));
        },
      ),
    );
  }

  Widget _body(BuildContext ctx) {
    MediaQueryData mediaQuery = MediaQuery.of(ctx);
    selectedAcademicYear = academicYears[0];
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
                    AppLocalizations.of(ctx)?.course_page_label ?? '',
                    style: Theme.of(ctx).textTheme.headlineMedium,
                  ),
                ),
                SizedBox(
                    height: (mediaQuery.size.height - mediaQuery.padding.top) *
                        0.1),
                Text(
                  AppLocalizations.of(ctx)?.select_academic_label ?? '',
                  style: Theme.of(ctx).textTheme.headlineMedium,
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: DropdownSearch<AcademicYear>(
                    items: academicYears,
                    compareFn: (i, s) => i == s,
                    itemAsString: (server) => server.label,
                    selectedItem: academicYears[0],
                    dropdownButtonProps: DropdownButtonProps(
                      color: Theme.of(ctx).primaryColorLight,
                    ),
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      baseStyle: Theme.of(ctx).textTheme.labelMedium,
                      dropdownSearchDecoration: const InputDecoration(
                        filled: true,
                        contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      ),
                    ),
                    popupProps: const PopupProps.menu(
                      fit: FlexFit.loose,
                      showSelectedItems: true,
                      //showSearchBox: true,
                      menuProps: MenuProps(
                        elevation: 0,
                      ),
                      searchFieldProps: TextFieldProps(
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        )),
                      ),
                    ),
                    clearButtonProps: const ClearButtonProps(isVisible: false),
                    onChanged: (academicYear) {
                      selectedAcademicYear = academicYear;
                    },
                  ),
                ),

                if (courses.elencoScuole != null &&
                    courses.elencoScuole!.length > 1)
                  _school(mediaQuery),

                SizedBox(
                    height: (mediaQuery.size.height - mediaQuery.padding.top) *
                        0.025),
                Text(
                  AppLocalizations.of(ctx)?.select_course_label ?? '',
                  style: Theme.of(ctx).textTheme.headlineMedium,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: AutoCompleteField(
                    textEditingController: _courseEditingController,
                    focusNode: _focusNode,
                    fieldProps: CoursesProps(
                      labelText:
                          AppLocalizations.of(ctx)?.select_course_label_hint ??
                              '',
                      courses: studyCourses,
                      onSelected: (Course value) {
                        selectedCourse = value;
                        years = value.years;
                        if (courses.elencoScuole != null) {
                          _onGetYears(ctx, value.valore);
                        }
                      },
                      suffixIcon: _courseEditingController.text.isEmpty
                          ? null // Show nothing if the text field is empty
                          : IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: Theme.of(ctx).primaryColorLight,
                              ),
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
                  AppLocalizations.of(ctx)?.select_year_label ?? '',
                  style: Theme.of(ctx).textTheme.headlineMedium,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: DropdownSearch<Year>.multiSelection(
                    key: _openDropDownProgKeyYears,
                    items: years ?? [],
                    enabled: years != null,
                    compareFn: (i, s) => i == s,
                    itemAsString: (year) => year.label,
                    dropdownButtonProps: DropdownButtonProps(
                      color: Theme.of(ctx).primaryColorLight,
                    ),
                    dropdownDecoratorProps: DropDownDecoratorProps(
                        baseStyle: Theme.of(ctx).textTheme.labelMedium,
                        dropdownSearchDecoration: InputDecoration(
                          filled: true,
                          iconColor: Colors.white,
                          labelStyle: Theme.of(ctx).textTheme.labelMedium,
                          labelText: selectedCourse?.years != null
                              ? AppLocalizations.of(ctx)
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
                      itemBuilder: (context, item, isSelected) {
                        return ListTile(
                          selected: isSelected,
                          title: Text(
                            item.label,
                          ),
                        );
                      },
                      selectionWidget: (context, text, isSelected) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 15.0),
                          child: RoundCheckBox(
                              value: isSelected,
                              uncheckedColor:
                                  Theme.of(context).unselectedWidgetColor,
                              checkedColor: Theme.of(context).selectedRowColor,
                              onChanged: (bool? v) {
                                v ??= false;
                                setState(() {
                                  isSelected = v!;
                                });
                              }),
                        );
                      },
                      menuProps: MenuProps(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          // side: BorderSide(
                          //   color: Colors.greenAccent,
                          // ),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                      ),
                      //itemBuilder: _universityBuilder,
                    ),
                    // items: serversUny.keys.toList(),

                    clearButtonProps: ClearButtonProps(
                        color: Colors.white,
                        isVisible: true,
                        onPressed: () {
                          _openDropDownProgKeyYears.currentState
                              ?.changeSelectedItems([]);
                          finalChoice = null;
                        }),
                    autoValidateMode: AutovalidateMode.always,
                    validator: (years) {
                      if (_yearsFieldRequired) {
                        return 'required filed';
                      }
                      return null;
                    },
                    onChanged: (years) {
                      if (years.isNotEmpty) {
                        _yearsFieldRequired = false;
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
                  onPressed: selectedCourse == null ? null : () => onNext(ctx),
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

  Widget _school(MediaQueryData mediaQuery) {
    return Column(
      children: [
        SizedBox(
            height: (mediaQuery.size.height - mediaQuery.padding.top) * 0.025),
        Text(
          AppLocalizations.of(context)?.select_school_label ?? '',
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: DropdownSearch<School>(
            items: courses.elencoScuole ?? [],
            compareFn: (i, s) => i == s,
            itemAsString: (server) => server.label,
            dropdownButtonProps: DropdownButtonProps(
              color: Theme.of(context).primaryColorLight,
            ),
            dropdownDecoratorProps: DropDownDecoratorProps(
              baseStyle: Theme.of(context).textTheme.labelMedium,
              dropdownSearchDecoration: const InputDecoration(
                filled: true,
                contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              ),
            ),
            popupProps: PopupProps.menu(
              fit: FlexFit.loose,
              showSelectedItems: true,
              //showSearchBox: true,
              menuProps: const MenuProps(
                elevation: 0,
              ),
              searchFieldProps: TextFieldProps(
                style: Theme.of(context).textTheme.labelMedium,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                )),
              ),
            ),
            clearButtonProps: const ClearButtonProps(isVisible: false),
            onChanged: (school) {
              _filterStudyCourses(school);
            },
          ),
        ),
      ],
    );
  }
}
