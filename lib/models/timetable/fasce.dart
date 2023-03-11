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

part 'fasce.g.dart';

part 'fasce.freezed.dart';

@freezed
class Fasce with _$Fasce {
  const factory Fasce({
    @JsonKey(name: 'label') required String label,
    @JsonKey(name: 'valore') required int valore,
  }) = _Fasce;

  factory Fasce.fromJson(Map<String, dynamic> json) => _$FasceFromJson(json);
}
