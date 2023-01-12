/*
 *  Copyright (c) 2020 - 2023
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:school_timetable/routers/app_router.gr.dart';
import 'package:school_timetable/widgets/bottom_bar/rei_buttombar.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AutoTabsRouter(
        // list of your tab routes
        // routes used here must be declaraed as children
        // routes of /dashboard
        routes: const [
          DailyLessonsRoute(),
          OverviewRoute(),
          SettingsRoute(),
        ],
        builder: (context, child, animation) {
          // obtain the scoped TabsRouter controller using context
          final tabsRouter = AutoTabsRouter.of(context);
          // Here we're building our Scaffold inside of AutoTabsRouter
          // to access the tabsRouter controller provided in this context
          //
          //alterntivly you could use a global key
          return Scaffold(
            extendBody: true,
            body: FadeTransition(
              opacity: animation,
              // the passed child is techinaclly our animated selected-tab page
              child: child,
            ),
            // bottomNavigationBar: BottomNavigationBar(
            //   currentIndex: tabsRouter.activeIndex,
            //   onTap: (index) {
            //     // here we switch between tabs
            //     tabsRouter.setActiveIndex(index);
            //   },
            //   items: const [
            //     BottomNavigationBarItem(
            //         label: 'Home', icon: Icon(Icons.dashboard)),
            //     BottomNavigationBarItem(
            //         label: 'Overview', icon: Icon(Icons.find_in_page_rounded)),
            //     BottomNavigationBarItem(
            //         label: 'Settings', icon: Icon(Icons.menu)),
            //   ],
            // ),
            //
            bottomNavigationBar: ReiBottomBar(
              currentIndex: tabsRouter.activeIndex,
              onTap: (index) {
                // here we switch between tabs
                tabsRouter.setActiveIndex(index);
              },
              items: itemsBar,
              margin: const EdgeInsets.only(left: 0, right: 0),
            ),
          );
        },
      ),
    );
  }

  static var itemsBar = [
    /// Day
    ReiBottomBarItem(
      icon: const Icon(FontAwesomeIcons.calendarDay),
      title: const Text("Day"),
      selectedColor: const Color.fromRGBO(251, 119, 80, 1),
    ),

    /// Week
    ReiBottomBarItem(
      icon: const Icon(FontAwesomeIcons.calendarWeek),
      title: const Text("Week"),
      selectedColor: const Color.fromRGBO(245, 177, 12, 1),
    ),

    /// Setting
    ReiBottomBarItem(
      icon: const Icon(FontAwesomeIcons.gear),
      title: const Text("Settings"),
      selectedColor: const Color.fromRGBO(252, 54, 55, 1),
    ),
  ];
}
