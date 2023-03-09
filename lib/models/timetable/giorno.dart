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

part 'giorno.g.dart';

part 'giorno.freezed.dart';

@freezed
class Giorno with _$Giorno {
  const factory Giorno({
    required String label,
    required int valore,
    required String data,
  }) = _Giorno;

  factory Giorno.fromJson(Map<String, dynamic> json) => _$GiornoFromJson(json);
}
