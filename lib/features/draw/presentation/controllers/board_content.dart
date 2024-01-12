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

  void addScribbleToCurrentOval(Offset currentPosition) {
    final startingPoint = state.startingPoint;
    final currentOvalRectangle =
        Rect.fromPoints(startingPoint!, currentPosition);
    state = state.copyWith(
        boardConfig: ref.read(boardConfigProvider),
        currentOvalRectangle: currentOvalRectangle);
  }

  void addScribbleToCurrentLine(Offset currentPosition) {
    final startingPoint = state.startingPoint;

    final currentLine = LineObject(
      startingPoint!,
      currentPosition,
      ref.read(boardConfigProvider).strokeWidth,
      ref.read(boardConfigProvider).brushColor,
    );
    print(currentLine);
    state = state.copyWith(
        boardConfig: ref.read(boardConfigProvider), currentLine: currentLine);
  }

  void addScribbleToCurrentCircle(Offset currentPosition) {
    // calculate center offset between starting point and current point
    final center = Offset(
      (state.startingPoint!.dx + currentPosition.dx) / 2,
      (state.startingPoint!.dy + currentPosition.dy) / 2,
    );
    // calculate radius
    final radius = (center - currentPosition).distance;

    final currentCircle = CircleObject(
      center,
      radius,
      ref.read(boardConfigProvider).strokeWidth,
      ref.read(boardConfigProvider).brushColor,
    );
    state = state.copyWith(
        boardConfig: ref.read(boardConfigProvider),
        currentCircle: currentCircle);
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
        print("rectangle added");
        print(savedDrawObjects);
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
          // currentOvalRectangle: null,
          savedDrawObjects: savedDrawObjects,
        );
        break;
      case ShapeType.line:
        savedDrawObjects.add(state.currentLine!);
        state = state.copyWith(
          boardConfig: ref.read(boardConfigProvider),
          // currentLine: null,
          savedDrawObjects: savedDrawObjects,
        );
        break;
      case ShapeType.circle:
        savedDrawObjects.add(state.currentCircle!);
        state = state.copyWith(
          boardConfig: ref.read(boardConfigProvider),
          // currentCircle: null,
          savedDrawObjects: savedDrawObjects,
        );
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
    print("printing current board");
    print(state.savedDrawObjects);
    savedScribbleStatesHistory.add([...state.savedDrawObjects]);
    state = state.copyWith(
      boardConfig: ref.read(boardConfigProvider),
      savedDrawObjectStatesHistory: savedScribbleStatesHistory,
      currentPenPath: state.currentPenPath,
      currentRectangle: state.currentRectangle,
      currentCircle: state.currentCircle,
      currentLine: state.currentLine,
      currentOvalRectangle: state.currentOvalRectangle,
    );
  }

  void undoMove() {
    final allLastSavedState = [...state.savedDrawObjectStatesHistory];
    print("printing last saved state");
    print(allLastSavedState);
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
