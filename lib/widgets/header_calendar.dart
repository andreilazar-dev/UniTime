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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

class CalendarHeader extends StatelessWidget {
  final DateTime focusedDay;
  final VoidCallback onLeftArrowTap;
  final VoidCallback onRightArrowTap;

  const CalendarHeader({
    Key? key,
    required this.focusedDay,
    required this.onLeftArrowTap,
    required this.onRightArrowTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headerText = DateFormat.yMMMM().format(focusedDay);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            //width: 120.0,
            child: Text(
              AppLocalizations.of(context)?.calendar_label ?? '',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                //width: 120.0,
                child: Text(
                  headerText,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: onLeftArrowTap,
                    style: ElevatedButton.styleFrom(
                      shape: const CircleBorder(),
                      padding: const EdgeInsets.all(0),
                    ),
                    child: const Icon(
                      Icons.chevron_left,
                      size: 50,
                    ),
                  ),
                  const SizedBox(width: 15),
                  ElevatedButton(
                      onPressed: onRightArrowTap,
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(0),
                      ),
                      child: const Icon(
                        Icons.chevron_right,
                        size: 50,
                      )),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
