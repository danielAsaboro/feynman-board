import 'package:feynman_board/features/draw/domain/enums/shape_type.dart';
import 'package:flutter/material.dart';

import 'shapes/draw_object.dart';

class BoardContent {
  late final Color brushColor;
  late final double strokeWidth;
  late final List<DrawObject?> oldScribbles;
  late final List<DrawObject?> currentScribbles;
  late final List<DrawObject?> lastSavedScribbles;
  late final List<List<DrawObject?>?> savedScribbleStatesHistory;
  late final ShapeType shape;

  List<DrawObject?> get allScribbles => [
        ...oldScribbles,
        ...currentScribbles,
      ];

  List<Color> supportedColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.amber,
    Colors.black,
    Colors.white,
  ];
  List<double> supportedStrokeWidth = [1, 2, 3, 4, 5];

  BoardContent({
    double? strokeWidth,
    Color? brushColor,
    List<DrawObject?>? oldScribbles,
    List<DrawObject?>? lastSavedScribbles,
    List<DrawObject?>? currentScribbles,
    List<List<DrawObject?>?>? savedScribbleStatesHistory,
    Offset? startPosition,
    Offset? stopPosition,
    ShapeType? shape,
  }) {
    this.strokeWidth = strokeWidth ?? 5;
    this.brushColor = brushColor ?? Colors.black;
    this.oldScribbles = oldScribbles ?? [];
    this.lastSavedScribbles = lastSavedScribbles ?? [];
    this.currentScribbles = currentScribbles ?? [];
    this.savedScribbleStatesHistory = savedScribbleStatesHistory ?? [];
    this.shape = shape ?? ShapeType.scribble;
  }

  BoardContent copyWith({
    double? strokeWidth,
    Color? brushColor,
    List<DrawObject?>? oldScribbles,
    List<DrawObject?>? lastSavedScribbles,
    List<DrawObject?>? currentScribbles,
    List<Color>? supportedColors,
    List<double>? supportedStrokeWidth,
    List<List<DrawObject?>?>? savedScribbleStatesHistory,
    ShapeType? shape,
  }) {
    return BoardContent(
      strokeWidth: strokeWidth ?? this.strokeWidth,
      brushColor: brushColor ?? this.brushColor,
      oldScribbles: oldScribbles ?? List.from(this.oldScribbles),
      lastSavedScribbles:
          lastSavedScribbles ?? List.from(this.lastSavedScribbles),
      currentScribbles: currentScribbles ?? [],
      savedScribbleStatesHistory: savedScribbleStatesHistory ??
          List.from(this.savedScribbleStatesHistory),
      shape: shape ?? this.shape,
    );
  }
}
