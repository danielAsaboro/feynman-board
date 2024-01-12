import 'dart:ui';

sealed class Scribble {
  final double strokeWidth;
  final Color color;

  Scribble(
    this.strokeWidth,
    this.color,
  );
}

class Doodle extends Scribble {
  final List<Offset?> points;

  Doodle(this.points, double strokeWidth, Color color)
      : super(strokeWidth, color);
}

class Line extends Scribble {
  final List<Offset?> points;

  Line(this.points, double strokeWidth, Color color)
      : super(strokeWidth, color);

  Line copyWith({
    List<Offset?>? points,
    double? strokeWidth,
    Color? color,
  }) {
    return Line(
      points ?? this.points,
      strokeWidth ?? this.strokeWidth,
      color ?? this.color,
    );
  }
}

class Rectangle extends Scribble {
  final Offset startPoint;
  final Rect rect;

  Rectangle(
    this.startPoint,
    this.rect,
    double strokeWidth,
    Color color,
  ) : super(strokeWidth, color);
}
