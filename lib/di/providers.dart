/*
 *  Copyright (c) 2020 - 2022
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

part of 'dependency_injector.dart';

final List<SingleChildWidget> _providers = [
  Provider<PrettyDioLogger>(
      create: (context) => PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            compact: true,
            responseBody: false,
          )),
  Provider<Dio>(create: (context) {
    final dio = Dio();
    //Interceptors
    dio.interceptors.addAll([
      context.read<PrettyDioLogger>(),
    ]);
    return dio;
  }),
  Provider<Server>(create: (context) => Server()),
  Provider<UniversityInformationService>(
      create: (context) => UniversityInformationService(context.read(),
          baseUrl: context.read<Server>().univrBaseUrl)),
];
