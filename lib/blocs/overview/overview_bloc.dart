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

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_essentials_kit/errors/localized_error.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:school_timetable/errors/connection_errors.dart';
import 'package:school_timetable/errors/generic_error.dart';
import 'package:school_timetable/errors/repository_error.dart';
import 'package:school_timetable/models/timetable/celle.dart';
import 'package:school_timetable/models/timetable/time_table.dart';
import 'package:school_timetable/repositories/courses_repository.dart';

part 'overview_bloc.freezed.dart';

part 'overview_event.dart';

part 'overview_state.dart';

class OverviewBloc extends Bloc<OverviewEvent, OverviewState> {
  final CoursesRepository coursesRepository;

  OverviewBloc({required this.coursesRepository})
      : super(const OverviewState.fetching()) {
    on<_LoadOverviewEvent>(_onLoading);
  }

  Future<void> _onLoading(
      _LoadOverviewEvent event, Emitter<OverviewState> emit) async {
    emit(const OverviewState.fetching());
    try {
      final timetable = await coursesRepository.lessons(event.date);
      //TODO: need refactor
      List<Celle> celle = [];
      for (TimeTable obj in timetable) {
        celle.addAll(obj.celle ?? []);
      }
      emit(OverviewState.fetched(timetable[0].copyWith(celle: celle)));
    } on RepositoryError catch (_) {
      emit(OverviewState.error(ConnectionError()));
    } catch (error) {
      emit(OverviewState.error(GenericError()));
    }
  }

  void loadTimetable(DateTime date) => add(_LoadOverviewEvent(date));
}
