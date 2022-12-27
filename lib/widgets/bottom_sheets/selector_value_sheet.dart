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
import 'package:flutter/material.dart';

typedef OnSelectedValueChanged<T> = void Function(T? fuelType);
typedef LocalizeValue<T> = String? Function(T value);

class SelectorValueSheet<T> extends StatelessWidget {
  final String? title;
  final List<T> values;
  final T? initialValue;
  final OnSelectedValueChanged<T>? onSelectedValueChanged;
  final LocalizeValue<T>? localizeValue;

  const SelectorValueSheet({
    Key? key,
    required this.title,
    required this.values,
    this.onSelectedValueChanged,
    this.initialValue,
    this.localizeValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _sortingCriteriaWidgets(context),
            ],
          ),
        ),
      );

  Widget _sortingCriteriaWidgets(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? '',
            style: Theme.of(context).textTheme.headline6,
          ),
          ...values.map(
            (value) => RadioListTile<T>(
              value: value,
              groupValue: value == initialValue ? value : null,
              onChanged: onSelectedValueChanged != null
                  ? (value) {
                      onSelectedValueChanged!(value);
                      context.router.pop(value);
                    }
                  : null,
              title: Text(localizeValue?.call(value) ?? value.toString()),
            ),
          ),
        ],
      );
}
