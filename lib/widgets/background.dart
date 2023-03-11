/*
 *  Copyright (c) 2020 - 2023
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

import 'dart:ui';

import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  Widget child;
  Background({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var brightness = theme.brightness;
    bool isDarkMode = brightness == Brightness.dark;

    List<Color> colors = isDarkMode
        ? [
            const Color.fromRGBO(114, 114, 186, 1),
            const Color.fromRGBO(36, 36, 66, 1)
          ]
        : [
            const Color.fromRGBO(114, 114, 186, 1),
            const Color.fromRGBO(255, 251, 245, 1)
          ];
    return Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
              center: const Alignment(1.5, -0.5), // near the top right
              radius: 0.8,
              colors: colors,
              stops: const <double>[0.0, 1]),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 60.0, sigmaY: 60.0),
          child: child,
        ));
  }
}
