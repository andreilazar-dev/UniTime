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

import 'package:flutter/material.dart';

class ReiBottomBar extends StatelessWidget {
  const ReiBottomBar(
      {Key? key,
      required this.items,
      this.currentIndex = 0,
      this.onTap,
      this.selectedItemColor,
      this.unselectedItemColor,
      this.selectedColorOpacity,
      this.itemShape = const StadiumBorder(),
      this.margin = const EdgeInsets.all(8),
      this.itemPadding =
          const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      this.duration = const Duration(milliseconds: 500),
      this.curve = Curves.easeOutQuint,
      this.borderRadius = 25,

      //TODO: This need for margin need dynamic
      this.marginR = const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      this.paddingR = const EdgeInsets.only(bottom: 10, top: 10),
      this.backgroundColor = Colors.deepPurple,
      this.boxShadow = const [
        BoxShadow(
          color: Colors.transparent,
          spreadRadius: 0,
          blurRadius: 0,
          offset: Offset(0, 0), // changes position of shadow
        ),
      ]})
      : super(key: key);

  /// A list of tabs to display, ie `Home`, `Likes`, etc
  final List<ReiBottomBarItem> items;

  /// The tab to display.
  final int currentIndex;

  /// Returns the index of the tab that was tapped.
  final Function(int)? onTap;

  /// The color of the icon and text when the item is selected.
  final Color? selectedItemColor;

  /// The color of the icon and text when the item is not selected.
  final Color? unselectedItemColor;

  /// The opacity of color of the touchable background when the item is selected.
  final double? selectedColorOpacity;

  /// The border shape of each item.
  final ShapeBorder itemShape;

  /// A convenience field for the margin surrounding the entire widget.
  final EdgeInsets margin;

  /// The padding of each item.
  final EdgeInsets itemPadding;

  /// The transition duration
  final Duration duration;

  /// The transition curve
  final Curve curve;

  /// margin for the bar to give some radius
  final EdgeInsetsGeometry? marginR;

  /// padding for the bar to give some radius
  final EdgeInsetsGeometry? paddingR;

  ///bgd colors for the nav bar
  final Color? backgroundColor;

  /// List of box shadow
  final List<BoxShadow> boxShadow;

  /// border radius
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Color background = (theme.bottomNavigationBarTheme.backgroundColor ??
        backgroundColor) as Color;
    final Color secondaryBackground =
        (theme.primaryColorDark ?? backgroundColor) as Color;
    var brightness = theme.brightness;
    bool isDarkMode = brightness == Brightness.dark;
    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: marginR!,
            child: Container(
              padding: paddingR,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius!),

                //TODO: need setting dynamic colors
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      background.withOpacity(1),
                      isDarkMode
                          ? Colors.white70.withOpacity(0.3)
                          : secondaryBackground.withOpacity(1),
                    ]),
                boxShadow: boxShadow,
              ),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (final item in items)
                      TweenAnimationBuilder<double>(
                        tween: Tween(
                          end: items.indexOf(item) == currentIndex ? 1.0 : 0.0,
                        ),
                        curve: curve,
                        duration: duration,
                        builder: (context, t, _) {
                          final selectedColor = item.selectedColor ??
                              selectedItemColor ??
                              theme.primaryColor;

                          final unselectedColor = item.unselectedColor ??
                              unselectedItemColor ??
                              theme
                                  .bottomNavigationBarTheme.unselectedItemColor;

                          return Material(
                            color: Color.lerp(
                                selectedColor.withOpacity(0.0),
                                selectedColor
                                    .withOpacity(selectedColorOpacity ?? 0.1),
                                t),
                            shape: itemShape,
                            child: InkWell(
                              onTap: () => onTap?.call(items.indexOf(item)),
                              customBorder: itemShape,
                              focusColor: selectedColor.withOpacity(0.1),
                              highlightColor: selectedColor.withOpacity(0.1),
                              splashColor: selectedColor.withOpacity(0.1),
                              hoverColor: selectedColor.withOpacity(0.1),
                              child: Padding(
                                padding: itemPadding -
                                    (Directionality.of(context) ==
                                            TextDirection.ltr
                                        ? EdgeInsets.only(
                                            right: itemPadding.right * t)
                                        : EdgeInsets.only(
                                            left: itemPadding.left * t)),
                                child: Row(
                                  children: [
                                    IconTheme(
                                      data: IconThemeData(
                                        color: Color.lerp(
                                            unselectedColor, selectedColor, t),
                                        size: 26, //24,
                                      ),
                                      child: items.indexOf(item) == currentIndex
                                          ? item.activeIcon ?? item.icon
                                          : item.icon,
                                    ),
                                    ClipRect(
                                      child: SizedBox(
                                        /// TODO: Constrain item height without a fixed value
                                        ///
                                        /// The Align property appears to make these full height, would be
                                        /// best to find a way to make it respond only to padding.
                                        height: 30,
                                        child: Align(
                                          alignment: const Alignment(-0.2, 0.0),
                                          widthFactor: t,
                                          child: Padding(
                                            padding: Directionality.of(
                                                        context) ==
                                                    TextDirection.ltr
                                                ? EdgeInsets.only(
                                                    left: itemPadding.left / 2,
                                                    right: itemPadding.right)
                                                : EdgeInsets.only(
                                                    left: itemPadding.left,
                                                    right:
                                                        itemPadding.right / 2),
                                            child: DefaultTextStyle(
                                              style: TextStyle(
                                                color: Color.lerp(
                                                    selectedColor
                                                        .withOpacity(0.0),
                                                    selectedColor,
                                                    t),
                                                fontWeight: FontWeight.w600,
                                              ),
                                              child: item.title,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A tab to display in a [ReiBottomBar]
class ReiBottomBarItem {
  /// An icon to display.
  final Widget icon;

  /// An icon to display when this tab bar is active.
  final Widget? activeIcon;

  /// Text to display, ie `Home`
  final Widget title;

  /// A primary color to use for this tab.
  final Color? selectedColor;

  /// The color to display when this tab is not selected.
  final Color? unselectedColor;

  ReiBottomBarItem({
    required this.icon,
    required this.title,
    this.selectedColor,
    this.unselectedColor,
    this.activeIcon,
  });
}
