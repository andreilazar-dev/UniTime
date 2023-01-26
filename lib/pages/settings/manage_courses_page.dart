/*
 *  Copyright (c) 2020 - 2023
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_timetable/blocs/registration/registration_bloc.dart';
import 'package:school_timetable/blocs/settings/manage_courses/manage_courses_bloc.dart';
import 'package:school_timetable/models/preferences/configuration.dart';
import 'package:school_timetable/routers/app_router.gr.dart';
import 'package:school_timetable/widgets/course_label.dart';
import 'package:school_timetable/widgets/loading_widget.dart';

class ManageCoursesPage extends StatefulWidget with AutoRouteWrapper {
  const ManageCoursesPage({Key? key}) : super(key: key);

  @override
  State<ManageCoursesPage> createState() => _ManageCoursesPageState();

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<ManageCoursesBloc>(
        create: (context) =>
            ManageCoursesBloc(repository: context.read())..loadData(),
        child: this,
      );
}

class _ManageCoursesPageState extends State<ManageCoursesPage> {
  Configuration data = const Configuration(university: "", selectedCourses: []);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _goBack();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                _goBack();
              }),
          title: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              AppLocalizations.of(context)?.settings_manage_courses ?? '',
              style: const TextStyle(
                fontSize: 25,
                fontFamily: 'Roboto-Medium',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        body: BlocConsumer<ManageCoursesBloc, ManageCoursesState>(
          listener: (ctx, state) => state.whenOrNull(
              saved: () => _savedMessage(ctx),
              fetched: (data) {
                setState(() {
                  this.data = data;
                });
                return null;
              }),
          builder: (ctx, state) {
            return state.maybeWhen(
              // fetched: (data) => _body(ctx, data),
              fetching: () => const LoadingWidget(),
              orElse: () => _body(ctx, data),
            );
          },
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 60,
            child: FittedBox(
              child: FloatingActionButton.extended(
                onPressed: () {
                  context.router.replace(RegistrationDetailsRoute());
                },
                backgroundColor: const Color.fromRGBO(114, 114, 186, 1),
                label: const Text('Course'),
                icon: const Icon(Icons.add),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _goBack() {
    context.read<RegistrationBloc>().checkRegistration();
  }

  void _savedMessage(BuildContext ctx) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 6.0,
        behavior: SnackBarBehavior.floating,
        content: Text(
          AppLocalizations.of(context)?.modules_saved_dialog ?? '',
          textAlign: TextAlign.center,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        duration: const Duration(milliseconds: 1000),
      ),
    );
  }

  Widget _body(BuildContext ctx, Configuration data) {
    return ListView.builder(
        itemCount: data.selectedCourses.length,
        itemBuilder: (context, index) {
          return ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: data.selectedCourses[index].years.length,
              itemBuilder: (_, indexYears) {
                return Dismissible(
                  background: const Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.restore_from_trash_sharp,
                      size: 45,
                      color: Colors.redAccent,
                    ),
                  ),
                  key: Key(data.selectedCourses[index].corso),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (dismissDirection) {
                    data.selectedCourses[index].years.removeAt(indexYears);
                    context.read<ManageCoursesBloc>().saveChanges(data);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CourseLabel(
                      courseName: data.selectedCourses[index].label,
                      studyYear:
                          data.selectedCourses[index].years[indexYears].label,
                      year: data.selectedCourses[index].anno.label,
                    ),
                  ),
                );
              });
        });
  }
}
