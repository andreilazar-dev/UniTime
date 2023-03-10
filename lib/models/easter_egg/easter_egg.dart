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

part 'easter_egg.g.dart';
part 'easter_egg.freezed.dart';

@freezed
class EasterEgg with _$EasterEgg {
  const factory EasterEgg({
    @Default(false) bool visibility,
    @Default(false) bool active,
  }) = _EasterEgg;

  factory EasterEgg.fromJson(Map<String, dynamic> json) =>
      _$EasterEggFromJson(json);
}
