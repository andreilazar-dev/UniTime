/*
 *  Copyright (c) 2020 - 2022
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

part of 'theme_cubit.dart';

@freezed
class ThemeState with _$ThemeState {
  const ThemeState._();

  const factory ThemeState({
    @Default(Theme.system) Theme theme,
  }) = _ThemeState;

  bool get isLight =>
      theme == Theme.light ||
      (theme == Theme.system &&
          SchedulerBinding.instance.window.platformBrightness ==
              Brightness.light);

  bool get isDark =>
      theme == Theme.dark ||
      (theme == Theme.system &&
          SchedulerBinding.instance.window.platformBrightness ==
              Brightness.dark);
}
