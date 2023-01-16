/*
 *  Copyright (c) 2020 - 2023
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';
import 'package:school_timetable/models/timetable/time_table.dart';
import 'package:school_timetable/repositories/courses_repository.dart';

part 'overview_bloc.freezed.dart';
part 'overview_event.dart';
part 'overview_state.dart';

class OverviewBloc extends Bloc<OverviewEvent, OverviewState> {
  final CoursesRepository coursesRepository;

  OverviewBloc({required this.coursesRepository})
      : super(OverviewState.fetching()) {
    on<_LoadOverviewEvent>(_onLoading);
  }

  Future<void> _onLoading(
      _LoadOverviewEvent event, Emitter<OverviewState> emit) async {
    try {
      final timetable = await coursesRepository.lessons(event.date);

      emit(OverviewState.fetched(timetable));
      //emit(DailyTimetableState.fetched());

    } catch (error) {
      //TODO : EXCEPTION
      throw Exception(error);
    }
  }

  void loadTimetable(DateTime date) => add(_LoadOverviewEvent(date));
}
