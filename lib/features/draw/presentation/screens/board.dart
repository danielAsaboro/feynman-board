import 'package:feynman_board/features/draw/presentation/components/stroke_type_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/shapes/drawing_painter.dart';
import '../../domain/enums/shape_type.dart';
import '../components/color_palette_store.dart';
import '../components/stroke_pallet_store.dart';
import '../components/undo_button.dart';
import '../controllers/board_config.dart';
import '../controllers/board_content.dart';

class BoardWidget extends ConsumerStatefulWidget {
  const BoardWidget({super.key});

  @override
  ConsumerState<BoardWidget> createState() => _BoardWidgetState();
}

class _BoardWidgetState extends ConsumerState<BoardWidget> {
  @override
  Widget build(BuildContext context) {
    final boardConfig = ref.watch(boardConfigProvider);
    final boardContent = ref.watch(boardContentProvider);
    final strokeType = boardConfig.shapeType;
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onPanDown: (details) {
                  final startingPoint = details.globalPosition;
                  ref
                      .read(boardContentProvider.notifier)
                      .addStartingPoint(startingPoint);
                },
                onPanUpdate: (details) {
                  final currentPoint = details.globalPosition;
                  switch (strokeType) {
                    case ShapeType.pen:
                      ref
                          .read(boardContentProvider.notifier)
                          .addScribbleToCurrentPenPath(currentPoint);
                      break;
                    case ShapeType.rectangle:
                      ref
                          .read(boardContentProvider.notifier)
                          .addScribbleToCurrentRectangle(currentPoint);
                      break;
                    case ShapeType.oval:
                      ref
                          .read(boardContentProvider.notifier)
                          .addScribbleToCurrentOval(
                            currentPoint,
                          );
                      break;
                    case ShapeType.line:
                      ref
                          .read(boardContentProvider.notifier)
                          .addScribbleToCurrentLine(currentPoint);
                      break;
                  }
                },
                onPanEnd: (details) {
                  ref
                      .read(boardContentProvider.notifier)
                      .addShapeToAllScribbles();
                },
                child: CustomPaint(
                  painter: DrawingPainter(boardContent.objectsToDraw),
                ),
              ),
            ),
            // ShapePalletteStore(ref: ref),
            Positioned(
              bottom: 12,
              left: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Type",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )),
                  StrokeTypeStore(boardConfig: boardConfig, ref: ref),
                  const SizedBox(height: 12),
                  const Text("Stroke Width",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )),
                  StrokePalletteStore(boardConfig: boardConfig, ref: ref),
                  const SizedBox(height: 12),
                  const Text("Color",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )),
                  ColorPaletteStore(boardContent: boardConfig, ref: ref),
                ],
              ),
            ),
            Positioned(
              top: 12,
              left: 12,
              child: UndoChangesButton(
                onPressed: () {
                  ref.read(boardContentProvider.notifier).undoMove();
                },
              ),
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
