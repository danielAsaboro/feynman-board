import 'package:feynman_board/features/draw/presentation/screens/board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/board.dart';
import '../controllers/board_controller.dart';

class StrokeTypeStore extends StatelessWidget {
  const StrokeTypeStore({
    super.key,
    required this.boardContent,
    required this.ref,
  });

  final BoardContent boardContent;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ...StrokeType.values.map((strokeType) {
        final isSelected = boardContent.strokeType == strokeType;
        return InkWell(
          onTap: () {
            ref
                .read(boardContentProvider.notifier)
                .changeStrokeType(strokeType);
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
