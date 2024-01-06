import 'dart:ui';

import 'package:flutter/material.dart';

import 'draw_object.dart';

class DrawingPainter extends CustomPainter {
  final List<DrawObject?> objects;

  DrawingPainter(this.objects);

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < objects.length - 1; i++) {
      if (objects[i] != null && objects[i + 1] != null) {
        DrawObject currentObject = objects[i]!;
        DrawObject nextObject = objects[i + 1]!;

        canvas.drawLine(currentObject.offset, nextObject.offset,
            _getPaint(currentObject.color, currentObject.strokeWidth));
      } else if (objects[i] != null && objects[i + 1] == null) {
        DrawObject drawObject = objects[i]!;
        canvas.drawPoints(PointMode.points, [drawObject.offset],
            _getPaint(drawObject.color, drawObject.strokeWidth));
      }
    }
  }

  Paint _getPaint(Color color, double strokeWidth) {
    return Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
