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


part 'fasce_dto.g.dart';

part 'fasce_dto.freezed.dart';

@freezed
class FasceDTO with _$FasceDTO{
  const factory FasceDTO({
    @JsonKey(name: 'label') required String label,
    @JsonKey(name: 'valore') required int valore,
  }) = _FasceDTO;

  factory FasceDTO.fromJson(Map<String, dynamic> json) => _$FasceDTOFromJson(json);
}
