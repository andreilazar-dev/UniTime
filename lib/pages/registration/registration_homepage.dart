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
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:school_timetable/policy/cubit/privacy_policy_cubit.dart';
import 'package:school_timetable/policy/widget/privacy_dialog.dart';
import 'package:school_timetable/repositories/configuration_repository.dart';
import '../../misc/server/server.dart';
import '../../misc/server/servers.dart';
import '../../routers/app_router.gr.dart';
import '../../services/network/university_information_service.dart';
import '../../widgets/customshape.dart';

class RegistrationHomePage extends StatelessWidget with AutoRouteWrapper {
  RegistrationHomePage({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(providers: [
        BlocProvider(
          create: (context) => PrivacyPolicyCubit(),
        ),
      ], child: this);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    final serversUny = Servers.servers;
    Server? selectedServer;
    bool connection = false;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomShape(
        child: PrivacyDialog(
          onButtonTap: (status) {
            context.read<PrivacyPolicyCubit>().setPrivacy(status);
          },
          child: SafeArea(
            child: OfflineBuilder(
              connectivityBuilder: (context, connectivity, child) {
                connection =
                    connectivity == ConnectivityResult.none ? false : true;
                if (connectivity == ConnectivityResult.none) {
                  SchedulerBinding.instance.addPostFrameCallback((duration) {
                    showErrorConnection(context);
                  });
                }
                return child;
              },
              child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height:
                            (mediaQuery.size.height - mediaQuery.padding.top) *
                                0.30,
                        child: const Image(
                          image: AssetImage('assets/images/UniTime.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                          height: (mediaQuery.size.height -
                                  mediaQuery.padding.top) *
                              0.025),
                      Center(
                        child: Text(
                          AppLocalizations.of(context)?.welcome ?? '',
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ),
                      SizedBox(
                          height: (mediaQuery.size.height -
                                  mediaQuery.padding.top) *
                              0.15),
                      Text(
                        AppLocalizations.of(context)?.select_uni ?? '',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      SizedBox(
                          height: (mediaQuery.size.height -
                                  mediaQuery.padding.top) *
                              0.05),
                      SizedBox(
                        width: mediaQuery.size.width * 0.8,
                        child: DropdownSearch<Server>(
                          items: serversUny,
                          compareFn: (i, s) => i == s,
                          itemAsString: (server) =>
                              (AppLocalizations.of(context)?.uni_of ?? '') +
                              server.label,
                          dropdownButtonProps: DropdownButtonProps(
                            color: Theme.of(context).primaryColorLight,
                          ),
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              baseStyle:
                                  Theme.of(context).textTheme.labelMedium,
                              dropdownSearchDecoration: InputDecoration(
                                labelText:
                                    AppLocalizations.of(context)?.tap_uni ?? '',
                                labelStyle:
                                    Theme.of(context).textTheme.labelMedium,
                                filled: true,
                                contentPadding:
                                    const EdgeInsets.fromLTRB(20, 20, 20, 20),
                              )),
                          popupProps: PopupProps.menu(
                            fit: FlexFit.loose,
                            showSelectedItems: true,
                            showSearchBox: false,
                            menuProps: MenuProps(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                // side: BorderSide(
                                //   color: Colors.greenAccent,
                                // ),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                            searchFieldProps: const TextFieldProps(
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                              )),
                            ),
                            itemBuilder: _universityBuilder,
                          ),
                          // items: serversUny.keys.toList(),
                          clearButtonProps:
                              const ClearButtonProps(isVisible: false),
                          onChanged: (server) {
                            selectedServer = server!;
                          },
                          onSaved: (server) {
                            selectedServer = server!;
                          },
                        ),
                      ),
                      SizedBox(
                          height: (mediaQuery.size.height -
                                  mediaQuery.padding.top) *
                              0.10),
                      ElevatedButton(
                        onPressed: connection
                            ? () {
                                _goToNextPage(context, selectedServer!);
                              }
                            : null,
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                      SizedBox(
                          height: (mediaQuery.size.height -
                                  mediaQuery.padding.top) *
                              0.05),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _universityBuilder(
    BuildContext context,
    Server server,
    bool isSelected,
    // double width,
  ) {
    return Container(
      width: 20,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              //border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(25),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(
          (AppLocalizations.of(context)?.uni_of ?? '') + server.label,
        ),
        subtitle: Text(server.code),
        // leading: CircleAvatar(
        //   backgroundImage: NetworkImage('link'),
        //     ),
      ),
    );
  }

  void showErrorConnection(BuildContext context) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Center(child: Text("Error")),
              content: Text(
                AppLocalizations.of(context)?.error_connection ?? '',
                textAlign: TextAlign.center,
              ),
            ),
        barrierDismissible: true);
  }

  Future<void> _goToNextPage(BuildContext context, Server server) async {
    context
        .read<UniversityInformationService>()
        .setServer(server: server.server);
    context.read<ConfigurationRepository>().setServer(server);
    await context.pushRoute(RegistrationDetailsRoute());
  }
}
