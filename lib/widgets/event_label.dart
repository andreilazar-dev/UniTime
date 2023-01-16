/*
 *  Copyright (c) 2020 - 2021  - All Rights Reserved
 *  Andrei Lazar <andreilazar.dev@gmail.com>
 *  Lorenzo Bonanni <lorenzopuntobonanni@gmail.com>
 *
 *  This file is part of UniTime.
 *
 *  UniTime can not be copied and/or distributed without the express
 *  permission of  Andrei Lazar & Lorenzo Bonanni
 *
 *  If you have received a copy of this file please contact us
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

// TODO generalize style
class EventLabel extends StatelessWidget {
  EventLabel({
    Key? key,
    required this.eventName,
    required this.eventTimeInterval,
    required this.eventPlace,
  }) : super(key: key);

  /// A list of label to display
  final String? eventName;
  final String? eventTimeInterval;
  final String? eventPlace;

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
                          const Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.library_books_outlined,
                              size: 17,
                              color: Color.fromRGBO(255, 255, 252, 1),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              eventName!,
                              style: const TextStyle(
                                //fontSize: 20,
                                fontFamily: 'Roboto-Medium',
                                color: Color.fromRGBO(255, 255, 252, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.access_time,
                              size: 17,
                              color: Color.fromRGBO(255, 255, 252, 1),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              eventTimeInterval!,
                              style: const TextStyle(
                                //fontSize: 16,
                                fontFamily: 'Roboto-Regular',
                                color: Color.fromRGBO(255, 255, 252, 1),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.location_on_outlined,
                              size: 17,
                              color: Color.fromRGBO(255, 255, 252, 1),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              eventPlace!,
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Roboto-regular',
                                color: Color.fromRGBO(255, 255, 252, 1),
                              ),
                            ),
                          ),
                        ],
                      )
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
