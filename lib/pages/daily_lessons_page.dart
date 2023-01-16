/*
 *  Copyright (c) 2020 - 2023
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_timetable/blocs/daily_timetable/daily_timetable_bloc.dart';
import 'package:school_timetable/models/timetable/time_table.dart';
import 'package:school_timetable/widgets/event_label.dart';

class DailyLessonsPage extends StatelessWidget with AutoRouteWrapper {
  const DailyLessonsPage({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<DailyTimetableBloc>(
        create: (context) =>
            DailyTimetableBloc(coursesRepository: context.read())
              ..loadTimetable(DateTime.now()),
        child: this,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: BlocBuilder<DailyTimetableBloc, DailyTimetableState>(
          builder: (context, state) {
            return state.when(
              fetching: () => Center(child: CircularProgressIndicator()),
              fetched: (timeTable) => _body(context, timeTable),
              error: () => Container(),
            );
          },
        ),
      ),
    );
  }

  Widget _body(BuildContext context, TimeTable timeTable) {
    return Column(
      children: [
        Container(
          height: 60,
          color: Colors.red,
          child: Text(timeTable.data),
        ),
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: timeTable.celle?.length,
            itemBuilder: (context, index) {
              if (timeTable.data == timeTable!.celle![index]?.data) {
                return EventLabel(
                    eventName: timeTable!.celle![index]?.nomeInsegnamento ??
                        timeTable!.celle![index]?.nome,
                    eventTimeInterval: timeTable!.celle![index]!.oraInizio! +
                        "- " +
                        timeTable!.celle![index]!.oraFine!,
                    eventPlace: timeTable!.celle![index]?.aula ?? "");
              }
              return SizedBox();
            })
      ],
    );
  }
}
