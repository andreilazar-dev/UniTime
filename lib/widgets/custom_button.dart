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
import 'package:glassmorphism/glassmorphism.dart';

class CustomButton extends StatelessWidget {
  final BorderRadiusGeometry? borderRadius;
  final double width;
  final double height;
  final VoidCallback? onPressed;
  final Widget child;
  final Color backgroundColor;

  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.borderRadius,
    this.width = 64.0,
    this.height = 44.0,
    this.backgroundColor = Colors.deepPurple,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderRadius = this.borderRadius ?? BorderRadius.circular(0);
    final theme = Theme.of(context);
    var brightness = theme.brightness;
    bool isDarkMode = brightness == Brightness.dark;

    Widget label = isDarkMode
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
              width: width,
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
              decoration: const BoxDecoration(
                //shape: BoxShape.circle,
                color: Color.fromRGBO(62, 62, 112, 1),
              ),
              child: Container(
                width: width,
                height: height,
                alignment: Alignment.center,
                child: child,
              ),
            ),
          );

    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.white.withOpacity(0.1),
            shape: RoundedRectangleBorder(borderRadius: borderRadius)),
        child: label);
  }
}
