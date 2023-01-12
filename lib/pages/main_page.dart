/*
 *  Copyright (c) 2020 - 2022
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_timetable/blocs/registration/registration_bloc.dart';
import 'package:school_timetable/repositories/courses_repository.dart';
import 'package:school_timetable/routers/app_router.gr.dart';

import '../services/network/university_information_service.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => WillPopScope(
        onWillPop: () async => false,
        child: BlocConsumer<RegistrationBloc, RegistrationState>(
          listener: (context, state) => state.whenOrNull(
            registered: (baseUrl, config) {
              context
                  .read<UniversityInformationService>()
                  .setServer(server: baseUrl);
              context.read<CoursesRepository>().setConfiguration(config);
              _goToPage(context, HomeRoute());
            },
            notRegistered: () => _goToPage(context, RegistrationHomeRoute()),
            reset: () {},
          ),
          builder: (context, state) => Scaffold(
            body: state.whenOrNull(
                checking: () =>
                    Center(child: const CircularProgressIndicator())),
          ),
        ),
      );

  Future<void> _goToPage(BuildContext context, PageRouteInfo route) async {
    context.router.popUntilRouteWithName(MainRoute.name);
    await context.pushRoute(route);
  }
}
