/*
 *  Copyright (c) 2020 - 2023
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:school_timetable/models/easter_egg/easter_egg.dart';

part 'easter_egg_state.dart';

part 'easter_egg_cubit.freezed.dart';

class EasterEggCubit extends HydratedCubit<EasterEggState> {
  EasterEggCubit() : super(const EasterEggState());

  @override
  EasterEggState? fromJson(Map<String, dynamic> json) => EasterEggState(
        easterEgg: EasterEgg.fromJson(json['EasterEgg']),
      );

  @override
  Map<String, dynamic>? toJson(EasterEggState state) => {
        'EasterEgg': state.easterEgg.toJson(),
      };

  void setState(EasterEgg? easterEgg) =>
      emit(EasterEggState(easterEgg: easterEgg ?? const EasterEgg()));
}
