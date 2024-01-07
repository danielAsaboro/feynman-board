import 'package:feynman_board/features/draw/presentation/screens/board.dart';
import 'package:flutter/material.dart';

import 'shapes/draw_object.dart';

class BoardContent {
  late final Color brushColor;
  late final double strokeWidth;
  late final StrokeType strokeType;
  late final List<DrawObject?> oldScribbles;
  late final List<DrawObject?> currentScribbles;
  late final List<DrawObject?> previouslySavedScribbles;
  late final List<List<DrawObject?>?> allLastSavedState;

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
    StrokeType? strokeType,
    List<DrawObject?>? oldScribbles,
    List<DrawObject?>? previouslySavedScribbles,
    List<DrawObject?>? currentScribbles,
    List<List<DrawObject?>?>? allLastSavedState,
  }) {
    this.strokeWidth = strokeWidth ?? 5;
    this.brushColor = brushColor ?? Colors.black;
    this.strokeType = strokeType ?? StrokeType.pen;
    this.oldScribbles = oldScribbles ?? [];
    this.previouslySavedScribbles = previouslySavedScribbles ?? [];
    this.currentScribbles = currentScribbles ?? [];
    this.allLastSavedState = allLastSavedState ?? [];
  }

  BoardContent copyWith({
    double? strokeWidth,
    Color? brushColor,
    StrokeType? strokeType,
    List<DrawObject?>? oldScribbles,
    List<DrawObject?>? previouslySavedScribbles,
    List<DrawObject?>? currentScribbles,
    List<Color>? supportedColors,
    List<double>? supportedStrokeWidth,
    List<List<DrawObject?>?>? allLastSavedState,
  }) {
    return BoardContent(
      strokeWidth: strokeWidth ?? this.strokeWidth,
      brushColor: brushColor ?? this.brushColor,
      strokeType: strokeType ?? this.strokeType,
      oldScribbles: oldScribbles ?? List.from(this.oldScribbles),
      previouslySavedScribbles:
          previouslySavedScribbles ?? List.from(this.previouslySavedScribbles),
      currentScribbles: currentScribbles ?? [],
      allLastSavedState: allLastSavedState ?? List.from(this.allLastSavedState),
    );
  }
}


