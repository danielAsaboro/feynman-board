import 'dart:ui';

sealed class DrawObject {
  final double strokeWidth;
  final Color color;

  DrawObject(this.strokeWidth, this.color);
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
}

class RectangleObject extends DrawObject {
  final Rect rect;

  RectangleObject(this.rect, double strokeWidth, Color color)
      : super(strokeWidth, color);
}
