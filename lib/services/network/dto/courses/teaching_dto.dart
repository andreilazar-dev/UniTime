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

part 'teaching_dto.g.dart';

part 'teaching_dto.freezed.dart';

@freezed
class TeachingDTO with _$TeachingDTO{
  const factory TeachingDTO({
    @JsonKey(name: 'label') required String label,
    @JsonKey(name: 'valore') required  String valore,
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'id_periodo') required int idPeriodo,
    @JsonKey(name: 'docente') required String docente,
  }) = _TeachingDTO;

  factory TeachingDTO.fromJson(Map<String, dynamic> json) => _$TeachingDTOFromJson(json);
}