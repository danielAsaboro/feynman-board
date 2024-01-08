import 'package:feynman_board/features/draw/presentation/screens/board.dart';
import 'package:flutter/material.dart';

import 'shapes/draw_object.dart';

class BoardConfig {
  late final Color brushColor;
  late final double strokeWidth;
  late final StrokeType strokeType;

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
    StrokeType? strokeType,
    List<DrawObject>? drawObjectsList,
  }) {
    this.strokeWidth = strokeWidth ?? 5;
    this.brushColor = brushColor ?? Colors.black;
    this.strokeType = strokeType ?? StrokeType.pen;
  }

  static Rect? currentRectangle;
  static  Offset? startingPoint;
  static List<Offset> currentLinePath = [];

  BoardConfig copyWith({
    double? strokeWidth,
    Color? brushColor,
    StrokeType? strokeType,
  }) {
    return BoardConfig(
      strokeWidth: strokeWidth ?? this.strokeWidth,
      brushColor: brushColor ?? this.brushColor,
      strokeType: strokeType ?? this.strokeType,
    );
  }
}
