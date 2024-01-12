import 'package:flutter/material.dart';

import 'shapes/draw_object.dart';

class BoardContent {
  late final List<Scribble> oldScribbles;
  late final List<Offset?> currentScribbles;
  late final List<List<Scribble>?> savedScribbleStatesHistory;
  late final Offset? startPoint;
  late final Offset? stopPoint;
  late final Rectangle? rectangle;
  late final Color brushColor;
  late final double strokeWidth;

  List<Scribble> get allScribbles => [
        if (oldScribbles.isNotEmpty) ...oldScribbles,
        if (currentScribbles.isNotEmpty)
          Line(currentScribbles, strokeWidth, brushColor),
        if (rectangle != null) rectangle!,
      ];

  BoardContent({
    List<Scribble>? oldScribbles,
    List<Offset?>? currentScribbles,
    List<List<Scribble>?>? savedScribbleStatesHistory,
    Offset? startPosition,
    Offset? stopPosition,
    Rectangle? rectangle,
    Color? brushColor,
    double? strokeWidth,
  }) {
    this.oldScribbles = oldScribbles ?? [];
    this.currentScribbles = currentScribbles ?? [];
    this.savedScribbleStatesHistory = savedScribbleStatesHistory ?? [];
    this.startPoint = startPosition;
    this.stopPoint = stopPosition;
    this.rectangle = rectangle;
    this.brushColor = brushColor ?? Colors.black;
    this.strokeWidth = strokeWidth ?? 5;
  }

  BoardContent copyWith({
    List<Scribble>? oldScribbles,
    List<Offset?>? currentScribbles,
    List<List<Scribble>?>? savedScribbleStatesHistory,
    Offset? startPosition,
    Offset? stopPosition,
    Rectangle? rectangle,
    Color? brushColor,
    double? strokeWidth,
  }) {
    return BoardContent(
      oldScribbles: oldScribbles ?? List.from(this.oldScribbles),
      currentScribbles: currentScribbles ?? [],
      savedScribbleStatesHistory: savedScribbleStatesHistory ??
          List.from(this.savedScribbleStatesHistory),
      startPosition:
          startPosition ?? ((stopPosition != null) ? this.startPoint : null),
      stopPosition: stopPosition,
      rectangle: rectangle,
      brushColor: brushColor ?? this.brushColor,
      strokeWidth: strokeWidth ?? this.strokeWidth,
    );
  }
}
