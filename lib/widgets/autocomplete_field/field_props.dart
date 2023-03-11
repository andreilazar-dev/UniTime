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

abstract class FieldProps<T> {
  FieldProps({required this.onSelected, this.suffixIcon, this.labelText});

  String? labelText;

  Widget? suffixIcon;

  final ValueSetter<T>? onSelected;

  void setSelected(T select, TextEditingController textEditingController);

  Iterable<T> getSuggestions(String pattern);

  Widget itemBuilder(BuildContext context, T suggestion);
}
