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

final List<RepositoryProvider> _repositories = [
  // TODO: add here your repositories with RepositoryProvider
  RepositoryProvider<CoursesRepository>(
      create: (context) => CoursesRepository(
          universityInformationService: context.read<UniversityInformationService>(),
          coursesMapper: context.read<CoursesMapper>(),
          academicYearMapper: context.read<AcademicYearMapper>()))
];
