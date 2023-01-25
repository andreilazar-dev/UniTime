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
import 'package:school_timetable/misc/server/servers.dart';
import 'package:school_timetable/models/preferences/configuration.dart';

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
    on<_ResetRegistrationEvent>(_onReset);
  }

  Future<void> _onCheck(
      _CheckRegistrationEvent event, Emitter<RegistrationState> emit) async {
    try {
      final config = await repository.ConfigurationData;
      emit(config != null
          ? RegistrationState.registered(
              Servers.servers
                  .firstWhere((element) => element.code == config.university)
                  .server,
              config)
          : const RegistrationState.notRegistered());
    } catch (error) {
      emit(RegistrationState.error());
    }

    //on LocalizedError catch (error) {}
  }

  Future<void> _onReset(
      _ResetRegistrationEvent event, Emitter<RegistrationState> emit) async {
    try {
      final removed = await repository.removeConfigurationData();
      emit(removed
          ? RegistrationState.notRegistered()
          : RegistrationState.error());
    } catch (error) {
      emit(RegistrationState.error());
    }

    //on LocalizedError catch (error) {}
  }

  void checkRegistration() => add(const _CheckRegistrationEvent());

  void resetApp() => add(const _ResetRegistrationEvent());
}
