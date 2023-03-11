/*
 *  Copyright (c) 2020 - 2023
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class NavigationObserver extends AutoRouterObserver {
  NavigationObserver({required this.analytics});

  final FirebaseAnalytics analytics;

  void _sendScreenView(String? screenName) {
    if (screenName != null) {
      analytics.setCurrentScreen(screenName: screenName);
    }
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    log('New route pushed: ${route.settings.name}');
    _sendScreenView(route.settings.name);
  }

  // only override to observer tab routes
  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    log('Tab route visited: ${route.name}');
    _sendScreenView(route.name);
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    log('Tab route re-visited: ${route.name}');
    _sendScreenView(route.name);
  }
}
