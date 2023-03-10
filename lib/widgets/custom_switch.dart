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

class CustomSwitch extends StatelessWidget {
  const CustomSwitch(
      {Key? key,
      required this.width,
      required this.height,
      required this.switchvalue,
      required this.onChanged,
      this.text = "Default"})
      : super(key: key);

  final double width;
  final double height;
  final bool switchvalue;
  final ValueChanged<bool>? onChanged;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: width,
      height: height,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              //width: width / 2,
              child: Text(text),
            ),
            SizedBox(
              //width: width / 2,
              child: Transform.scale(
                scale: 1.5,
                child: CupertinoSwitch(
                  value: switchvalue,
                  onChanged: onChanged,
                  activeColor: const Color.fromRGBO(115, 115, 194, 1),
                  thumbColor: theme.backgroundColor,
                  trackColor: const Color.fromRGBO(86, 86, 131, 1),
                ),
              ),
            ),
          ]),
    );
  }
}
