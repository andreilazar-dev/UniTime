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

part 'legenda.g.dart';

part 'legenda.freezed.dart';

@freezed
class Legenda with _$Legenda {
  const factory Legenda({
    String? codice,
    String? nome,
    String? spunta,
    String? tipo,
  }) = _Legenda;

  factory Legenda.fromJson(Map<String, dynamic> json) =>
      _$LegendaFromJson(json);
}
