/*
 *  Copyright (c) 2020 - 2023
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

import 'package:school_timetable/models/timetable/celle.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';

class CelleDataSource extends CalendarDataSource {
  final List<Color> colors;

  CelleDataSource(List<Celle> source, this.colors) {
    appointments = source;
  }

  DateTime convertToDatime(String dateString, String timeString) {
    // Split the date string into day, month, and year
    List<String> dateComponents = dateString.split('-');

// Split the time string into hours and minutes
    List<String> timeComponents = timeString.split(':');

// Create a new DateTime object with the date and time
    DateTime dateTime = DateTime(
        int.parse(dateComponents[2]),
        int.parse(dateComponents[1]),
        int.parse(dateComponents[0]),
        int.parse(timeComponents[0]),
        int.parse(timeComponents[1]));
    return dateTime;
  }

  @override
  DateTime getStartTime(int index) {
    return convertToDatime(
        appointments![index]!.data, appointments![index]!.oraInizio!);
  }

  @override
  DateTime getEndTime(int index) {
    return convertToDatime(
        appointments![index]!.data, appointments![index]!.oraFine!);
  }

  @override
  String getSubject(int index) {
    return appointments![index]!.nomeInsegnamento ?? appointments![index]!.nome;
  }

  @override
  Color getColor(int index) {
    return colors[index % colors.length];
  }
}