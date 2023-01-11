/*
 *  Copyright (c) 2020 - 2022
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

import '../../repositories/configuration_repository.dart';

part 'registration_bloc.freezed.dart';

part 'registration_event.dart';

part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final ConfigurationRepository repository;

  RegistrationBloc({
    required this.repository,
  }) : super(RegistrationState.checking()) {
    on<_CheckRegistrationEvent>(_onCheck);
  }

  Future<void> _onCheck(
      _CheckRegistrationEvent event, Emitter<RegistrationState> emit) async {
    try {
      final config = await repository.ConfigurationData;
      emit(config != null
          ? RegistrationState.registered()
          : const RegistrationState.notRegistered());
    } catch (error) {
      emit(RegistrationState.error());
    }
  }

  void checkRegistration() => add(const _CheckRegistrationEvent());

  void fakerCheck() => emit(RegistrationState.registered());
}
