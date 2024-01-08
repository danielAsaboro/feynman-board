import 'dart:ui';

import 'package:feynman_board/features/draw/domain/entities/shapes/brush.dart';
import 'package:feynman_board/features/draw/domain/enums/shape_type.dart';
import 'package:flutter/material.dart';

import 'draw_object.dart';

class Doodle extends CustomPainter with Brush {
  final List<DrawObject?> objects;
  Doodle(this.objects);

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < objects.length - 1; i++) {
      if (objects[i] != null && objects[i + 1] != null) {
        final DrawObject currentObject = objects[i]!;
        final DrawObject nextObject = objects[i + 1]!;
        final DrawObject lastObject = objects.last!;

        final shape = currentObject.shape;

        switch (shape) {
          case ShapeType.scribble:
            canvas.drawLine(
              currentObject.offset,
              nextObject.offset,
              getPaint(
                currentObject.color,
                currentObject.strokeWidth,
              ),
            );
            break;
          // case ShapeType.line:
          //   canvas.drawLine(
          //     currentObject.offset,
          //     lastObject.offset,
          //     getPaint(
          //       currentObject.color,
          //       currentObject.strokeWidth,
          //     ),
          //   );
            // break;
          default:
          // Handle other shape types if needed
        }
      } else if (objects[i] != null && objects[i + 1] == null) {
        DrawObject drawObject = objects[i]!;
        canvas.drawPoints(
          PointMode.points,
          [drawObject.offset],
          getPaint(
            drawObject.color,
            drawObject.strokeWidth,
          ),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
