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

class EventCard<T> extends StatelessWidget {
  const EventCard({
    Key? key,
    required this.eventName,
    required this.eventTimeInterval,
    required this.eventPlace,
    this.height = 130,
    this.onEventTap,
    this.event,
  }) : super(key: key);

  /// A list of label to display
  final String? eventName;
  final String? eventTimeInterval;
  final String? eventPlace;

  final T? event;
  final ValueSetter<T>? onEventTap;

  //Card Height
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var brightness = theme.brightness;
    bool isDarkMode = brightness == Brightness.dark;
    //final mediaQuery = MediaQuery.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(25),
      onTap: () {
        if (event != null && onEventTap != null) {
          onEventTap!(event!);
        }
      },
      child: SizedBox(
        height:
            height, //mediaQuery.size.height - (mediaQuery.size.height*85/100),
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
                    right: -height / 3, //-35,
                    top: -30,
                    child: Container(
                      width: height + height / 5, //constrains.maxWidth+30,
                      height: height + height / 5, //constrains.minHeight+30,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(97, 97, 168, 0.4),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, top: 10, bottom: 5, right: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                eventName!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Roboto-Medium',
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(255, 255, 252, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                eventPlace!,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Roboto-regular',
                                  color: Color.fromRGBO(255, 255, 252, 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                eventTimeInterval!,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Roboto-Regular',
                                  fontWeight: FontWeight.w700,
                                  color: Color.fromRGBO(255, 255, 252, 1),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.info_outline_rounded,
                                size: 24,
                                color: Color.fromRGBO(255, 255, 252, 1),
                              ),
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
      ),
    );
  }
}
