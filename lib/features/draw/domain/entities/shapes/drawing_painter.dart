import 'dart:ui';

import 'package:feynman_board/features/draw/domain/entities/shapes/brush.dart';
import 'package:flutter/material.dart';

import 'draw_object.dart';

class DrawingPainter extends CustomPainter with Brush {
  final List<DrawObject?> objects;

  DrawingPainter(this.objects);

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
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
