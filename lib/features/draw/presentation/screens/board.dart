import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/shapes/draw_object.dart';
import '../../domain/entities/shapes/drawing_painter.dart';
import '../../domain/enums/shape_type.dart';
import '../components/color_palette_store.dart';
import '../components/shape_selector.dart';
import '../components/stroke_pallet_store.dart';
import '../components/undo_button.dart';
import '../controllers/board_config_controller.dart';
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
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onPanDown: (details) {
                  if (boardConfig.shape == ScribbleType.rectangle) {
                    ref
                        .read(boardContentProvider.notifier)
                        .addRectangleStartPoint(details.globalPosition);
                  }
                },
                onPanUpdate: (details) {
                  RenderBox renderBox = context.findRenderObject() as RenderBox;
                  final offset =
                      renderBox.globalToLocal(details.globalPosition);
                  switch (boardConfig.shape) {
                    case ScribbleType.doodle:
                      ref
                          .read(boardContentProvider.notifier)
                          .addToCurrentScribbles(offset);
                      break;
                    case ScribbleType.rectangle:
                      ref
                          .read(boardContentProvider.notifier)
                          .addRectangleToCurrentScribbles(offset);
                      break;
                    default:
                  }

                  //   if (strokeType == StrokeType.pen) {
                  //   currentLinePath.add(details.globalPosition);
                  // } else if (strokeType == StrokeType.rectangle) {
                  //   currentRectangle =
                  //       Rect.fromPoints(startingPoint!, details.globalPosition);
                  // }
                },
                onPanEnd: (details) {
                  switch (boardConfig.shape) {
                    case ScribbleType.doodle:
                      ref
                          .read(boardContentProvider.notifier)
                          .addCurrentDoddleToAllScribbles();
                      break;
                    case ScribbleType.rectangle:
                      ref
                          .read(boardContentProvider.notifier)
                          .addRectangleToAllScribbles();
                      break;
                    default:
                  }
                },
                child: CustomPaint(
                  painter: DrawingPainter(boardContent.allScribbles),
                ),
              ),
            ),
            ShapePalletteStore(ref: ref),
            Positioned(
              bottom: 12,
              left: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Shape ",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )),
                  const Text("Stroke Width",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )),
                  StrokePalletteStore(boardContent: boardConfig, ref: ref),
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
