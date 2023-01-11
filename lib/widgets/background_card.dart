/*
 *  Copyright (c) 2020 - 2023
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class BackgroundCard extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final Color backgroundColor;
  final double width;
  final double height;
  final Widget child;

  const BackgroundCard({
    Key? key,
    required this.child,
    this.width = 64.0,
    this.height = 44.0,
    this.borderRadius,
    this.backgroundColor = const Color.fromRGBO(62, 62, 112, 1),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var brightness = theme.brightness;
    bool isDarkMode = brightness == Brightness.dark;

    return isDarkMode
        ? GlassmorphicContainer(
            width: width,
            height: height,
            borderRadius: 25,
            blur: 3,
            border: 4,
            linearGradient:
                const LinearGradient(begin: Alignment.bottomLeft, colors: [
              Color.fromRGBO(97, 97, 168, 0.6),
              Color.fromRGBO(97, 97, 168, 0.5),
              Color.fromRGBO(97, 97, 168, 0.2),
            ]),
            borderGradient: const LinearGradient(colors: [
              Color.fromRGBO(97, 97, 168, 0.5),
              Color.fromRGBO(97, 97, 168, 0.1),
              Color.fromRGBO(0, 0, 0, 0),
            ]),
            child: Container(
              width: width * 2,
              height: height,
              alignment: Alignment.center,
              child: child,
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                //shape: BoxShape.circle,
                color: backgroundColor,
              ),
              child: Container(
                width: width,
                height: height,
                alignment: Alignment.center,
                child: child,
              ),
            ),
          );
  }
}
