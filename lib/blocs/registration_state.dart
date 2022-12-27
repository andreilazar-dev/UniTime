/*
 *  Copyright (c) 2020 - 2022
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

part of 'registration_bloc.dart';

@freezed
class RegistrationState with _$RegistrationState {
  const factory RegistrationState.initial() = _InitialRegistrationState;
  const factory RegistrationState.perform() = _PerformRegistrationState;
  const factory RegistrationState.years(List<AcademicYear> academicYear) = _YearsRegistrationState;
  const factory RegistrationState.yearError(LocalizedError error) = _YearErrorState;
}
