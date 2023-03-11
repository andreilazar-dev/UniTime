/*
 *  Copyright (c) 2020 - 2023
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

part of 'filter_modules_bloc.dart';

@freezed
class FilterModulesEvent with _$FilterModulesEvent {
  const factory FilterModulesEvent.load() = _LoadFilterModulesEvent;
  const factory FilterModulesEvent.save(Configuration data) =
      _SaveFilterModulesEvent;
}
