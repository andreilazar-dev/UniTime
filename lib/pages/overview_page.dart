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
import 'package:school_timetable/blocs/overview/overview_bloc.dart';
import 'package:school_timetable/misc/date_util.dart';
import 'package:school_timetable/models/celle_data_source.dart';
import 'package:school_timetable/models/timetable/time_table.dart';
import 'package:school_timetable/widgets/header_calendar.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';

class OverviewPage extends StatefulWidget with AutoRouteWrapper {
  const OverviewPage({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<OverviewBloc>(
        create: (context) => OverviewBloc(coursesRepository: context.read())
          ..loadTimetable(DateTime.now()),
        child: this,
      );

  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  final _kToday = DateTime.now();
  late var _kFirstDay;
  late var _kLastDay;
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime? _selectedDay;
  late PageController _pageController;
  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());
  DateFormat _inputDateFormat = DateFormat('dd/MM/yyyy');
  CalendarController _timeLineController = CalendarController();

  List<Color> _colors = [
    const Color(0xFF4B496A),
    const Color.fromRGBO(114, 114, 186, 1),
    const Color(0xFF54548E),
    const Color(0xFF52529D),
  ];

  @override
  void initState() {
    _kFirstDay = DateTime(_kToday.year, _kToday.month - 3, _kToday.day);
    _kLastDay = DateTime(_kToday.year, _kToday.month + 3, _kToday.day);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OverviewBloc, OverviewState>(
        builder: (context, overviewState) {
          // return state.when(
          //   fetching: () => Center(child: CircularProgressIndicator()),
          //   fetched: (timeTable) => _body(context, timeTable),
          //   error: () => Container(),
          // );
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50.0),
              ValueListenableBuilder<DateTime>(
                valueListenable: _focusedDay,
                builder: (context, value, _) {
                  return CalendarHeader(
                    focusedDay: value,
                    onLeftArrowTap: () {
                      _pageController.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    },
                    onRightArrowTap: () {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 20.0),
              TableCalendar(
                firstDay: _kFirstDay,
                lastDay: _kLastDay,
                startingDayOfWeek: StartingDayOfWeek.monday,
                headerVisible: false,
                focusedDay: _focusedDay.value,
                //selectedDayPredicate: (day) => _selectedDays.contains(day),
                calendarFormat: _calendarFormat,
                selectedDayPredicate: (day) {
                  // Use `selectedDayPredicate` to determine which day is currently selected.
                  // If this returns true, then `day` will be marked as selected.

                  // Using `isSameDay` is recommended to disregard
                  // the time-part of compared DateTime objects.
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    if (_focusedDay.value != null &&
                        !AppDateUtils.isSameWeek(
                            _focusedDay.value!, selectedDay)) {
                      context.read<OverviewBloc>().loadTimetable(selectedDay);
                    }
                    // Call `setState()` when updating the selected day
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay.value = focusedDay;
                    });
                  }
                },
                onCalendarCreated: (controller) => _pageController = controller,
                onPageChanged: (focusedDay) => _focusedDay.value = focusedDay,
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() => _calendarFormat = format);
                  }
                },
              ),
              if (overviewState is FetchingOverviewState)
                Expanded(child: Center(child: CircularProgressIndicator())),
              if (overviewState is FetchedOverviewState)
                _timeline(overviewState.timeTable)
            ],
          );
        },
      ),
    );
  }

  Widget _timeline(TimeTable timeTable) {
    _timeLineController.displayDate = _focusedDay.value;
    return Expanded(
      child: SfCalendar(
        view: CalendarView.day,
        controller: _timeLineController,
        headerHeight: 0,
        viewHeaderHeight: 0,
        cellEndPadding: 5,
        showCurrentTimeIndicator: true,
        minDate: _inputDateFormat.parse(timeTable.first_day_label),
        maxDate: _inputDateFormat.parse(timeTable.last_day_label),
        timeSlotViewSettings: TimeSlotViewSettings(
          startHour: 8,
          endHour: 23,
          timeInterval: Duration(minutes: 30),
          // timeIntervalHeight: -1,
          // timeIntervalWidth: 60,
          timeFormat: "HH:mm",
          numberOfDaysInView: 1,
          nonWorkingDays: <int>[DateTime.monday, DateTime.friday],
          timeTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            fontSize: 12,
          ),
        ),
        dataSource: CelleDataSource(timeTable.celle!, _colors),
        onTap: (dettails) {
          //TODO: POP UP
          if (dettails.appointments != null) {
            print(dettails.appointments![0]!.nomeInsegnamento);
          }
        },
        // onSelectionChanged: (sel) {
        //   print(sel.date);
        // },
        // onViewChanged: (view) {
        //   if (!isSameDay(_focusedDay.value, view.visibleDates[0])) {
        //     // setState(() {
        //     //   _selectedDay = view.visibleDates[0];
        //     //   //   //_focusedDay.value = focusedDay;
        //     // });
        //   }
        //},
      ),
    );
  }
}
