import 'package:feynman_board/features/draw/presentation/controllers/board_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/board_config.dart';
import '../../domain/enums/shape_type.dart';

class StrokeTypeStore extends StatelessWidget {
  const StrokeTypeStore({
    super.key,
    required this.boardConfig,
    required this.ref,
  });

  final BoardConfig boardConfig;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ...ShapeType.values.map((strokeType) {
        final isSelected = boardConfig.shapeType == strokeType;
        return InkWell(
          onTap: () {
            ref.read(boardConfigProvider.notifier).changeShapeType(strokeType);
          },
          child: Container(
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              border: isSelected ? Border.all(color: Colors.black) : null,
              color: Colors.grey.shade300,
            ),
            child: Center(
              child: Icon(strokeType.icon),
            ),
          ),
        );
      }).toList(),
    ]);
  }
}
