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
import 'package:flutter_essentials_kit/flutter_essentials_kit.dart';

class RepositoryError extends LocalizedError {
  final Object error;

  RepositoryError(this.error);

  @override
  String? localizedString(BuildContext context) {
    if (error is LocalizedError) {
      return (error as LocalizedError).localizedString(context);
    }

    return null;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RepositoryError &&
          runtimeType == other.runtimeType &&
          error.runtimeType == other.error.runtimeType;

  @override
  int get hashCode => error.hashCode;

  @override
  String toString() => 'RepositoryError{error: $error}';
}
