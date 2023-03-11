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
class FilterModulesState with _$FilterModulesState {
  const factory FilterModulesState.fetching() = FetchingFilterModulesState;

  const factory FilterModulesState.fetched(Configuration data) =
      FetchedFilterModulesState;
  const factory FilterModulesState.saved() = SavedFilterModulesState;
  const factory FilterModulesState.error() = ErrorFilterModulesState;
}
