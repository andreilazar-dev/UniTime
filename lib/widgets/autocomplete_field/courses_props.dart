/*
 *  Copyright (c) 2020 - 2023
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

import 'package:flutter/material.dart';
import 'package:school_timetable/widgets/autocomplete_field/field_props.dart';
import 'package:school_timetable/models/courses/course.dart';

class CoursesProps extends FieldProps<Course> {
  List<Course> courses;

  CoursesProps(
      {required this.courses,
      required super.onSelected,
      super.suffixIcon,
      super.labelText});

  @override
  List<Course> getSuggestions(String pattern) {
    final suggestions = courses.where((Course element) {
      final elementLower = element.label.toLowerCase();
      final queryLower = pattern.toLowerCase();
      return elementLower.contains(queryLower);
    });
    return suggestions.toList();
  }

  @override
  void setSelected(Course select, TextEditingController textEditingController) {
    Course selectedValue = courses.firstWhere((element) {
      return element == select;
    });
    textEditingController.text = selectedValue.label;
    onSelected!(selectedValue);
  }

  @override
  Widget itemBuilder(BuildContext context, Course suggestion) {
    return ListTile(
      title: Text(
        suggestion.label,
        style: const TextStyle(
          color: Color(0xFFFFFFFC),
          fontFamily: 'Roboto',
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
