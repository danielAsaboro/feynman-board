import 'package:feynman_board/features/draw/domain/enums/shape_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/board_config.dart';

class BoardConfigControllerNotifier extends Notifier<BoardConfig> {
  @override
  build() {
    return BoardConfig();
  }

  void changeShape(ScribbleType shape) {
    state = state.copyWith(shape: shape);
    print("new shape: ${state.shape}");
  }

  void changeStrokeWidth(double width) {
    state = state.copyWith(strokeWidth: width);
  }

  void changeBrushColor(Color color) {
    state = state.copyWith(brushColor: color);
  }
}

final boardConfigProvider =
    NotifierProvider<BoardConfigControllerNotifier, BoardConfig>(
        BoardConfigControllerNotifier.new);
