/*
 *  Copyright (c) 2020 - 2022
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */
import 'dart:convert';
import 'package:school_timetable/misc/server/server.dart';
import 'package:school_timetable/models/preferences/selected_course.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:school_timetable/models/courses/course.dart';
import 'package:school_timetable/models/preferences/configuration.dart';
import 'package:school_timetable/models/academic_year.dart';

const _kAppConfiguration = "APP_CONFIGURATION";

class ConfigurationRepository {
  final Future<SharedPreferences> sharedPreferences;
  String? _serverCode;
  AcademicYear? _academicYear;

  ConfigurationRepository({required this.sharedPreferences});

  Future<Configuration?> get ConfigurationData async {
    final prefs = (await sharedPreferences).getString(_kAppConfiguration);
    if (prefs != null) {
      return Configuration.fromJson(json.decode(prefs));
    }
    return null;
  }

  Future<void> setAcademic(AcademicYear academicYear) async =>
      this._academicYear = academicYear;

  Future<void> setServer(Server server) async => this._serverCode = server.code;

  Future<bool> setConfiguration(Course config) async {
    var configurationData = await ConfigurationData;
    if (configurationData != null) {
      //TODO merge
      return true;
    } else {
      var data = Configuration(university: _serverCode ?? '', selectedCourses: [
        SelectedCourse(
          corso: config.valore,
          textcurr: config.years.map((e) => e.label).join(),
          anno2: config.years.map((e) => e.valore).toList(),
          anno: _academicYear!,
        )
      ]);
      return (await sharedPreferences)
          .setString(_kAppConfiguration, json.encode(data));
    }
  }
}
