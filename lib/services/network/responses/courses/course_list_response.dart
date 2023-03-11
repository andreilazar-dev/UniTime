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
import 'package:school_timetable/services/network/dto/courses/school_dto.dart';
import '../../dto/courses/course_dto.dart';

part 'course_list_response.g.dart';

part 'course_list_response.freezed.dart';

//@Freezed(toJson: false)
@freezed
class CourseListResponse with _$CourseListResponse {
  const factory CourseListResponse({
    @JsonKey(name: 'elenco_corsi') required List<CourseDTO> elencoCorsi,
    @JsonKey(name: 'elenco_scuole') List<SchoolDTO>? elencoScuole,
  }) = _CourseListResponse;

  factory CourseListResponse.fromJson(Map<String, dynamic> json) =>
      _$CourseListResponseFromJson(json);
}
