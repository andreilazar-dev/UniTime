/*
 *  Copyright (c) 2020 - 2023
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_timetable/blocs/course_settings/course_setting_bloc.dart';
import 'package:school_timetable/models/courses/course.dart';
import 'package:school_timetable/repositories/configuration_repository.dart';
import 'package:school_timetable/widgets/background_card.dart';
import 'package:school_timetable/widgets/custom_checbox_list_tile.dart';
import 'package:school_timetable/widgets/custon_floating_action_button.dart';

class FilterConfigPage extends StatefulWidget {
  const FilterConfigPage({Key? key}) : super(key: key);

  @override
  State<FilterConfigPage> createState() => _FilterConfigPageState();
}

class _FilterConfigPageState extends State<FilterConfigPage> {
  var buttonwidth = 300.00;
  var buttonheight = 65.00;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseSettingBloc, CourseSettingState>(
      builder: (context, state) {
        return state.whenOrNull(
                teachings: (course) => _body(context, course)) ??
            Container();
      },
    );
  }

  Widget _body(BuildContext context, Course course) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                child: IconButton(
                    padding: const EdgeInsets.only(left: 20.0),
                    onPressed: () {
                      context.read<CourseSettingBloc>().initial();
                    },
                    icon: const Icon(Icons.arrow_back_sharp,
                        color: Colors.white, size: 30.0)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  AppLocalizations.of(context)?.filter_course_page_label ?? '',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: course.years!.length,
                  itemBuilder: (_, indexYears) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            course.years![indexYears].label,
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: course
                              .years![indexYears].elencoInsegnamenti.length,
                          itemBuilder: (BuildContext context, int index) {
                            return index <=
                                    course.years![indexYears].elencoInsegnamenti
                                            .length -
                                        1
                                ? Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: BackgroundCard(
                                      // backgroundColor: const Color.fromRGBO(97, 97, 168, 1),
                                      height: buttonheight,
                                      width: buttonwidth,
                                      child: CustomCheckboxListTile(
                                        activeColor: Colors.grey,
                                        autofocus: true,
                                        enableFeedback: true,
                                        title: Text(
                                          course.years![indexYears]
                                              .elencoInsegnamenti[index].label,
                                          style: const TextStyle(
                                              color: Color(0xFFFFFFFC)),
                                        ),
                                        value: course.years![indexYears]
                                            .elencoInsegnamenti[index].selected,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            course
                                                .years![indexYears]
                                                .elencoInsegnamenti[index]
                                                .selected = value!;
                                          });
                                        },
                                      ),
                                    ),
                                  )
                                : const Padding(padding: EdgeInsets.all(60.0));
                          },
                        )
                      ],
                    );
                  }),
              const SizedBox(
                height: 80,
              )
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 60,
              child: FittedBox(
                child: CustomFloatingActionButton.extended(
                  shape: const StadiumBorder(
                      side: BorderSide(
                          color: Color.fromRGBO(97, 97, 168, 0.5), width: 2)),
                  elevation: 1.5,
                  onPressed: () {
                    _onConfirm(context, course);
                    context.read<CourseSettingBloc>().savingCourse(course);
                  },
                  backgroundColor: const Color.fromRGBO(62, 62, 112, 1),
                  label: Text(
                    AppLocalizations.of(context)?.confirm_dialog ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  icon:
                      const Icon(Icons.check, color: Colors.green, size: 24.0),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Future<void> _onConfirm(BuildContext context, Course course) async {
    if (mounted) {
      ConfigurationRepository repo = context.read<ConfigurationRepository>();
      final code = await repo.getServer();
      final academic = await repo.getAcademic();
      FirebaseAnalytics.instance.logEvent(
        name: 'app_config',
        parameters: <String, dynamic>{
          'universita': code,
          'anno_accademico': academic?.label,
          'corso': course.label,
          'anno_studi': course.years?.map((e) => e.label).join("_"),
        },
      );
    }
  }
}
