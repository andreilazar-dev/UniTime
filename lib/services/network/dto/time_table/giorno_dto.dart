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


part 'giorno_dto.g.dart';

part 'giorno_dto.freezed.dart';

@freezed
class GiornoDTO with _$GiornoDTO{
  const factory GiornoDTO({
    @JsonKey(name: 'label') required String label,
    @JsonKey(name: 'valore') required int valore,
    @JsonKey(name: 'data') required String data,
  }) = _GiornoDTO;

  factory GiornoDTO.fromJson(Map<String, dynamic> json) => _$GiornoDTOFromJson(json);
}
