import 'dart:ui';

sealed class DrawObject {
  final double strokeWidth;
  final Color color;

  DrawObject(this.strokeWidth, this.color);
}

class LineObject extends DrawObject {
  final List<Offset?> points;

  LineObject(this.points, double strokeWidth, Color color) : super(strokeWidth, color);

  LineObject copyWith({
    List<Offset?>? points,
    double? strokeWidth,
    Color? color,
  }) {
    return LineObject(
      points ?? this.points,
      strokeWidth ?? this.strokeWidth,
      color ?? this.color,
    );
  }
}

class RectangleObject extends DrawObject {
  final Rect rect;

  RectangleObject(this.rect, double strokeWidth, Color color) : super(strokeWidth, color);
}
