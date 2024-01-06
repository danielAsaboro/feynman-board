import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/board.dart';
import '../controllers/board_controller.dart';

class ColorPaletteStore extends StatelessWidget {
  const ColorPaletteStore({
    super.key,
    required this.boardContent,
    required this.ref,
  });

  final BoardContent boardContent;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ...boardContent.supportedColors.map((color) {
          final isSelected = boardContent.brushColor == color;
          return InkWell(
            onTap: () {
              ref.read(boardContentProvider.notifier).changeBrushColor(color);
            },
            child: Container(
              padding: const EdgeInsets.all(1),
              decoration: isSelected
                  ? const BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.fromBorderSide(
                        BorderSide(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                    )
                  : null,
              child: Container(
                margin: const EdgeInsets.all(5),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                child: isSelected
                    ? const Center(
                        child: Icon(
                          Icons.done,
                          color: Colors.white,
                          size: 15,
                        ),
                      )
                    : Container(),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}
