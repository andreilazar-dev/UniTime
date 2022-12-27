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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:school_timetable/blocs/registration_bloc.dart';
import 'package:school_timetable/misc/server/server.dart';
import 'package:school_timetable/repositories/courses_repository.dart';
import 'package:school_timetable/repositories/mappers/accademic_year.dart';
import 'package:school_timetable/repositories/mappers/courses_mapper.dart';
import 'package:school_timetable/services/network/university_information_service.dart';
import 'package:school_timetable/theme/cubits/theme_cubit.dart';

part 'blocs.dart';
part 'mappers.dart';
part 'providers.dart';
part 'repositories.dart';

class DependencyInjector extends StatelessWidget {
  final Widget child;

  const DependencyInjector({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (_mappers.isNotEmpty ?? false) {
      return MultiProvider(
        providers: _mappers,
        child: _providersWidget,
      );
    }

    return _providersWidget;
  }

  Widget get _providersWidget {
    if (_providers.isNotEmpty ?? false) {
      return MultiProvider(
        providers: _providers,
        child: _repositoriesWidget,
      );
    }

    return _repositoriesWidget;
  }

  Widget get _repositoriesWidget {
    if (_repositories.isNotEmpty ?? false) {
      return MultiRepositoryProvider(
        providers: _repositories,
        child: _blocsWidget,
      );
    }

    return _blocsWidget;
  }

  Widget get _blocsWidget {
    if (_blocs.isNotEmpty ?? false) {
      return MultiBlocProvider(
        providers: _blocs,
        child: child,
      );
    }

    return child;
  }
}