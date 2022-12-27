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
import 'package:flutter_essentials_kit/flutter_essentials_kit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:school_timetable/pages/settings/builders/settings_tile_bloc_builder.dart';
import 'package:school_timetable/theme/cubits/theme_cubit.dart';
import 'package:school_timetable/theme/models/theme.dart' as theme;
import 'package:school_timetable/widgets/bottom_sheets/selector_value_sheet.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)?.title_settings ?? ''),
        ),
        body: SettingsList(
          //TODO: backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          sections: [
            _appSettings(context),
          ],
        ),
      );

  AbstractSettingsSection _appSettings(BuildContext context) => SettingsSection(
        title: Text(AppLocalizations.of(context)?.settings_app ?? ''),
        tiles: [
          SettingsTileBlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) => SettingsTile(
              title: Text(AppLocalizations.of(context)?.settings_theme ?? ''),
              leading: const Icon(Icons.lightbulb),
              value: state.theme.localize(context)?.let((it) => Text(it)),
              onPressed: (context) => showBottomSheet(
                context: context,
                builder: (context) => SelectorValueSheet<theme.Theme>(
                  title: AppLocalizations.of(context)?.settings_theme,
                  values: theme.Theme.values,
                  initialValue: state.theme,
                  localizeValue: (theme) => theme.localize(context),
                  onSelectedValueChanged: context.watch<ThemeCubit>().setTheme,
                ),
              ),
            ),
          ),
        ],
      );
}
