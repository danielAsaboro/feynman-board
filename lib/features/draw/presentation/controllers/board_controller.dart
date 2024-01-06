import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/board.dart';
import '../../domain/entities/shapes/draw_object.dart';

class BoardControllerNotifier extends Notifier<BoardContent> {
  @override
  build() {
    return BoardContent();
  }

  void addToCurrentScribbles(DrawObject? newScribble) {
    final updatedCurrentScribbles = [...state.currentScribbles, newScribble];
    state = state.copyWith(currentScribbles: updatedCurrentScribbles);
  }

  void allCurrentScribblesToAllScribbles() {
    saveCurrentState();
    final updatedScribbles = [
      ...state.allScribbles,
      null,
    ];
    state = state.copyWith(oldScribbles: updatedScribbles);
  }

  void changeStrokeWidth(double width) {
    state = state.copyWith(strokeWidth: width);
  }

  void changeBrushColor(Color color) {
    state = state.copyWith(brushColor: color);
  }

  void clearBoard() {
    saveCurrentState();
    state = state.copyWith(oldScribbles: []);
  }

  void saveCurrentState() {
    state = state.copyWith(
      previouslySavedScribbles: [...state.oldScribbles],
      currentScribbles: [...state.currentScribbles],
    );

    // starting to use loops
    final allLastSavedState = [
      ...state.allLastSavedState,
    ];
    allLastSavedState.add([...state.previouslySavedScribbles]);
    state = state.copyWith(
      allLastSavedState: allLastSavedState,
      currentScribbles: [...state.currentScribbles],
    );
  }

  void undoMove() {
    final allLastSavedState = state.allLastSavedState;
    final allLastSavedStateLength = allLastSavedState.length;

    if (allLastSavedState.isNotEmpty) {
      state = state.copyWith(oldScribbles: allLastSavedState.last);
      allLastSavedState.removeAt(allLastSavedStateLength - 1);
      state = state.copyWith(allLastSavedState: allLastSavedState);
    }
  }
}

final boardContentProvider =
    NotifierProvider<BoardControllerNotifier, BoardContent>(
        BoardControllerNotifier.new);
