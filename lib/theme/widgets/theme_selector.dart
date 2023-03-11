/*
 *  Copyright (c) 2020 - 2022
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

import 'package:school_timetable/theme/cubits/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef ThemeSelectorWidgetBuilder = Widget Function(
    BuildContext context, ThemeMode mode);

class ThemeSelector extends StatelessWidget {
  final ThemeSelectorWidgetBuilder builder;

  const ThemeSelector({required this.builder, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) => builder(
          context,
          state.isLight
              ? ThemeMode.light
              : state.isDark
                  ? ThemeMode.dark
                  : ThemeMode.system,
        ),
      );
}
