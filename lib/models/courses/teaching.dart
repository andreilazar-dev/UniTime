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

part 'teaching.freezed.dart';

@unfreezed
class Teaching with _$Teaching {
  factory Teaching({
    required String label,
    required String valore,
    required String id,
    required int idPeriodo,
    required String docente,
    bool? selected,
  }) = _Teaching;
}
