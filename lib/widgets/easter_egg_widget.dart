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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_timetable/cubits/easter_egg/easter_egg_cubit.dart';

class EasterEggWidget extends StatelessWidget {
  final Widget child;

  const EasterEggWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<EasterEggCubit, EasterEggState>(builder: (context, state) {
        if (state.easterEgg.active) {
          return Stack(children: [
            Container(
              alignment: Alignment.topRight,
              child: FractionallySizedBox(
                alignment: Alignment.topRight,
                widthFactor: 0.5,
                heightFactor: 0.5,
                child: Image.asset(
                  'assets/images/character.png',
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.topRight,
                ),
              ),
            ),
            child
          ]);
        }
        return child;
      });
}
