/*
 *  Copyright (c) 2020 - 2022
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

import 'package:dio/dio.dart';
import 'package:school_timetable/models/courses.dart';
import 'package:school_timetable/services/network/dto/courses/course_list_response.dart';
import 'package:school_timetable/services/network/dto/years/academic_year_dto.dart';
import 'package:school_timetable/services/network/misc/json_scrubber.dart';

import 'dto/time_table/time_table_dto.dart';

class UniversityInformationService {
  String baseUrl;
  final Dio dio;

  UniversityInformationService(this.dio, {required this.baseUrl});

  Future<List<AcademicYearDTO>> academicYear({
    String sw = 'ec_',
    String aa = '1',
    String code = '1671565561577',
  }) async {
    // const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'sw': sw,
      r'aa': aa,
      r'_': code,
    };
    //final _headers = <String, dynamic>{};
    // final _data = <String, dynamic>{};
    final _result =
        await dio.fetch<String>(_setStreamType<AcademicYearDTO>(Options(
      method: 'GET',
      // headers: _headers,
      // extra: _extra,
    )
            .compose(
              dio.options,
              '/combo.php',
              queryParameters: queryParameters,
              //data: _data,
            )
            .copyWith(baseUrl: baseUrl)));

    final value = List<AcademicYearDTO>.from(
        JsonScrubber.academicYear(_result.data!)
            .map((dto) => AcademicYearDTO.fromJson(dto)));
    return value;
  }

  Future<CourseListResponse> courseList({
    String sw = 'ec_',
    required String aa, //year
    String page = 'corsi',
    String code = '1671565561577',
  }) async {
    // const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'sw': sw,
      r'aa': aa,
      r'page': page,
      r'_': code,
    };
    //final _headers = <String, dynamic>{};
    // final _data = <String, dynamic>{};
    final _result =
        await dio.fetch<String>(_setStreamType<CourseListResponse>(Options(
      method: 'GET',
      // headers: _headers,
      // extra: _extra,
    )
            .compose(
              dio.options,
              '/combo.php',
              queryParameters: queryParameters,
              //data: _data,
            )
            .copyWith(baseUrl: baseUrl)));
    final value =
        CourseListResponse.fromJson(JsonScrubber.courses(_result.data!));
    return value;
  }

  Future<TimeTableDTO> timetable({
    String view = 'easycourse',
    String include = 'corso',
    required String textcurr ,
    required String anno ,
    required String corso ,
    required List<String> anno2 ,
    required String date ,
    String lang = 'it',
    String highlightedDate = '0',
    String allEvents = '1',
  }) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'view': view,
      r'include': include,
      r'txtcurr': textcurr,
      r'anno': anno,
      r'corso': corso,
      r'anno2[]': anno2,
      r'date': date,
      r'_lang': lang,
      r'highlighted_date': highlightedDate,
      r'all_events': allEvents,
    };
    // anno2.forEach((element) {
    //   queryParameters["r'anno2'"] = element;
    // });
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await dio
        .fetch<Map<String, dynamic>>(_setStreamType<TimeTableDTO>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
        .compose(
      dio.options,
      '/grid_call.php',
      queryParameters: queryParameters,
      data: _data,
    )
        .copyWith(baseUrl: baseUrl ?? dio.options.baseUrl)));
    final value = TimeTableDTO.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
