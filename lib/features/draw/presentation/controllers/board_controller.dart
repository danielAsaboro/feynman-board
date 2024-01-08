import 'package:feynman_board/features/draw/domain/enums/shape_type.dart';
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

  void changeShape(ShapeType shape) {
    state = state.copyWith(shape: shape);
    print("new shape: ${state.shape}");
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
      lastSavedScribbles: [...state.oldScribbles],
      currentScribbles: [...state.currentScribbles],
    );

    // starting to use loops
    final savedScribbleStatesHistory = [
      ...state.savedScribbleStatesHistory,
    ];
    savedScribbleStatesHistory.add([...state.lastSavedScribbles]);
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
    NotifierProvider<BoardControllerNotifier, BoardContent>(
        BoardControllerNotifier.new);
