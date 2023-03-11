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
import 'package:school_timetable/models/academic_year.dart';
import 'package:school_timetable/models/courses/year.dart';

part 'selected_course.g.dart';

part 'selected_course.freezed.dart';

@unfreezed
class SelectedCourse with _$SelectedCourse {
  factory SelectedCourse({
    required String label,
    required String corso,
    // //si puo compporre
    // required String textcurr,
    // //same
    // required List<String> anno2,
    required AcademicYear anno,
    required List<Year> years,
  }) = _SelectedCourse;

  factory SelectedCourse.fromJson(Map<String, dynamic> json) =>
      _$SelectedCourseFromJson(json);
}
//agendastudentiunipd.easystaff.it/index.php?
// view=easycourse
// &form-type=corso
// &include=corso
// &txtcurr=1+-+Percorso+comune
// &anno=2022&scuola=ScuoladiAgrariaeMedicinaVeterinaria
// &corso=AV2378
// &anno2%5B%5D=000ZZ%7C1
// &date=21-01-2023
// &periodo_didattico=
// &_lang=it
// &list=
// &week_grid_type=-1
// &ar_codes_=&ar_select_=
// &col_cells=0&empty_box=0
// &only_grid=0
// &highlighted_date=0
// &all_events=0
// &faculty_group=0
