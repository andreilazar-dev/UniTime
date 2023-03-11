/*
 *  Copyright (c) 2020 - 2023
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

part of 'easter_egg_cubit.dart';

@freezed
class EasterEggState with _$EasterEggState {
  const EasterEggState._();
  const factory EasterEggState({
    @Default(EasterEgg()) EasterEgg easterEgg,
  }) = _EasterEggState;
}
