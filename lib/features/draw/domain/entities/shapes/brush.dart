import 'dart:ui';

mixin Brush {
  Paint getPaint(Color color, double strokeWidth) {
    return Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;
  }

  Paint getOutlinedPaint(Color color, double strokeWidth) {
    return Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;
  }
}
