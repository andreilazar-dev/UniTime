/*
 *  Copyright (c) 2020 - 2023
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */
import 'dart:collection';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:school_timetable/blocs/overview/overview_bloc.dart';
import 'package:school_timetable/models/timetable/celle.dart';
import 'package:school_timetable/models/timetable/time_table.dart';
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
  final kToday = DateTime.now();
  late var kFirstDay;
  late var kLastDay;
  CalendarFormat _calendarFormat = CalendarFormat.week;

  //DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late PageController _pageController;
  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  List<Color> _colors = [
    const Color(0xFF7474CE),
    const Color.fromRGBO(114, 114, 186, 1),
    const Color(0xFF54548E),
    const Color(0xFF52529D),
  ];

  //late final ValueNotifier<List<Event>> _selectedEvents;
  late Set<DateTime> _selectedDays;

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  CalendarController _timeLineController = CalendarController();

  @override
  void initState() {
    kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
    kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
    _selectedDays = LinkedHashSet<DateTime>(
      equals: isSameDay,
      hashCode: getHashCode,
    );

    _selectedDays.add(_focusedDay.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<OverviewBloc, OverviewState>(
        builder: (context, state) {
          return state.when(
            fetching: () => Center(child: CircularProgressIndicator()),
            fetched: (timeTable) => _body(context, timeTable),
            error: () => Container(),
          );
        },
      ),
    );
  }

  bool get canClearSelection =>
      _selectedDays.isNotEmpty || _rangeStart != null || _rangeEnd != null;

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      if (_selectedDays.contains(selectedDay)) {
        _selectedDays.remove(selectedDay);
      } else {
        _selectedDays.add(selectedDay);
      }

      _focusedDay.value = focusedDay;
      _rangeStart = null;
      _rangeEnd = null;
      _rangeSelectionMode = RangeSelectionMode.toggledOff;
    });

    //_selectedEvents.value = _getEventsForDays(_selectedDays);
  }

  Widget _body(BuildContext context, TimeTable timeTable) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 50.0),
        ValueListenableBuilder<DateTime>(
          valueListenable: _focusedDay,
          builder: (context, value, _) {
            return _CalendarHeader(
              focusedDay: value,
              clearButtonVisible: canClearSelection,
              onTodayButtonTap: () {
                setState(() => _focusedDay.value = DateTime.now());
              },
              onClearButtonTap: () {
                // setState(() {
                //   _rangeStart = null;
                //   _rangeEnd = null;
                //   _selectedDays.clear();
                //   _selectedEvents.value = [];
                // });
              },
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
          firstDay: kFirstDay,
          lastDay: kLastDay,
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
              // Call `setState()` when updating the selected day
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay.value = focusedDay;
              });
              _timeLineController.displayDate = _selectedDay;
            }
          },
          // onFormatChanged: (format) {
          //   if (_calendarFormat != format) {
          //     // Call `setState()` when updating calendar format
          //     setState(() {
          //       _calendarFormat = format;
          //     });
          //   }
          // },
          // onPageChanged: (focusedDay) {
          //   // No need to call `setState()` here
          //   _focusedDay = focusedDay;
          // },
          //rangeSelectionMode: _rangeSelectionMode,
          //eventLoader: _getEventsForDay,
          // holidayPredicate: (day) {
          //   // Every 20th day of the month will be treated as a holiday
          //   return day.day == 20;
          // },
          //onDaySelected: _onDaySelected,
          //onRangeSelected: _onRangeSelected,
          onCalendarCreated: (controller) => _pageController = controller,
          onPageChanged: (focusedDay) => _focusedDay.value = focusedDay,
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              setState(() => _calendarFormat = format);
            }
          },
        ),
        Expanded(
          child: SfCalendar(
            view: CalendarView.day,
            controller: _timeLineController,
            headerHeight: 0,
            viewHeaderHeight: 0,
            cellEndPadding: 5,
            showCurrentTimeIndicator: true,
            timeSlotViewSettings: TimeSlotViewSettings(
              startHour: 8,
              endHour: 23,
              timeInterval: Duration(minutes: 30),
              // timeIntervalHeight: -1,
              // timeIntervalWidth: 60,
              timeFormat: "HH:mm",
              //dateFormat: '',
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
              print(dettails.appointments![0]!.nomeInsegnamento);
            },
            onSelectionChanged: (sel) {
              print(sel.date);
            },
            onViewChanged: (view) {
              if (!isSameDay(_focusedDay.value, view.visibleDates[0])) {
                setState(() {
                  _selectedDay = view.visibleDates[0];
                  //   //_focusedDay.value = focusedDay;
                });
              }
            },
          ),
        ),
      ],
    );
  }
}

