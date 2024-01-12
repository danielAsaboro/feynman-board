import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/board_config.dart';
import '../controllers/board_config_controller.dart';

class StrokePalletteStore extends StatelessWidget {
  const StrokePalletteStore({
    super.key,
    required this.boardContent,
    required this.ref,
  });

  final BoardConfig boardContent;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...boardContent.supportedStrokeWidth.map((strokeWidth) {
          final isSelected = boardContent.strokeWidth == strokeWidth;
          return InkWell(
            onTap: () {
              ref
                  .read(boardConfigProvider.notifier)
                  .changeStrokeWidth(strokeWidth);
            },
            child: Container(
              margin: const EdgeInsets.all(5),
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                border: isSelected ? Border.all(color: Colors.black) : null,
                color: Colors.grey.shade300,
              ),
              child: Center(
                child: Container(
                  width: strokeWidth.toDouble(),
                  height: strokeWidth.toDouble(),
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}
