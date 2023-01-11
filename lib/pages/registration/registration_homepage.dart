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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:school_timetable/repositories/configuration_repository.dart';
import '../../misc/server/server.dart';
import '../../misc/server/servers.dart';
import '../../routers/app_router.gr.dart';
import '../../services/network/university_information_service.dart';
import '../../widgets/customshape.dart';

class RegistrationHomePage extends StatelessWidget {
  const RegistrationHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    final serversUny = context.read<Servers>().servers;
    Server? selectedServer;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomShape(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: (mediaQuery.size.height - mediaQuery.padding.top) *
                        0.30,
                    child: Image(
                      image: AssetImage('assets/images/UniTime.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                      height:
                          (mediaQuery.size.height - mediaQuery.padding.top) *
                              0.025),
                  Center(
                    child: Text(
                      AppLocalizations.of(context)?.welcome ?? '',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                  ),
                  SizedBox(
                      height:
                          (mediaQuery.size.height - mediaQuery.padding.top) *
                              0.15),
                  Text(
                    AppLocalizations.of(context)?.select_uni ?? '',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  SizedBox(
                      height:
                          (mediaQuery.size.height - mediaQuery.padding.top) *
                              0.05),
                  Container(
                    width: mediaQuery.size.width * 0.8,
                    child: DropdownSearch<Server>(
                      items: serversUny,
                      compareFn: (i, s) => i == s,
                      itemAsString: (server) =>
                          (AppLocalizations.of(context)?.uni_of ?? '') +
                          server.label,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                          baseStyle: TextStyle(fontSize: 16),
                          dropdownSearchDecoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context)?.tap_uni ?? '',
                            filled: true,
                            contentPadding:
                                const EdgeInsets.fromLTRB(20, 20, 20, 20),
                          )),
                      popupProps: PopupProps.menu(
                        fit: FlexFit.loose,
                        showSelectedItems: true,
                        showSearchBox: true,
                        menuProps: MenuProps(
                          //backgroundColor: Colors.green,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            // side: BorderSide(
                            //   color: Colors.greenAccent,
                            // ),
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        searchFieldProps: TextFieldProps(
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(25)),
                          )),
                        ),
                        itemBuilder: _universityBuilder,
                      ),
                      // items: serversUny.keys.toList(),
                      clearButtonProps: ClearButtonProps(isVisible: false),
                      onChanged: (server) {
                        selectedServer = server!;
                      },
                      onSaved: (server) {
                        selectedServer = server!;
                      },
                    ),
                  ),
                  SizedBox(
                      height:
                          (mediaQuery.size.height - mediaQuery.padding.top) *
                              0.10),
                  ElevatedButton(
                    onPressed: () {
                      _goToNextPage(context, selectedServer!);
                    },
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                  SizedBox(
                      height:
                          (mediaQuery.size.height - mediaQuery.padding.top) *
                              0.05),
                ],
              );
            },
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
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              //border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(25),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title:
            Text((AppLocalizations.of(context)?.uni_of ?? '') + server.label),
        subtitle: Text(server.code),
        selectedColor: Colors.black,
        // leading: CircleAvatar(
        //   backgroundImage: NetworkImage('link'),
        //     ),
      ),
    );
  }

  Future<void> _goToNextPage(BuildContext context, Server server) async {
    context
        .read<UniversityInformationService>()
        .setServer(server: server.server);
    context.read<ConfigurationRepository>().setServer(server);
    await context.pushRoute(RegistrationDetailsRoute());
  }
}
