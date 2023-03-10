/*
 *  Copyright (c) 2020 - 2023
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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:school_timetable/blocs/registration/registration_bloc.dart';
import 'package:school_timetable/cubits/easter_egg/easter_egg_cubit.dart';
import 'package:school_timetable/routers/app_router.gr.dart';
import 'package:school_timetable/theme/cubits/theme_cubit.dart';
import 'package:school_timetable/theme/models/theme.dart' as theme;
import 'package:school_timetable/widgets/credits_dialog.dart';
import 'package:school_timetable/widgets/custom_button.dart';
import 'package:school_timetable/widgets/custom_switch.dart';
import 'package:school_timetable/widgets/easter_egg_widget.dart';
import 'package:school_timetable/widgets/hidden_button.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  final buttonwidth = 300.00;
  final buttonheight = 55.00;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: EasterEggWidget(
        child: Align(
          alignment: const FractionalOffset(0.5, 0.2),
          child: Wrap(
            spacing: 20,
            // to apply margin in the main axis of the wrap
            runSpacing: 20,
            // to apply margin in the cross axis of the wrap
            children: [
              CustomButton(
                width: buttonwidth,
                height: buttonheight,
                onPressed: context.read<RegistrationBloc>().resetApp,
                borderRadius: BorderRadius.circular(20),
                child: Text(
                  AppLocalizations.of(context)?.settings_reset ?? '',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              CustomButton(
                width: buttonwidth,
                height: buttonheight,
                onPressed: () {
                  context.router.replace(const ManageCoursesRoute());
                },
                borderRadius: BorderRadius.circular(20),
                child: Text(
                  AppLocalizations.of(context)?.settings_manage_courses ?? '',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              CustomButton(
                width: buttonwidth,
                height: buttonheight,
                onPressed: () {
                  context.router.replace(const FilterModulesRoute());
                },
                borderRadius: BorderRadius.circular(20),
                child: Text(
                  AppLocalizations.of(context)?.settings_filter ?? '',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              CustomButton(
                width: buttonwidth,
                height: buttonheight,
                onPressed: () {
                  _creditsDialog(context);
                },
                borderRadius: BorderRadius.circular(20),
                child: Text(
                  AppLocalizations.of(context)?.settings_credits ?? '',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
              Container(
                  width: buttonwidth,
                  alignment: Alignment.center,
                  child: _themeButton()),
              Container(
                  width: buttonwidth,
                  alignment: Alignment.center,
                  child: _secretButton()),
            ],
          ),
        ),
      ),
    ));
  }

  Widget _themeButton() {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return SizedBox(
          width: MediaQuery.of(context).size.width * 0.45,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  AppLocalizations.of(context)?.settings_theme ?? '',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              DropdownSearch<theme.Theme>(
                items: theme.Theme.values,
                compareFn: (i, s) => i.name == s.name,
                itemAsString: (theme) => theme.localize(context) ?? "",
                selectedItem: state.theme,
                dropdownDecoratorProps: DropDownDecoratorProps(
                  textAlign: TextAlign.end,
                  baseStyle: Theme.of(context).textTheme.labelMedium,
                  dropdownSearchDecoration: const InputDecoration(
                    filled: true,
                    contentPadding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                  ),
                ),
                popupProps: PopupProps.menu(
                  fit: FlexFit.loose,
                  menuProps: MenuProps(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                  ),
                ),
                clearButtonProps: const ClearButtonProps(isVisible: false),
                dropdownButtonProps: DropdownButtonProps(
                  isVisible: true,
                  color: Theme.of(context).textTheme.labelLarge?.color,
                ),
                onChanged: context.read<ThemeCubit>().setTheme,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _secretButton() {
    return BlocBuilder<EasterEggCubit, EasterEggState>(
        builder: (context, state) {
      if (state.easterEgg.visibility) {
        return CustomSwitch(
          width: buttonwidth,
          height: buttonheight,
          switchvalue: state.easterEgg.active,
          text: "Special",
          onChanged: (value) => context
              .read<EasterEggCubit>()
              .setState(state.easterEgg.copyWith(active: value)),
        );
      }
      return HiddenButton(
        onAction: () {
          _snackEasterEgg(context);
          context
              .read<EasterEggCubit>()
              .setState(state.easterEgg.copyWith(visibility: true));
        },
      );
    });
  }

  void _snackEasterEgg(BuildContext ctx) {
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        elevation: 6.0,
        behavior: SnackBarBehavior.floating,
        content: Text(
          'EasterEgg Active!',
          textAlign: TextAlign.center,
          style: Theme.of(ctx).textTheme.labelSmall,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        duration: const Duration(milliseconds: 1500),
      ),
    );
  }

  void _creditsDialog(BuildContext ctx) {
    showDialog<String>(
        context: ctx, builder: (BuildContext context) => const CreditsDialog());
  }
}
