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

class CourseLabel extends StatelessWidget {
  const CourseLabel({
    Key? key,
    required this.courseName,
    required this.studyYear,
    required this.year,
  }) : super(key: key);

  /// A list of label to display
  final String? courseName;
  final String? studyYear;
  final String? year;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var brightness = theme.brightness;
    bool isDarkMode = brightness == Brightness.dark;
    //final mediaQuery = MediaQuery.of(context);

    return SizedBox(
      height: 100, //mediaQuery.size.height - (mediaQuery.size.height*85/100),
      //constraints: const BoxConstraints(minHeight: 80, maxHeight: 220),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: LayoutBuilder(
          builder: (_, constrains) {
            return Stack(
              children: [
                if (isDarkMode)
                  GlassmorphicContainer(
                    width: constrains.maxWidth,
                    height: constrains.maxHeight,
                    borderRadius: 25,
                    blur: 3,
                    border: 4,
                    linearGradient: const LinearGradient(
                        begin: Alignment.bottomLeft,
                        colors: [
                          Color.fromRGBO(97, 97, 168, 0.5),
                          Color.fromRGBO(97, 97, 168, 0.4),
                          Color.fromRGBO(97, 97, 168, 0.1),
                        ]),
                    borderGradient: const LinearGradient(colors: [
                      Color.fromRGBO(97, 97, 168, 0.5),
                      Color.fromRGBO(97, 97, 168, 0.1),
                      Color.fromRGBO(0, 0, 0, 0),
                    ]),
                  )
                else
                  //Container Color Fill
                  Container(
                    width: constrains.maxWidth,
                    height: constrains.maxHeight,
                    decoration: const BoxDecoration(
                      //shape: BoxShape.circle,
                      color: Color.fromRGBO(62, 62, 112, 1),
                    ),
                  ),

                //Circle Position e dimension
                Positioned(
                  right: -35,
                  top: -30,
                  child: Container(
                    width: 127, //constrains.maxWidth+30,
                    height: 127, //constrains.minHeight+30,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromRGBO(97, 97, 168, 0.4),
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 10, bottom: 5, right: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.school,
                              size: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.fontSize,
                              color: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.color,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              courseName!,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 6),
                            child: Icon(
                              Icons.calendar_today,
                              size: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.fontSize,
                              color:
                                  Theme.of(context).textTheme.labelSmall?.color,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              year!,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 10, left: 4),
                            child: Icon(
                              Icons.adjust_sharp,
                              size: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.fontSize,
                              color: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.color,
                            ),
                          ),
                          Flexible(
                            child: Text(studyYear!,
                                style: Theme.of(context).textTheme.labelMedium),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
