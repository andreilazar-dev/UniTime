/*
 *  Copyright (c) 2020 - 2022
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

import 'dart:ui';

import 'package:school_timetable/theme/models/theme.dart';
import 'package:flutter/scheduler.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'theme_cubit.freezed.dart';
part 'theme_state.dart';

class ThemeCubit extends HydratedCubit<ThemeState> {
  ThemeCubit() : super(const ThemeState());

  @override
  ThemeState? fromJson(Map<String, dynamic> json) => ThemeState(
        theme: Theme.values.byName(json['theme'] as String),
      );

  @override
  Map<String, dynamic>? toJson(ThemeState state) => {
        'theme': state.theme.name,
      };

  void setTheme(Theme? theme) => emit(ThemeState(theme: theme ?? Theme.system));
}
