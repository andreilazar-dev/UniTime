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
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_essentials_kit/flutter_essentials_kit.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:school_timetable/blocs/daily_timetable/daily_timetable_bloc.dart';
import 'package:school_timetable/models/timetable/celle.dart';
import 'package:school_timetable/models/timetable/time_table.dart';
import 'package:school_timetable/widgets/event_card.dart';
import 'package:school_timetable/widgets/event_details.dart';
import 'package:school_timetable/widgets/loading_widget.dart';

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
      body: LayoutBuilder(builder: (context, constraints) {
        return RefreshIndicator(
          onRefresh: () async {
            context.read<DailyTimetableBloc>().loadTimetable(DateTime.now());
          },
          child: SingleChildScrollView(
            // To make RefreshIndicator work, it child widget should scroll, thats why I added [AlwaysScrollableScrollPhysics]
            physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics()),
            child: BlocConsumer<DailyTimetableBloc, DailyTimetableState>(
              listener: (context, state) =>
                  state.whenOrNull(error: (error) => showError(context, error)),
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SafeArea(bottom: false, child: _header(context)),
                    state.when(
                      fetching: () => const LoadingWidget(),
                      fetched: (timeTable) => _body(context, timeTable),
                      error: (_) => _error(context),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      }),
    );
  }

  void showError(BuildContext context, LocalizedError error) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Center(child: Text("Error")),
              content: Text(
                error.localizedString(context) ?? "",
                textAlign: TextAlign.center,
              ),
            ),
        barrierDismissible: true);
  }

  Widget _error(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return SizedBox(
      height: mediaQuery.size.height * .7,
      child: Center(
        child: SizedBox(
            height: mediaQuery.size.height * .3,
            child: Image.asset(
              'assets/images/notices/error.png',
              fit: BoxFit.contain,
            )),
      ),
    );
  }

  Widget _body(BuildContext context, TimeTable timeTable) {
    if (timeTable.celle?.isEmpty ?? true) {
      final mediaQuery = MediaQuery.of(context);
      return SizedBox(
          height: mediaQuery.size.height * 0.3,
          child: Image.asset(
            'assets/images/notices/noLessons.png',
            fit: BoxFit.contain,
          ));
    }
    return Column(
      children: [
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: timeTable.celle?.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12.0, horizontal: 14),
                child: EventCard<Celle>(
                  event: timeTable.celle![index],
                  eventName: timeTable.celle![index].nomeInsegnamento ??
                      timeTable.celle![index].nome,
                  eventTimeInterval:
                      "${timeTable.celle![index].oraInizio!}- ${timeTable.celle![index].oraFine!}",
                  eventPlace: timeTable.celle![index].aula ?? "",
                  onEventTap: (event) {
                    showCupertinoModalBottomSheet(
                      expand: false,
                      context: context,
                      backgroundColor: Colors.white,
                      builder: (context) => EventDetails(
                        cell: event,
                      ),
                    );
                  },
                ),
              );
            })
      ],
    );
  }

  Widget _header(BuildContext context) {
    final headerText =
        DateFormat(DateFormat.MONTH_WEEKDAY_DAY).format(DateTime.now());
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            //width: 120.0,
            child: Text(AppLocalizations.of(context)?.today_label ?? '',
                style: Theme.of(context).textTheme.displayMedium),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                //width: 120.0,
                child: Text(
                  headerText,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
