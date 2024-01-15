import 'dart:ui';

import 'package:feynman_board/features/draw/domain/entities/board_content.dart';
import 'package:feynman_board/features/draw/presentation/controllers/board_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/shapes/draw_object.dart';
import '../../domain/enums/shape_type.dart';

class BoardContentControllerNotifier extends Notifier<BoardContent> {
  @override
  build() {
    return BoardContent(boardConfig: ref.read(boardConfigProvider));
  }

  void addStartingPoint(Offset startingPoint) {
    state = state.copyWith(
        boardConfig: ref.read(boardConfigProvider),
        startPosition: startingPoint);
  }

  void addScribbleToCurrentPenPath(Offset currentPoint) {
    final currentPenPath = [...state.currentPenPath];
    currentPenPath.add(currentPoint);
    state = state.copyWith(
      boardConfig: ref.read(boardConfigProvider),
      currentPenPath: currentPenPath,
    );
  }

  void addScribbleToCurrentRectangle(Offset currentPosition) {
    final startingPoint = state.startingPoint;
    final currentRectangle = Rect.fromPoints(startingPoint!, currentPosition);
    state = state.copyWith(
        boardConfig: ref.read(boardConfigProvider),
        currentRectangle: currentRectangle);
  }

  void addScribbleToCurrentOval(Offset currentPosition,
      {bool circleMode = false}) {
    final startingPoint = state.startingPoint;
    double width = currentPosition.dx - startingPoint!.dx;
    double height = currentPosition.dy - startingPoint.dy;

    if (circleMode) {
      // Enforce a circle by making the width and height equal
      double sideLength =
          width.abs() > height.abs() ? width.abs() : height.abs();
      width = sideLength * (width.isNegative ? -1 : 1);
      height = sideLength * (height.isNegative ? -1 : 1);
    }

    final currentOvalRectangle = Rect.fromPoints(
        startingPoint,
        Offset(
          startingPoint.dx + width,
          startingPoint.dy + height,
        ));

    state = state.copyWith(
      boardConfig: ref.read(boardConfigProvider),
      currentOvalRectangle: currentOvalRectangle,
    );

    // final startingPoint = state.startingPoint;
    // final currentOvalRectangle =
    //     Rect.fromPoints(startingPoint!, currentPosition);
    // state = state.copyWith(
    //     boardConfig: ref.read(boardConfigProvider),
    //     currentOvalRectangle: currentOvalRectangle);
  }

  void addScribbleToCurrentLine(Offset currentPosition) {
    final startingPoint = state.startingPoint;

    final currentLine = LineObject(
      startingPoint!,
      currentPosition,
      ref.read(boardConfigProvider).strokeWidth,
      ref.read(boardConfigProvider).brushColor,
    );
    state = state.copyWith(
        boardConfig: ref.read(boardConfigProvider), currentLine: currentLine);
  }

  void addShapeToAllScribbles() {
    saveCurrentState();

    final savedDrawObjects = [...state.savedDrawObjects];
    switch (ref.read(boardConfigProvider).shapeType) {
      case ShapeType.pen:
        savedDrawObjects.add(PenObject(
          state.currentPenPath,
          ref.read(boardConfigProvider).strokeWidth,
          ref.read(boardConfigProvider).brushColor,
        ));
        state = state.copyWith(
          boardConfig: ref.read(boardConfigProvider),
          currentPenPath: state.currentPenPath,
          savedDrawObjects: savedDrawObjects,
        );
        break;
      case ShapeType.rectangle:
        savedDrawObjects.add(RectangleObject(
          state.currentRectangle!,
          ref.read(boardConfigProvider).strokeWidth,
          ref.read(boardConfigProvider).brushColor,
        ));
        state = state.copyWith(
          boardConfig: ref.read(boardConfigProvider),
          currentRectangle: null,
          savedDrawObjects: savedDrawObjects,
        );
        break;
      case ShapeType.oval:
        savedDrawObjects.add(OvalObject(
          state.currentOvalRectangle!,
          ref.read(boardConfigProvider).strokeWidth,
          ref.read(boardConfigProvider).brushColor,
        ));
        state = state.copyWith(
          boardConfig: ref.read(boardConfigProvider),
          savedDrawObjects: savedDrawObjects,
        );
        break;
      case ShapeType.line:
        savedDrawObjects.add(state.currentLine!);
        state = state.copyWith(
          boardConfig: ref.read(boardConfigProvider),
          savedDrawObjects: savedDrawObjects,
        );
        break;
    }
  }

  void clearBoard() {
    saveCurrentState();
    state = state.copyWith(
      boardConfig: ref.read(boardConfigProvider),
      savedDrawObjects: [],
    );
  }

  void saveCurrentState() {
    final savedScribbleStatesHistory = [
      ...state.savedDrawObjectStatesHistory,
    ];
    savedScribbleStatesHistory.add([...state.savedDrawObjects]);
    state = state.copyWith(
      boardConfig: ref.read(boardConfigProvider),
      savedDrawObjectStatesHistory: savedScribbleStatesHistory,
      currentPenPath: state.currentPenPath,
      currentRectangle: state.currentRectangle,
      currentLine: state.currentLine,
      currentOvalRectangle: state.currentOvalRectangle,
    );
  }

  void undoMove() {
    final allLastSavedState = [...state.savedDrawObjectStatesHistory];
    final allLastSavedStateLength = allLastSavedState.length;

    if (allLastSavedState.isNotEmpty) {
      state = state.copyWith(
        boardConfig: ref.read(boardConfigProvider),
        savedDrawObjects: allLastSavedState.last,
      );
      allLastSavedState.removeAt(allLastSavedStateLength - 1);
      state = state.copyWith(
        boardConfig: ref.read(boardConfigProvider),
        savedDrawObjectStatesHistory: allLastSavedState,
      );
    }
  }
}

final boardContentProvider =
    NotifierProvider<BoardContentControllerNotifier, BoardContent>(
        BoardContentControllerNotifier.new);
