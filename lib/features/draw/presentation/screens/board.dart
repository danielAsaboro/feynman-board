import 'package:feynman_board/features/draw/presentation/components/stroke_type_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/shapes/draw_object.dart';
import '../../domain/entities/shapes/drawing_painter.dart';
import '../components/color_palette_store.dart';
import '../components/stroke_pallet_store.dart';
import '../components/undo_button.dart';
import '../controllers/board_controller.dart';

enum StrokeType {
  pen(Icons.edit),
  line(Icons.remove),
  rectangle(Icons.crop_square);

  final IconData icon;

  const StrokeType(this.icon);
}

class BoardWidget extends ConsumerStatefulWidget {
  const BoardWidget({super.key});

  @override
  ConsumerState<BoardWidget> createState() => _BoardWidgetState();
}

class _BoardWidgetState extends ConsumerState<BoardWidget> {
  Rect? currentRectangle;
  Offset? startingPoint;
  LineObject? currentLine;
  List<Offset?> currentPenPath = [];

  List<DrawObject> savedDrawObjects = [];

  List<DrawObject> get objectsToDraw => [
        ...savedDrawObjects,
        if (currentPenPath.isNotEmpty)
          PenObject(
            currentPenPath,
            ref.read(boardContentProvider).strokeWidth,
            ref.read(boardContentProvider).brushColor,
          ),
        if (currentRectangle != null)
          RectangleObject(
            currentRectangle!,
            ref.read(boardContentProvider).strokeWidth,
            ref.read(boardContentProvider).brushColor,
          ),
        if (currentLine != null) currentLine!
      ];

  @override
  Widget build(BuildContext context) {
    final boardContent = ref.watch(boardContentProvider);
    final strokeType = boardContent.strokeType;
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onPanDown: (details) {
                  setState(() {
                    startingPoint = details.globalPosition;
                  });
                },
                onPanUpdate: (details) {
                  setState(() {
                    switch (strokeType) {
                      case StrokeType.pen:
                        currentPenPath.add(details.globalPosition);
                        break;
                      case StrokeType.rectangle:
                        currentRectangle = Rect.fromPoints(
                            startingPoint!, details.globalPosition);
                        break;
                      case StrokeType.line:
                        currentLine = LineObject(
                          startingPoint!,
                          details.globalPosition,
                          boardContent.strokeWidth,
                          boardContent.brushColor,
                        );
                        break;
                    }
                  });
                },
                onPanEnd: (details) {
                  switch (strokeType) {
                    case StrokeType.pen:
                      setState(() {
                        savedDrawObjects.add(PenObject(
                          currentPenPath,
                          boardContent.strokeWidth,
                          boardContent.brushColor,
                        ));
                        currentPenPath = [];
                      });
                      break;
                    case StrokeType.rectangle:
                      setState(() {
                        savedDrawObjects.add(RectangleObject(
                          currentRectangle!,
                          boardContent.strokeWidth,
                          boardContent.brushColor,
                        ));
                        currentRectangle = null;
                      });
                      break;
                    case StrokeType.line:
                      setState(() {
                        savedDrawObjects.add(currentLine!);
                        currentLine = null;
                      });
                      break;
                  }
                },
                child: CustomPaint(
                  painter: DrawingPainter(objectsToDraw),
                ),
              ),
            ),
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
                  StrokeTypeStore(boardContent: boardContent, ref: ref),
                  const SizedBox(height: 12),
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
              child: UndoChangesButton(
                onPressed: () {
                  setState(() {
                    if (savedDrawObjects.isNotEmpty) {
                      setState(() {
                        savedDrawObjects.removeLast();
                      });
                    }
                  });
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            savedDrawObjects.clear();
          });
        },
        child: const Icon(Icons.clear),
      ),
    );
  }
}
