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
import 'package:school_timetable/models/timetable/celle.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventDetails extends StatelessWidget {
  final Celle cell;

  const EventDetails({Key? key, required this.cell}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Material(
      child: Container(
        color: Theme.of(context).appBarTheme.backgroundColor,
        child: SafeArea(
          top: false,
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 15, bottom: 10, left: 20, right: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              cell.nomeInsegnamento ?? "",
                              style: Theme.of(context).textTheme.labelLarge,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Divider(
                    color: Theme.of(context).textTheme.labelLarge?.color,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              AppLocalizations.of(context)?.classroom_label ??
                                  '',
                              style: Theme.of(context).textTheme.labelMedium),
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Icon(
                                    Icons.place,
                                    size: 12,
                                    color: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.color,
                                  ),
                                ),
                                Flexible(
                                  child: Text(cell.aula ?? "",
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Theme.of(context).textTheme.labelLarge?.color,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                                AppLocalizations.of(context)?.hours_label ?? '',
                                style: Theme.of(context).textTheme.labelMedium),
                          ),
                          Flexible(
                            child: Center(
                              child: Text(
                                cell.orario ?? "",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  Divider(
                    color: Theme.of(context).textTheme.labelLarge?.color,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context)?.degree_label ?? '',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: Center(
                            child: Text(
                              cell.percorsoDidattico ?? "",
                              style: Theme.of(context).textTheme.labelMedium,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Theme.of(context).textTheme.labelLarge?.color,
                  ),
                  if (cell.docente != null)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)?.teacher_label ?? '',
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        Flexible(
                          child: Center(
                            child: Text(
                              cell.docente ?? "",
                              style: Theme.of(context).textTheme.labelMedium,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  SizedBox(
                    height: mediaQuery.size.height * .1,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
