import 'dart:ui';

import 'package:feynman_board/features/draw/domain/entities/shapes/brush.dart';
import 'package:flutter/material.dart';

import 'draw_object.dart';

class DrawingPainter extends CustomPainter with Brush {
  final List<Scribble> objects;
  DrawingPainter(this.objects);

  @override
  void paint(Canvas canvas, Size size) {
    for (Scribble object in objects) {
      switch (object) {
        case Doodle():
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
        case Rectangle():
          canvas.drawRect(
              object.rect, getRectPaint(object.color, object.strokeWidth));
          break;

        case Line():
          // TODO: Handle this case.
          break;

        default:
          break;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
