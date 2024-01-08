import 'dart:ui';

import 'package:feynman_board/features/draw/domain/entities/shapes/brush.dart';
import 'package:flutter/material.dart';

import 'draw_object.dart';

class DrawingPainter extends CustomPainter with Brush {
  final List<DrawObject> objects;

  DrawingPainter(this.objects);

  @override
  void paint(Canvas canvas, Size size) {
    for (DrawObject object in objects) {
      switch (object) {
        case PenObject():
          final points = object.points;
          for (int i = 0; i < points.length - 1; i++) {
            if (points[i] != null && points[i + 1] != null) {
              canvas.drawLine(points[i]!, points[i + 1]!,
                  getPaint(object.color, object.strokeWidth));
            } else if (points[i] != null && points[i + 1] == null) {
              canvas.drawPoints(PointMode.points, [points[i]!],
                  getPaint(object.color, object.strokeWidth));
            }
          }
          break;
        case RectangleObject():
          canvas.drawRect(
              object.rect, getRectPaint(object.color, object.strokeWidth));
          break;
        case LineObject():
          canvas.drawLine(object.startPoint, object.endPoint,
              getPaint(object.color, object.strokeWidth));
      }
    }
  }

  @override
  bool shouldRepaint(covariant DrawingPainter oldDelegate) {
    return true;
  }
}
