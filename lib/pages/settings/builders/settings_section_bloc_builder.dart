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
import 'package:settings_ui/settings_ui.dart';

class SettingsSectionBlocBuilder<B extends StateStreamable<S>, S>
    extends AbstractSettingsSection {
  final BlocWidgetBuilder<S> builder;

  const SettingsSectionBlocBuilder({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BlocBuilder<B, S>(builder: builder);
}
