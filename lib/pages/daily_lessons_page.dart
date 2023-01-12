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
    return BlocConsumer<DailyTimetableBloc, DailyTimetableState>(
      listener: (context, state) => state.whenOrNull(
          // fetched: (timeTable) => _body(context, timeTable),
          ),
      builder: (context, state) {
        return state.when(
          fetching: () => Center(child: CircularProgressIndicator()),
          fetched: (timeTable) => _body(context, timeTable),
          error: () => Container(),
        );
      },
    );
  }

  Widget _body(BuildContext context, TimeTable timeTable) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 60,
          width: 400,
          color: Colors.green,
          child: Text(timeTable.data),
        ),
      ),
    );
  }
}
