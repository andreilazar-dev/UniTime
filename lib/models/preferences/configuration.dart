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
import 'package:school_timetable/models/preferences/selected_course.dart';

part 'configuration.g.dart';
part 'configuration.freezed.dart';

@freezed
class Configuration with _$Configuration {
  const factory Configuration({
    required String university,
    required List<SelectedCourse> selectedCourses,
  }) = _Configuration;

  factory Configuration.fromJson(Map<String, dynamic> json) =>
      _$ConfigurationFromJson(json);
}
