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
import 'package:school_timetable/blocs/settings/filter_modules/filter_modules_bloc.dart';
import 'package:school_timetable/models/preferences/configuration.dart';
import 'package:school_timetable/repositories/configuration_repository.dart';

part 'manage_courses_bloc.freezed.dart';

part 'manage_courses_event.dart';

part 'manage_courses_state.dart';

class ManageCoursesBloc extends Bloc<ManageCoursesEvent, ManageCoursesState> {
  final ConfigurationRepository repository;

  ManageCoursesBloc({required this.repository})
      : super(ManageCoursesState.fetching()) {
    on<_LoadManageCoursesEvent>(_onLoading);
    on<_SaveManageCoursesEvent>(_onSaveChanges);
  }

  Future<void> _onLoading(
      _LoadManageCoursesEvent event, Emitter<ManageCoursesState> emit) async {
    emit(ManageCoursesState.fetching());
    try {
      final data = await repository.ConfigurationData;
      if (data != null) {
        emit(ManageCoursesState.fetched(data));
      }
    } catch (error) {
      //TODO : EXCEPTION
      throw Exception(error);
    }
  }

  Future<void> _onSaveChanges(
      _SaveManageCoursesEvent event, Emitter<ManageCoursesState> emit) async {
    emit(ManageCoursesState.fetching());
    try {
      if (await repository.setConfigurationData(event.data)) {
        emit(ManageCoursesState.saved());
      }
    } catch (error) {
      //TODO : EXCEPTION
      throw Exception(error);
    }
  }

  void loadData() => add(_LoadManageCoursesEvent());

  void saveChanges(Configuration data) => add(_SaveManageCoursesEvent(data));
}
