import 'dart:ui';

import 'package:feynman_board/features/draw/domain/entities/shapes/brush.dart';

sealed class DrawObject with Brush {
  final double strokeWidth;
  final Color color;

  DrawObject(this.strokeWidth, this.color);

  void paint(Canvas canvas);
}

class PenObject extends DrawObject {
  final List<Offset?> points;

  PenObject(this.points, double strokeWidth, Color color)
      : super(strokeWidth, color);

  PenObject copyWith({
    List<Offset?>? points,
    double? strokeWidth,
    Color? color,
  }) {
    return PenObject(
      points ?? this.points,
      strokeWidth ?? this.strokeWidth,
      color ?? this.color,
    );
  }

  @override
  void paint(Canvas canvas) {
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(
            points[i]!, points[i + 1]!, getPaint(color, strokeWidth));
      } else if (points[i] != null && points[i + 1] == null) {
        canvas.drawPoints(
            PointMode.points, [points[i]!], getPaint(color, strokeWidth));
      }
    }
  }
}

class RectangleObject extends DrawObject {
  final Rect rect;

  RectangleObject(this.rect, double strokeWidth, Color color)
      : super(strokeWidth, color);

  @override
  void paint(Canvas canvas) {
    canvas.drawRect(rect, getOutlinedPaint(color, strokeWidth));
  }
}

class OvalObject extends DrawObject {
  final Rect rect;

  OvalObject(this.rect, double strokeWidth, Color color)
      : super(strokeWidth, color);

  @override
  void paint(Canvas canvas) {
    canvas.drawOval(rect, getOutlinedPaint(color, strokeWidth));
  }
}

class LineObject extends DrawObject {
  final Offset startPoint;
  final Offset endPoint;

  LineObject(this.startPoint, this.endPoint, double strokeWidth, Color color)
      : super(strokeWidth, color);

  @override
  void paint(Canvas canvas) {
    canvas.drawLine(startPoint, endPoint, getPaint(color, strokeWidth));
  }
}
