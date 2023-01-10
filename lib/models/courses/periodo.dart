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

part 'periodo.freezed.dart';

@freezed
class Periodo with _$Periodo {
  const factory Periodo({
    required String label,
    required String valore,
    required String pub,
    required String id,
    required String aaId,
    required String facoltaCode,
  }) = _Periodo;
}
