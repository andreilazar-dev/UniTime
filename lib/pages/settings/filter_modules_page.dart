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
import 'package:school_timetable/blocs/settings/filter_modules/filter_modules_bloc.dart';
import 'package:school_timetable/models/preferences/configuration.dart';
import 'package:school_timetable/routers/app_router.gr.dart';
import 'package:school_timetable/widgets/background_card.dart';
import 'package:school_timetable/widgets/custom_checbox_list_tile.dart';
import 'package:school_timetable/widgets/custon_floating_action_button.dart';
import 'package:school_timetable/widgets/loading_widget.dart';

class FilterModulesPage extends StatefulWidget with AutoRouteWrapper {
  const FilterModulesPage({Key? key}) : super(key: key);

  @override
  State<FilterModulesPage> createState() => _FilterModulesPageState();

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<FilterModulesBloc>(
        create: (context) =>
            FilterModulesBloc(repository: context.read())..loadData(),
        child: this,
      );
}

class _FilterModulesPageState extends State<FilterModulesPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _showDialog();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                _showDialog();
              }),
          title: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              AppLocalizations.of(context)?.settings_filter ?? '',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ),
        body: BlocConsumer<FilterModulesBloc, FilterModulesState>(
          listener: (ctx, state) => state.whenOrNull(
            saved: () => _savedMessage(ctx),
          ),
          builder: (ctx, state) {
            return state.maybeWhen(
              fetched: (data) => _body(ctx, data),
              orElse: () => const LoadingWidget(),
            );
          },
        ),
      ),
    );
  }

  Widget _body(BuildContext ctx, Configuration data) {
    var buttonwidth = 300.00;
    var buttonheight = 65.00;
    return Stack(
      alignment: Alignment.center,
      children: [
        SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
              //   child: Text(
              //     AppLocalizations.of(context)?.filter_course_page_label ?? '',
              //     style: Theme.of(context).textTheme.headline2,
              //     textAlign: TextAlign.center,
              //   ),
              // ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: data.selectedCourses.length,
                  itemBuilder: (context, index) {
                    return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data.selectedCourses[index].years.length,
                        itemBuilder: (_, indexYears) {
                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  data.selectedCourses[index].label,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 8.0),
                                child: Text(
                                  data.selectedCourses[index].years[indexYears]
                                      .label,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: data
                                    .selectedCourses[index]
                                    .years[indexYears]
                                    .elencoInsegnamenti
                                    .length,
                                itemBuilder:
                                    (BuildContext context, int indexModule) {
                                  return index <=
                                          data
                                                  .selectedCourses[index]
                                                  .years[indexYears]
                                                  .elencoInsegnamenti
                                                  .length -
                                              1
                                      ? Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: BackgroundCard(
                                            // backgroundColor: const Color.fromRGBO(97, 97, 168, 1),
                                            height: buttonheight,
                                            width: buttonwidth,
                                            child: CustomCheckboxListTile(
                                              activeColor: Colors.grey,
                                              autofocus: true,
                                              enableFeedback: true,
                                              title: Text(
                                                data
                                                    .selectedCourses[index]
                                                    .years[indexYears]
                                                    .elencoInsegnamenti[
                                                        indexModule]
                                                    .label,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium,
                                              ),
                                              value: data
                                                  .selectedCourses[index]
                                                  .years[indexYears]
                                                  .elencoInsegnamenti[
                                                      indexModule]
                                                  .selected,
                                              onChanged: (bool? value) {
                                                setState(() {
                                                  data
                                                      .selectedCourses[index]
                                                      .years[indexYears]
                                                      .elencoInsegnamenti[
                                                          indexModule]
                                                      .selected = value!;
                                                });
                                              },
                                            ),
                                          ),
                                        )
                                      : const Padding(
                                          padding: EdgeInsets.all(60.0));
                                },
                              )
                            ],
                          );
                        });
                  }),
              const SizedBox(
                height: 80,
              )
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 60,
              child: FittedBox(
                child: CustomFloatingActionButton.extended(
                  shape: const StadiumBorder(
                      side: BorderSide(
                          color: Color.fromRGBO(97, 97, 168, 0.5), width: 2)),
                  elevation: 1.5,
                  onPressed: () {
                    //Save
                    context.read<FilterModulesBloc>().saveChanges(data);
                  },
                  backgroundColor: const Color.fromRGBO(62, 62, 112, 1),
                  label: Text(
                    'confirm',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  icon:
                      const Icon(Icons.check, color: Colors.green, size: 24.0),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  void _savedMessage(BuildContext ctx) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 6.0,
        behavior: SnackBarBehavior.floating,
        content: Text(
          AppLocalizations.of(context)?.modules_saved_dialog ?? '',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.labelSmall,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        duration: const Duration(milliseconds: 1000),
      ),
    );
    //context.router.replace(HomeRoute());
    context.read<RegistrationBloc>().checkRegistration();
  }

  void _showDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(child: Text("Exit")),
            content: Text(
              AppLocalizations.of(context)?.exit_dialog_text ?? '',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelMedium,
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Back'),
                child: Text(
                  AppLocalizations.of(context)?.go_back_dialog ?? '',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              TextButton(
                onPressed: () {
                  //context.router.removeLast();
                  context.router.replace(const HomeRoute());
                },
                child: Text(
                  AppLocalizations.of(context)?.confirm_dialog ?? '',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ],
          );
        },
        barrierDismissible: true);
  }
}
