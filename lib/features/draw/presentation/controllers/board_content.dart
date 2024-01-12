import 'dart:ui';

import 'package:feynman_board/features/draw/domain/entities/board_content.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/shapes/draw_object.dart';
import 'board_config_controller.dart';

class BoardContentControllerNotifier extends Notifier<BoardContent> {
  @override
  build() {
    return BoardContent();
  }

  void addRectangleStartPoint(Offset startingPoint) {
    state = state.copyWith(startPosition: startingPoint);
  }

  void addToCurrentScribbles(Offset newScribble) {
    final updatedCurrentScribbles = [...state.currentScribbles, newScribble];
    state = state.copyWith(currentScribbles: updatedCurrentScribbles);
  }

  void addRectangleToCurrentScribbles(Offset offset) {
    //
  }

  void addRectangleToAllScribbles() {
    final Rect currentRectangle =
        Rect.fromPoints(state.startPoint!, state.stopPoint!);
    final rectangle = Rectangle(
      state.startPoint!,
      currentRectangle,
      ref.read(boardConfigProvider).strokeWidth,
      ref.read(boardConfigProvider).brushColor,
    );
    state = state.copyWith(rectangle: rectangle);
    state = state.copyWith(rectangle: null);
  }

  void addCurrentDoddleToAllScribbles() {
    saveCurrentState();
    final updatedScribbles = [
      ...state.allScribbles,
    ];
    state = state.copyWith(oldScribbles: updatedScribbles);
  }

  void clearBoard() {
    saveCurrentState();
    state = state.copyWith(oldScribbles: []);
  }

  void saveCurrentState() {
    state = state.copyWith(
      currentScribbles: [...state.currentScribbles],
    );

    // starting to use loops
    final savedScribbleStatesHistory = [
      ...state.savedScribbleStatesHistory,
    ];
    savedScribbleStatesHistory.add([...state.oldScribbles]);
    state = state.copyWith(
      savedScribbleStatesHistory: savedScribbleStatesHistory,
      currentScribbles: [...state.currentScribbles],
    );
  }

  void undoMove() {
    final allLastSavedState = state.savedScribbleStatesHistory;
    final allLastSavedStateLength = allLastSavedState.length;

    if (allLastSavedState.isNotEmpty) {
      state = state.copyWith(oldScribbles: allLastSavedState.last);
      allLastSavedState.removeAt(allLastSavedStateLength - 1);
      state = state.copyWith(savedScribbleStatesHistory: allLastSavedState);
    }
  }
}

final boardContentProvider =
    NotifierProvider<BoardContentControllerNotifier, BoardContent>(
        BoardContentControllerNotifier.new);
