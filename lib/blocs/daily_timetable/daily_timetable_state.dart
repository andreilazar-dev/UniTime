/*
 *  Copyright (c) 2020 - 2023
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

part of 'daily_timetable_bloc.dart';

@freezed
class DailyTimetableState with _$DailyTimetableState {
  const factory DailyTimetableState.fetching() = _FetchingDailyTimetableState;

  const factory DailyTimetableState.fetched(TimeTable timeTable) =
      _FetchedDailyTimetableState;

  const factory DailyTimetableState.error() = _ErrorDailyTimetableState;
}
