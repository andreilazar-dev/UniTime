/*
 *  Copyright (c) 2020 - 2022
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:school_timetable/errors/network_error.dart';
import 'package:school_timetable/services/network/responses/courses/course_list_response.dart';
import 'package:school_timetable/services/network/dto/courses/year_dto.dart';
import 'package:school_timetable/services/network/responses/years/years_response.dart';
import 'package:school_timetable/services/network/dto/years/academic_year_dto.dart';
import 'package:school_timetable/services/network/misc/json_scrubber.dart';

import 'dto/time_table/time_table_dto.dart';

class UniversityInformationService {
  String? _baseUrl;
  final Dio dio;

  UniversityInformationService(this.dio);

  setServer({required String server}) {
    if (server.isNotEmpty) {
      _baseUrl = server;
    }
  }

  Future<List<AcademicYearDTO>> academicYear({
    String sw = 'ec_',
    String aa = '1',
  }) async {
    // const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'sw': sw,
      r'aa': aa,
    };
    //final _headers = <String, dynamic>{};
    // final _data = <String, dynamic>{};
    try {
      final result =
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
              .copyWith(baseUrl: _baseUrl)));

      final value = List<AcademicYearDTO>.from(
          JsonScrubber.academicYear(result.data!)
              .map((dto) => AcademicYearDTO.fromJson(dto)));
      return value;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.response == null) {
        log("Connection NetworkError",
            name: "UniversityInformationService academicYear");
      } else {
        log("Generic NetworkError",
            name: "UniversityInformationService academicYear",
            stackTrace: e.stackTrace);
      }
      throw NetworkError(e.response.hashCode, e.response?.statusMessage ?? "");
    }
  }

  Future<CourseListResponse> courseList({
    String sw = 'ec_',
    required String aa, //year
    String page = 'corsi',
  }) async {
    // const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'sw': sw,
      r'aa': aa,
      r'page': page,
    };
    //final _headers = <String, dynamic>{};
    // final _data = <String, dynamic>{};
    try {
      final result =
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
              .copyWith(baseUrl: _baseUrl)));
      final value = JsonScrubber.courses(result.data!);
      return CourseListResponse.fromJson(value);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.response == null) {
        log("Connection NetworkError",
            name: "UniversityInformationService courseList");
      } else {
        log("Generic NetworkError",
            name: "UniversityInformationService courseList",
            stackTrace: e.stackTrace);
      }
      throw NetworkError(e.response.hashCode, e.response?.statusMessage ?? "");
    }
  }

  Future<List<YearDTO>> yearList({
    String key = '_ec_elenco_anno2_',
    required String code,
    required String academicYear, //year
    required String courseValue,
  }) async {
    // const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'key': '${code}_$academicYear$key$courseValue',
    };
    //final _headers = <String, dynamic>{};
    // final _data = <String, dynamic>{};
    try {
      final result =
          await dio.fetch<String>(_setStreamType<CourseListResponse>(Options(
        method: 'GET',
        // headers: _headers,
        // extra: _extra,
      )
              .compose(
                dio.options,
                '/call_redis.php',
                queryParameters: queryParameters,
                //data: _data,
              )
              .copyWith(baseUrl: _baseUrl)));
      // final value = List<YearDTO>.from(
      //     JsonScrubber.years(_result.data!).map((dto) => YearDTO.fromJson(dto)));
      final value = YearsResponse.fromJson(JsonScrubber.years(result.data!));
      return value.elencoAnni;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.response == null) {
        log("Connection NetworkError",
            name: "UniversityInformationService yearList");
      } else {
        log("Generic NetworkError",
            name: "UniversityInformationService yearList",
            stackTrace: e.stackTrace);
      }
      throw NetworkError(e.response.hashCode, e.response?.statusMessage ?? "");
    }
  }

  Future<TimeTableDTO> timetable({
    String view = 'easycourse',
    String include = 'corso',
    required String textcurr,
    required String anno,
    required String corso,
    required List<String> anno2,
    required String date,
    String lang = 'it',
    String highlightedDate = '0',
    String allEvents = '0',
  }) async {
    const extra = <String, dynamic>{};
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
    final headers = <String, dynamic>{};
    final data = <String, dynamic>{};
    try {
      final response = await dio
          .fetch<Map<String, dynamic>>(_setStreamType<TimeTableDTO>(Options(
        method: 'POST',
        headers: headers,
        extra: extra,
      )
              .compose(
                dio.options,
                '/grid_call.php',
                queryParameters: queryParameters,
                data: data,
              )
              .copyWith(baseUrl: _baseUrl ?? dio.options.baseUrl)));
      if (response.statusCode! < 200 || response.statusCode! > 299) {
        throw NetworkError(response.statusCode!, response.statusMessage);
      }
      return TimeTableDTO.fromJson(response.data!);
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.response == null) {
        log("Connection NetworkError",
            name: "UniversityInformationService Timetable");
      } else {
        log("Generic NetworkError",
            name: "UniversityInformationService Timetable",
            stackTrace: e.stackTrace);
      }
      throw NetworkError(e.response.hashCode, e.response?.statusMessage ?? "");
    }
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
