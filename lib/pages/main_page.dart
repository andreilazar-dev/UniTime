/*
 *  Copyright (c) 2020 - 2022
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_essentials_kit/extensions/commons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:school_timetable/blocs/registration_bloc.dart';

import '../models/academic_year.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: AppLocalizations.of(context)?.app_name.let((it) => Text(it)),
      ),
      body: BlocConsumer<RegistrationBloc, RegistrationState>(
        listener: (context, state) {
          state.whenOrNull(
             // initial: () => _initial(context),
              perform: () => _loading(),
              years: (years) => showYears(years),
              yearError: (error) => Container());
        },
        builder: (context,state) => BlocBuilder<RegistrationBloc, RegistrationState>(builder: (context,state)
        {
          return _initial(context);
        }),
      )
      );

  Widget _initial(BuildContext context) {
    return Container(
      child: TextButton(
        onPressed: () {
          context.read<RegistrationBloc>().yearsReq();
        },
        child: Text("date"),
      ),
    );
  }

  Widget _loading() {
    return CircularProgressIndicator();
  }

  Widget showYears(List<AcademicYear> academicYear) {
    return ListView.builder(
        itemCount: academicYear.length,
        itemBuilder: (context, index) {
          return Text(academicYear[index].label);
        });
  }
}
