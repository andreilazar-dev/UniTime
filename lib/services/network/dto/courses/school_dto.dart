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

part 'school_dto.g.dart';

part 'school_dto.freezed.dart';

@freezed
class SchoolDTO with _$SchoolDTO {
  const factory SchoolDTO({
    @JsonKey(name: 'label') required String label,
    @JsonKey(name: 'valore') required String valore,
  }) = _SchoolDTO;

  factory SchoolDTO.fromJson(Map<String, dynamic> json) => _$SchoolDTOFromJson(json);
}
