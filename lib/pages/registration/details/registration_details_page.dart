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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_timetable/blocs/course_settings/course_setting_bloc.dart';
import 'package:school_timetable/pages/registration/details/pages/courses_select_page.dart';
import 'package:school_timetable/pages/registration/details/pages/filter_config_page.dart';
import 'package:school_timetable/widgets/customshape.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../blocs/registration/registration_bloc.dart';

class RegistrationDetailsPage extends StatelessWidget with AutoRouteWrapper {
  RegistrationDetailsPage({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) => MultiBlocProvider(providers: [
        BlocProvider(
            create: (context) => CourseSettingBloc(repository: context.read()))
      ], child: this);

  final PageController _pageController = PageController();

  void dispose() {
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    final pages = [CoursesSelectPage(), FilterConfigPage()];
    return BlocConsumer<CourseSettingBloc, CourseSettingState>(
        listener: (context, coursesState) =>
            coursesState.whenOrNull(initial: () {
              _animateTo(0);
            }, teachings: (_) {
              _animateTo(1);
            }, saved: () {
              context.read<RegistrationBloc>()..checkRegistration();
            }),
        builder: (context, coursesState) {
          return Scaffold(
            //resizeToAvoidBottomInset: false,
            body: CustomShape(
              child: Stack(
                children: [
                  SafeArea(
                    child: Center(
                      heightFactor: 3,
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: pages.length,
                        effect: ExpandingDotsEffect(
                          dotHeight: 16,
                          dotWidth: 16,
                          //type: WormType.thin,
                          // strokeWidth: 5,
                        ),
                      ),
                    ),
                  ),
                  PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (page) {
                      debugPrint("Page Number:" + page.toString());
                    },
                    itemCount: pages.length,
                    itemBuilder: (_, index) {
                      return pages[index];
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _animateTo(int _page) async {
    _pageController.animateToPage(
      _page,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeIn,
    );

    // _pageController.animateToPage(_page);
  }
}
