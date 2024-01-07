import 'dart:ui';

import 'package:feynman_board/features/draw/domain/entities/shapes/brush.dart';
import 'package:flutter/material.dart';

import 'draw_object.dart';

class DrawingPainter extends CustomPainter with Brush {
  final List<DrawObject?> objects;
  final List<Rect> rectangles;
  final Rect? currentRectangle;

  DrawingPainter(this.objects, {
    required this.rectangles,
    required this.currentRectangle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < objects.length - 1; i++) {
      if (objects[i] != null && objects[i + 1] != null) {
        DrawObject currentObject = objects[i]!;
        DrawObject nextObject = objects[i + 1]!;

        canvas.drawLine(currentObject.offset, nextObject.offset,
            getPaint(currentObject.color, currentObject.strokeWidth));
      } else if (objects[i] != null && objects[i + 1] == null) {
        DrawObject drawObject = objects[i]!;
        canvas.drawPoints(PointMode.points, [drawObject.offset],
            getPaint(drawObject.color, drawObject.strokeWidth));
      }
    }

    Paint paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    for (Rect rectangle in rectangles) {
      canvas.drawRect(rectangle, paint);
    }

    if (currentRectangle != null) {
      canvas.drawRect(currentRectangle!, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
