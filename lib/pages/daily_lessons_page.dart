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
import 'package:intl/intl.dart';
import 'package:school_timetable/blocs/daily_timetable/daily_timetable_bloc.dart';
import 'package:school_timetable/models/timetable/celle.dart';
import 'package:school_timetable/models/timetable/time_table.dart';
import 'package:school_timetable/widgets/event_card.dart';
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
            return Column(
              children: [
                SafeArea(bottom: false, child: _header()),
                state.when(
                  fetching: () => Center(child: CircularProgressIndicator()),
                  fetched: (timeTable) => _body(context, timeTable),
                  error: () => Container(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _body(BuildContext context, TimeTable timeTable) {
    return Column(
      children: [
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: timeTable.celle?.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 14),
                child: EventCard<Celle>(
                  event: timeTable!.celle![index],
                  eventName: timeTable!.celle![index]?.nomeInsegnamento ??
                      timeTable!.celle![index]?.nome,
                  eventTimeInterval: timeTable!.celle![index]!.oraInizio! +
                      "- " +
                      timeTable!.celle![index]!.oraFine!,
                  eventPlace: timeTable!.celle![index]?.aula ?? "",
                  onEventTap: (event) {
                    print(event.nomeInsegnamento);
                  },
                ),
              );
            })
      ],
    );
  }

  Widget _header() {
    final headerText =
        DateFormat(DateFormat.MONTH_WEEKDAY_DAY).format(DateTime.now());
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            //width: 120.0,
            child: Text(
              "Today",
              style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.w700),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                //width: 120.0,
                child: Text(
                  headerText,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
