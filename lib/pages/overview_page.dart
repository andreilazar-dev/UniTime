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
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_essentials_kit/errors/localized_error.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:school_timetable/blocs/overview/overview_bloc.dart';
import 'package:school_timetable/misc/date_util.dart';
import 'package:school_timetable/models/celle_data_source.dart';
import 'package:school_timetable/models/timetable/time_table.dart';
import 'package:school_timetable/widgets/event_details.dart';
import 'package:school_timetable/widgets/header_calendar.dart';
import 'package:school_timetable/widgets/loading_widget.dart';
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
  late DateTime _kFirstDay;
  late DateTime _kLastDay;
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime? _selectedDay;
  late PageController _pageController;
  final ValueNotifier<DateTime> _focusedDay = ValueNotifier(DateTime.now());
  final DateFormat _inputDateFormat = DateFormat('dd-MM-yyyy');
  final CalendarController _timeLineController = CalendarController();

  final List<Color> _colors = [
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<OverviewBloc, OverviewState>(
        listener: (context, state) => state.whenOrNull(
          error: (error) => showError(context, error),
        ),
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
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    },
                    onRightArrowTap: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
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
                //TODO: cancel this when set initializeDateFormatting for intl
                locale: Localizations.localeOf(context).languageCode,
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
                    if (_selectedDay != null &&
                        !AppDateUtils.isSameWeek(_selectedDay!, selectedDay)) {
                      context.read<OverviewBloc>().loadTimetable(selectedDay);
                      SchedulerBinding.instance
                          .addPostFrameCallback((duration) {
                        _timeLineController.displayDate = _focusedDay.value;
                      });
                    }
                    // Call `setState()` when updating the selected day
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay.value = focusedDay;
                    });
                    _timeLineController.displayDate = _focusedDay.value;
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
                const Expanded(child: LoadingWidget()),
              if (overviewState is FetchedOverviewState)
                _timeline(context, overviewState.timeTable),
              if (overviewState is ErrorOverviewState) _error(context),
            ],
          );
        },
      ),
    );
  }

  Widget _error(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Expanded(
      child: Center(
        child: SizedBox(
            height: mediaQuery.size.height * 0.3,
            child: Image.asset(
              'assets/images/notices/error.png',
              fit: BoxFit.contain,
            )),
      ),
    );
  }

  Widget _timeline(BuildContext context, TimeTable timeTable) {
    //_timeLineController.displayDate = _focusedDay.value;
    // if (_timeLineController.displayDate != null &&
    //     !AppDateUtils.isSameWeek(
    //         _timeLineController.displayDate!, _focusedDay.value)) {
    //   _timeLineController.displayDate = _focusedDay.value;
    // }
    return Expanded(
      child: SfCalendar(
        view: CalendarView.day,
        controller: _timeLineController,
        headerHeight: 0,
        viewHeaderHeight: 0,
        cellEndPadding: 5,
        showCurrentTimeIndicator: true,
        minDate: _inputDateFormat.parse(timeTable.firstDay),
        maxDate: _inputDateFormat.parse(timeTable.lastDay),
        timeSlotViewSettings: TimeSlotViewSettings(
          startHour: 8,
          endHour: 23,
          timeInterval: const Duration(minutes: 30),
          //timeIntervalHeight: -1,
          // timeIntervalWidth: 60,
          timeFormat: "HH:mm",
          numberOfDaysInView: 1,
          // nonWorkingDays: const <int>[DateTime.monday, DateTime.friday],
          timeTextStyle: Theme.of(context).textTheme.headlineSmall,
        ),
        dataSource: CelleDataSource(timeTable.celle!, _colors),
        onTap: (details) {
          if (details.appointments != null) {
            showCupertinoModalBottomSheet(
              expand: false,
              context: context,
              backgroundColor: Colors.white,
              builder: (context) => EventDetails(
                cell: details.appointments![0],
              ),
            );
          }
        },
        onViewChanged: (view) {
          if (!isSameDay(_focusedDay.value, view.visibleDates[0])) {
            SchedulerBinding.instance.addPostFrameCallback((duration) {
              setState(() {
                _selectedDay = view.visibleDates[0];
              });
            });
          } else if (_selectedDay != null &&
              !isSameDay(_focusedDay.value, _selectedDay)) {
            setState(() {
              _selectedDay = view.visibleDates[0];
            });
          }
        },
      ),
    );
  }
}
