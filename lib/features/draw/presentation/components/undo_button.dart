import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/board.dart';
import '../controllers/board_controller.dart';

class UndoChangesButton extends StatelessWidget {
  const UndoChangesButton({
    super.key,
    required this.ref,
  });

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ref.read(boardContentProvider.notifier).undoMove();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 50,
              width: 50,
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
              ),
              child: Icon(
                Icons.replay_circle_filled_sharp,
                size: 50,
              )),
        ],
      ),
    );
  }
}
