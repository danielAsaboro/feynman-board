import 'package:feynman_board/features/draw/domain/entities/board_config.dart';
import 'package:flutter/material.dart';

import 'shapes/draw_object.dart';

class BoardContent {
  late final Rect? currentRectangle;
  late final Rect? currentOvalRectangle;
  late final Offset? startingPoint;
  late final LineObject? currentLine;
  late final CircleObject? currentCircle;
  late final List<Offset?> currentPenPath;

  late final BoardConfig _boardConfig;

  late final List<DrawObject> savedDrawObjects;
  late final List<List<DrawObject>?> savedDrawObjectStatesHistory;

  List<DrawObject> get objectsToDraw => [
        ...savedDrawObjects,
        if (currentPenPath.isNotEmpty)
          PenObject(
            currentPenPath,
            _boardConfig.strokeWidth,
            _boardConfig.brushColor,
          ),
        if (currentRectangle != null)
          RectangleObject(
            currentRectangle!,
            _boardConfig.strokeWidth,
            _boardConfig.brushColor,
          ),
        if (currentOvalRectangle != null)
          OvalObject(
            currentOvalRectangle!,
            _boardConfig.strokeWidth,
            _boardConfig.brushColor,
          ),
        if (currentLine != null) currentLine!,
        if (currentCircle != null) currentCircle!,
      ];

  BoardContent({
    required boardConfig,
    List<DrawObject>? savedDrawObjects,
    List<List<DrawObject>?>? savedDrawObjectStatesHistory,
    List<Offset?>? currentPenPath,
    this.currentRectangle,
    this.currentOvalRectangle,
    this.startingPoint,
    this.currentLine,
    this.currentCircle,
  }) {
    this.savedDrawObjects = savedDrawObjects ?? [];
    this.savedDrawObjectStatesHistory = savedDrawObjectStatesHistory ?? [];
    this.currentPenPath = currentPenPath ?? [];
    _boardConfig = boardConfig;
  }

  BoardContent copyWith({
    List<DrawObject>? savedDrawObjects,
    List<List<DrawObject>?>? savedDrawObjectStatesHistory,
    Offset? startPosition,
    Offset? stopPosition,
    required BoardConfig boardConfig,
    List<Offset?>? currentPenPath,
    Rect? currentRectangle,
    Rect? currentOvalRectangle,
    Offset? startingPoint,
    LineObject? currentLine,
    CircleObject? currentCircle,
  }) {
    return BoardContent(
      boardConfig: boardConfig,
      savedDrawObjects: savedDrawObjects ?? this.savedDrawObjects,
      savedDrawObjectStatesHistory: savedDrawObjectStatesHistory ??
          List.from(this.savedDrawObjectStatesHistory),
      startingPoint: startPosition ?? this.startingPoint,
      currentPenPath: currentPenPath,
      currentRectangle: currentRectangle,
      currentCircle: currentCircle,
      currentLine: currentLine,
      currentOvalRectangle: currentOvalRectangle,
    );
  }
}
