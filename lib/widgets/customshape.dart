/*
 *  Copyright (c) 2020 - 2023
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

import 'dart:math';
import 'package:flutter/material.dart';

class CustomShape extends StatelessWidget {
  final Widget child;

  const CustomShape({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ColoredBox(
      color: theme.scaffoldBackgroundColor,
      child: CustomPaint(
        size: const Size(0, 0),
        //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
        painter: OrangeShape(),
        child: CustomPaint(
          painter: YellowShape(),
          child: CustomPaint(painter: RedShape(), child: child),
        ),
      ),
    );
  }
}

//Copy this CustomPainter code to the Bottom of the File
class OrangeShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // calculated by find what percentage of Pixel 5 width is 150
    // double weightRatio = (100*150)/size1.width;
    double widthRatio = 0.3819444444444444;
    // calculated by find what percentage of Pixel 5 height is 450
    // double heightRatio = (100*450)/size1.height;
    double heightRatio = 0.5777310924369748;

    Size size2 = Size(size.width - (size.width * widthRatio),
        size.height - (size.height * heightRatio));
    Canvas canvas1 = canvas;
    // print('this is passed size -> ${size.width} --> ${size.height}');
    Path shape1 = Path();
    shape1.moveTo(size2.width * 0.1232759, size2.height * 0.3171378);
    shape1.cubicTo(
        size2.width * -0.01034483,
        size2.height * 0.2729682,
        size2.width * -0.005172431,
        size2.height * 0.1201413,
        size2.width * 0.2189655,
        size2.height * 0.01060072);
    shape1.cubicTo(
        size2.width * 0.4913793,
        size2.height * -0.08303887,
        size2.width * 1.014655,
        size2.height * 0.5088339,
        size2.width * 0.9991379,
        size2.height * 0.6678445);
    shape1.cubicTo(
        size2.width * 0.9836207,
        size2.height * 0.8268551,
        size2.width * 0.5396552,
        size2.height * 0.5689046,
        size2.width * 0.4224138,
        size2.height * 0.5636042);
    shape1.cubicTo(
        size2.width * 0.3051724,
        size2.height * 0.5583039,
        size2.width * 0.2568966,
        size2.height * 0.8595406,
        size2.width * 0.1232759,
        size2.height * 0.9743816);
    shape1.cubicTo(
        size2.width * -0.01034502,
        size2.height * 1.089223,
        size2.width * -0.06896534,
        size2.height * 0.7720848,
        size2.width * 0.1232759,
        size2.height * 0.6678445);
    shape1.cubicTo(
        size2.width * 0.3155172,
        size2.height * 0.5636042,
        size2.width * 0.2568966,
        size2.height * 0.3613074,
        size2.width * 0.1232759,
        size2.height * 0.3171378);
    shape1.close();

    Paint shape1Fill = Paint()..style = PaintingStyle.fill;
    shape1Fill.color = const Color(0xffFB7750).withOpacity(1.0);
    rotate(canvas1, size2, 5);
    canvas1.translate(10, -30);
    canvas1.drawPath(shape1, shape1Fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // Since this Line painter has no fields, it always paints
    // the same thing, and therefore we return false here. If
    // we had fields (set from the constructor) then we would
    // return true if any of them differed from the same
    // fields on the oldDelegate.
    return false;
  }
}

class YellowShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // calculated by find what percentage of Pixel 5 width is 150
    // double weightRatio = (100*120)/size1.width;
    double widthRatio = 0.30555555555555554;
    // calculated by find what percentage of Pixel 5 height is 450
    // double heightRatio = (100*530)/size1.height;
    double heightRatio = 0.6804388422035481;

    Size size2 = Size(size.width - (size.width * widthRatio),
        size.height - (size.height * heightRatio));
    Canvas canvas1 = canvas;
    // print('this is passed size -> ${size.width} --> ${size.height}');
    Path shape = Path();
    shape.moveTo(size2.width * 0.4427350, size2.height * 0.7713287);
    shape.cubicTo(
        size2.width * 0.8817009,
        size2.height * 0.2853147,
        size2.width * 0.1128205,
        size2.height * 0.2734266,
        size2.width * 0.01965795,
        size2.height * 0.1951049);
    shape.cubicTo(
        size2.width * -0.008547282,
        size2.height * 0.1454545,
        size2.width * -0.003743658,
        size2.height * 0.08741259,
        size2.width * 0.02905915,
        size2.height * 0.04335664);
    shape.cubicTo(
        size2.width * 0.1196568,
        size2.height * -0.07832168,
        size2.width * 0.4427350,
        size2.height * 0.08671329,
        size2.width * 0.7333333,
        size2.height * 0.1951049);
    shape.cubicTo(
        size2.width * 1.023930,
        size2.height * 0.3034965,
        size2.width * 1.046152,
        size2.height * 0.5979021,
        size2.width * 0.9452974,
        size2.height * 0.8447552);
    shape.cubicTo(
        size2.width * 0.8444427,
        size2.height * 1.091608,
        size2.width * 0.1829043,
        size2.height * 1.026573,
        size2.width * 0.4427350,
        size2.height * 0.7713287);
    shape.close();

    Paint shapeFill = Paint()..style = PaintingStyle.fill;
    shapeFill.color = const Color(0xffFDB914).withOpacity(1.0);
    rotate(canvas1, size2, 6);
    canvas1.translate(150, 350);
    canvas1.drawPath(shape, shapeFill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // Since this Line painter has no fields, it always paints
    // the same thing, and therefore we return false here. If
    // we had fields (set from the constructor) then we would
    // return true if any of them differed from the same
    // fields on the oldDelegate.
    return false;
  }
}

class RedShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // calculated by find what percentage of Pixel 5 width is 150
    // double weightRatio = (100*120)/size1.width;
    double widthRatio = 0.30555555555555554;
    // calculated by find what percentage of Pixel 5 height is 450
    // double heightRatio = (100*530)/size1.height;
    double heightRatio = 0.6804388422035481;

    Size size2 = Size(size.width - (size.width * widthRatio),
        size.height - (size.height * heightRatio));
    Canvas canvas1 = canvas;
    // print('this is passed size -> ${size.width} --> ${size.height}');
    Path shape = Path();
    shape.moveTo(size2.width * 0.1752490, size2.height * 0.007952441);
    shape.cubicTo(
        size2.width * -0.3000606,
        size2.height * -0.06807793,
        size2.width * -0.2333317,
        size2.height * 0.4197826,
        size2.width * -0.1405538,
        size2.height * 0.6732160);
    shape.cubicTo(
        size2.width * -0.1001418,
        size2.height * 0.7836056,
        size2.width * 0.08982163,
        size2.height * 0.9099343,
        size2.width * 0.2191399,
        size2.height * 0.9736808);
    shape.cubicTo(
        size2.width * 0.3807880,
        size2.height * 1.053366,
        size2.width * 0.2266337,
        size2.height * 0.6732160,
        size2.width * 0.3583072,
        size2.height * 0.4984930);
    shape.cubicTo(
        size2.width * 0.4899808,
        size2.height * 0.3237700,
        size2.width * 0.5927500,
        size2.height * 0.7485164,
        size2.width * 0.8496731,
        size2.height * 0.9488263);
    shape.cubicTo(
        size2.width * 1.106601,
        size2.height * 1.149136,
        size2.width * 0.9674327,
        size2.height * 0.7134272,
        size2.width * 0.9160481,
        size2.height * 0.4685202);
    shape.cubicTo(
        size2.width * 0.8646635,
        size2.height * 0.2236150,
        size2.width * 0.7693846,
        size2.height * 0.1029901,
        size2.width * 0.1752490,
        size2.height * 0.007952441);
    shape.close();

    Paint shapeFill = Paint()..style = PaintingStyle.fill;
    shapeFill.color = const Color(0xffFC3637).withOpacity(1.0);
    rotate(canvas1, size2, 6);
    canvas1.translate(-150, 350);
    canvas1.drawPath(shape, shapeFill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // Since this Line painter has no fields, it always paints
    // the same thing, and therefore we return false here. If
    // we had fields (set from the constructor) then we would
    // return true if any of them differed from the same
    // fields on the oldDelegate.
    return false;
  }
}

void rotate(Canvas canvas, Size size, double angle) {
  final double r =
      sqrt(size.width * size.width + size.height * size.height) / 2;
  final alpha = atan(size.height / size.width);
  final beta = alpha + angle;
  final shiftY = r * sin(beta);
  final shiftX = r * cos(beta);
  final translateX = size.width / 2 - shiftX;
  final translateY = size.height / 2 - shiftY;
  canvas.translate(translateX, translateY);
  canvas.rotate(angle);
}
