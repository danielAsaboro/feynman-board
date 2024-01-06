import 'package:feynman_board/features/draw/domain/entities/board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/shapes/draw_object.dart';
import '../../domain/entities/shapes/drawing_painter.dart';
import '../components/color_palette_store.dart';
import '../components/stroke_pallet_store.dart';
import '../components/undo_button.dart';
import '../controllers/board_controller.dart';

class BoardWidget extends ConsumerStatefulWidget {
  const BoardWidget({super.key});

  @override
  ConsumerState<BoardWidget> createState() => _BoardWidgetState();
}

class _BoardWidgetState extends ConsumerState<BoardWidget> {
  @override
  Widget build(BuildContext context) {
    final boardContent = ref.watch(boardContentProvider);
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onPanUpdate: (details) {
                  RenderBox renderBox = context.findRenderObject() as RenderBox;
                  final offset =
                      renderBox.globalToLocal(details.globalPosition);

                  final newScribble = DrawObject(
                    offset,
                    boardContent.strokeWidth,
                    boardContent.brushColor,
                  );
                  ref
                      .read(boardContentProvider.notifier)
                      .addToCurrentScribbles(newScribble);
                },
                onPanEnd: (details) {
                  // adding a null value here to separate individual strokes
                  ref
                      .read(boardContentProvider.notifier)
                      .allCurrentScribblesToAllScribbles();
                },
                child: CustomPaint(
                  painter: DrawingPainter(boardContent.allScribbles),
                ),
              ),
            ),
            Positioned(
              bottom: 12,
              left: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Stroke Width",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )),
                  StrokePalletteStore(boardContent: boardContent, ref: ref),
                  const SizedBox(height: 12),
                  const Text("Color",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )),
                  ColorPaletteStore(boardContent: boardContent, ref: ref),
                ],
              ),
            ),
            Positioned(
              top: 12,
              left: 12,
              child: UndoChangesButton(ref: ref),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(boardContentProvider.notifier).clearBoard();
        },
        child: const Icon(Icons.clear),
      ),
    );
  }
}
