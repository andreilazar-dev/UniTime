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
class RegistrationEvent with _$RegistrationEvent{
   const factory RegistrationEvent.years() = _YearsRegistrationEvent;
}
