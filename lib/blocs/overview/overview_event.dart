/*
 *  Copyright (c) 2020 - 2023
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

part of 'overview_bloc.dart';

@freezed
class OverviewEvent with _$OverviewEvent {
  const factory OverviewEvent.load(DateTime date) = _LoadOverviewEvent;
}
