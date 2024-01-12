import 'package:feynman_board/features/draw/domain/enums/shape_type.dart';
import 'package:flutter/material.dart';

import 'shapes/draw_object.dart';

class BoardConfig {
  late final Color brushColor;
  late final double strokeWidth;
  late final ScribbleType shape;

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
    List<Scribble?>? oldScribbles,
    List<Scribble?>? lastSavedScribbles,
    List<Scribble?>? currentScribbles,
    List<List<Scribble?>?>? savedScribbleStatesHistory,
    Offset? startPosition,
    Offset? stopPosition,
    ScribbleType? shape,
  }) {
    this.strokeWidth = strokeWidth ?? 5;
    this.brushColor = brushColor ?? Colors.black;
    this.shape = shape ?? ScribbleType.doodle;
  }

  BoardConfig copyWith({
    double? strokeWidth,
    Color? brushColor,
    ScribbleType? shape,
  }) {
    return BoardConfig(
      strokeWidth: strokeWidth ?? this.strokeWidth,
      brushColor: brushColor ?? this.brushColor,
      shape: shape ?? this.shape,
    );
  }
}
