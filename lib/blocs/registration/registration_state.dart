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
  const factory RegistrationState.checking() = _CheckingRegistrationState;
  const factory RegistrationState.registered() = _RegisteredRegistrationState;
  const factory RegistrationState.notRegistered() = _NotRegisteredRegistrationState;
  const factory RegistrationState.reset() = _ResetRegistrationState;
  const factory RegistrationState.error() = _ErrorRegistrationState;
}
