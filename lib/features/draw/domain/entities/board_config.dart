import 'package:feynman_board/features/draw/domain/enums/shape_type.dart';
import 'package:flutter/material.dart';

class BoardConfig {
  late final Color brushColor;
  late final double strokeWidth;
  late final ShapeType shapeType;

  List<Color> supportedColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.amber,
    Colors.black,
    Colors.white,
  ];
  List<double> supportedStrokeWidth = [1, 2, 3, 4, 5];

  BoardConfig({
    double? strokeWidth,
    Color? brushColor,
    ShapeType? shapeType,
  }) {
    this.strokeWidth = strokeWidth ?? 5;
    this.brushColor = brushColor ?? Colors.black;
    this.shapeType = shapeType ?? ShapeType.pen;
  }

  static Rect? currentRectangle;
  static Offset? startingPoint;
  static List<Offset> currentLinePath = [];

  BoardConfig copyWith({
    double? strokeWidth,
    Color? brushColor,
    // ScribbleType? shape,
    ShapeType? shapeType,
  }) {
    return BoardConfig(
      strokeWidth: strokeWidth ?? this.strokeWidth,
      brushColor: brushColor ?? this.brushColor,
      shapeType: shapeType ?? this.shapeType,
    );
  }
}
