/*
 *  Copyright (c) 2020 - 2022
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

import 'package:freezed_annotation/freezed_annotation.dart';

part 'school.freezed.dart';

@freezed
class School with _$School {
  const factory School({
    required String label,
    required String valore,
  }) = _School;
}
