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
import 'package:school_timetable/models/preferences/configuration.dart';
import 'package:school_timetable/repositories/configuration_repository.dart';

part 'filter_modules_bloc.freezed.dart';

part 'filter_modules_event.dart';

part 'filter_modules_state.dart';

class FilterModulesBloc extends Bloc<FilterModulesEvent, FilterModulesState> {
  final ConfigurationRepository repository;

  FilterModulesBloc({required this.repository})
      : super(FilterModulesState.fetching()) {
    on<_LoadFilterModulesEvent>(_onLoading);
    on<_SaveFilterModulesEvent>(_onSaveChanges);
  }

  Future<void> _onLoading(
      _LoadFilterModulesEvent event, Emitter<FilterModulesState> emit) async {
    emit(FilterModulesState.fetching());
    try {
      final data = await repository.ConfigurationData;
      if (data != null) {
        emit(FilterModulesState.fetched(data));
      }
    } catch (error) {
      //TODO : EXCEPTION
      throw Exception(error);
    }
  }

  Future<void> _onSaveChanges(
      _SaveFilterModulesEvent event, Emitter<FilterModulesState> emit) async {
    emit(FilterModulesState.fetching());
    try {
      if (await repository.setConfigurationData(event.data)) {
        emit(FilterModulesState.saved());
      }
    } catch (error) {
      //TODO : EXCEPTION
      throw Exception(error);
    }
  }

  void loadData() => add(_LoadFilterModulesEvent());

  void saveChanges(Configuration data) => add(_SaveFilterModulesEvent(data));
}