class CelleDataSource extends CalendarDataSource {
  final List<Color> colors;
  CelleDataSource(List<Celle> source, this.colors) {
    appointments = source;
  }

  DateTime convertToDatime(String dateString, String timeString) {
    // Split the date string into day, month, and year
    List<String> dateComponents = dateString.split('-');

// Split the time string into hours and minutes
    List<String> timeComponents = timeString.split(':');

// Create a new DateTime object with the date and time
    DateTime dateTime = DateTime(
        int.parse(dateComponents[2]),
        int.parse(dateComponents[1]),
        int.parse(dateComponents[0]),
        int.parse(timeComponents[0]),
        int.parse(timeComponents[1]));
    return dateTime;
  }

  @override
  DateTime getStartTime(int index) {
    return convertToDatime(
        appointments![index]!.data, appointments![index]!.oraInizio!);
    //return appointments![index]!.oraInizio!;
  }

  @override
  DateTime getEndTime(int index) {
    return convertToDatime(
        appointments![index]!.data, appointments![index]!.oraFine!);
    //return appointments![index]!.oraFine!;
  }

  @override
  String getSubject(int index) {
    return appointments![index]!.nomeInsegnamento ?? appointments![index]!.nome;
  }

  @override
  Color getColor(int index) {
    return colors[index % colors.length];
  }

// @override
// Color getColor(int index) {
//   return appointments![index].background;
// }
//
// @override
// bool isAllDay(int index) {
//   return appointments![index].isAllDay;
// }
}

class _CalendarHeader extends StatelessWidget {
  final DateTime focusedDay;
  final VoidCallback onLeftArrowTap;
  final VoidCallback onRightArrowTap;
  final VoidCallback onTodayButtonTap;
  final VoidCallback onClearButtonTap;
  final bool clearButtonVisible;

  const _CalendarHeader({
    Key? key,
    required this.focusedDay,
    required this.onLeftArrowTap,
    required this.onRightArrowTap,
    required this.onTodayButtonTap,
    required this.onClearButtonTap,
    required this.clearButtonVisible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headerText = DateFormat.yMMMM().format(focusedDay);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // const SizedBox(width: 16.0),
          // SizedBox(
          //   width: 120.0,
          //   child: Text(
          //     headerText,
          //     style: TextStyle(fontSize: 26.0),
          //   ),
          // ),
          // IconButton(
          //   icon: Icon(Icons.calendar_today, size: 20.0),
          //   visualDensity: VisualDensity.compact,
          //   onPressed: onTodayButtonTap,
          // ),
          // if (clearButtonVisible)
          //   IconButton(
          //     icon: Icon(Icons.clear, size: 20.0),
          //     visualDensity: VisualDensity.compact,
          //     onPressed: onClearButtonTap,
          //   ),
          // const Spacer(),
          // IconButton(
          //   icon: Icon(Icons.chevron_left),
          //   onPressed: onLeftArrowTap,
          // ),
          // IconButton(
          //   icon: Icon(Icons.chevron_right),
          //   onPressed: onRightArrowTap,
          // ),
          SizedBox(
            //width: 120.0,
            child: Text(
              "Calendar",
              style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold),
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
              Row(
                children: [
                  ElevatedButton(
                    onPressed: onLeftArrowTap,
                    child: const Icon(
                      Icons.chevron_left,
                      size: 50,
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(0),
                    ),
                  ),
                  SizedBox(width: 15),
                  ElevatedButton(
                      onPressed: onRightArrowTap,
                      child: const Icon(
                        Icons.chevron_right,
                        size: 50,
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(0),
                      )),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
