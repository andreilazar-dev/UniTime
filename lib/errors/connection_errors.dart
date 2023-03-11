/*
 *  Copyright (c) 2020 - 2023
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_essentials_kit/flutter_essentials_kit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConnectionError extends LocalizedError {
  @override
  String? localizedString(BuildContext context) =>
      AppLocalizations.of(context)?.error_connection;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConnectionError && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;
}
