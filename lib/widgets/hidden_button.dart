/*
 *  Copyright (c) 2020 - 2023
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

import 'dart:async';
import 'package:flutter/material.dart';

class HiddenButton extends StatefulWidget {
  final Function()? onAction;

  const HiddenButton({Key? key, this.onAction}) : super(key: key);

  @override
  State<HiddenButton> createState() => _HiddenButtonState();
}

class _HiddenButtonState extends State<HiddenButton> {
  int _tapCount = 0;
  Timer? _timer;

  void _onTap() {
    setState(() {
      _tapCount++;
    });

    if (_tapCount == 6) {
      if (widget.onAction != null) {
        widget.onAction!();
      }

      _resetCounter();
    } else {
      _startTimer();
    }
  }

  void _startTimer() {
    if (_timer != null) {
      _timer!.cancel();
    }

    _timer = Timer(const Duration(seconds: 5), _resetCounter);
  }

  void _resetCounter() {
    setState(() {
      _tapCount = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: Container(
        width: 200.0,
        height: 50.0,
        color: Colors.transparent,
      ),
    );
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }
}
