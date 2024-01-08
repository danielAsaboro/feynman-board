import 'package:feynman_board/features/draw/presentation/screens/board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/board.dart';

class BoardControllerNotifier extends Notifier<BoardConfig> {
  @override
  build() {
    return BoardConfig();
  }
  void changeStrokeWidth(double width) {
    state = state.copyWith(strokeWidth: width);
  }

  void changeBrushColor(Color color) {
    state = state.copyWith(brushColor: color);
  }

  void changeStrokeType(StrokeType strokeType) {
    state = state.copyWith(strokeType: strokeType);
  }
}

final boardContentProvider =
    NotifierProvider<BoardControllerNotifier, BoardConfig>(
        BoardControllerNotifier.new);
