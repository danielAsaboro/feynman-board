
import 'package:flutter/material.dart';

import 'draw_object.dart';

class DrawingPainter extends CustomPainter {
  final List<DrawObject> objects;

  DrawingPainter(this.objects);

  @override
  void paint(Canvas canvas, Size size) {
    for (DrawObject object in objects) {
      object.paint(canvas);
    }
  }

  @override
  bool shouldRepaint(covariant DrawingPainter oldDelegate) {
    return true;
  }
}
