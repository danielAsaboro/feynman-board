import 'dart:ui';

import '../../enums/shape_type.dart';

class DrawObject {
  final Offset offset;
  final double strokeWidth;
  final Color color;
  late final ShapeType shape;

  DrawObject(
    this.offset,
    this.strokeWidth,
    this.color,
    ShapeType? shape,
  ) {
    this.shape = shape ?? ShapeType.scribble;
  }
}
