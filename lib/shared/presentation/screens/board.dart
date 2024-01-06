import 'package:flutter/material.dart';

import '../../domain/entities/shapes/draw_object.dart';
import '../../domain/entities/shapes/drawing_painter.dart';

class BoardWidget extends StatefulWidget {
  const BoardWidget({super.key});

  @override
  State<BoardWidget> createState() => _BoardWidgetState();
}

class _BoardWidgetState extends State<BoardWidget> {
  List<DrawObject?> objects = [];

  double strokeWidth = 5;

  Color color = Colors.black;

  @override
  Widget build(BuildContext context) {
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

                  setState(() {
                    objects.add(DrawObject(offset, strokeWidth, color));
                  });
                },
                onPanEnd: (details) {
                  // adding a null value here to separate individual strokes
                  setState(() {
                    objects.add(null);
                  });
                },
                child: CustomPaint(
                  painter: DrawingPainter(objects),
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
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...[1, 2, 3, 4, 5].map((e) {
                        final isSelected = strokeWidth == e;
                        return InkWell(
                          onTap: () {
                            setState(() {
                              strokeWidth = e.toDouble();
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.all(5),
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              border: isSelected
                                  ? Border.all(color: Colors.black)
                                  : null,
                              color: Colors.grey.shade300,
                            ),
                            child: Center(
                              child: Container(
                                width: e.toDouble(),
                                height: e.toDouble(),
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
                  ),
                  const SizedBox(height: 12),
                  const Text("Color",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      )),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...[
                        Colors.red,
                        Colors.green,
                        Colors.blue,
                        Colors.amber,
                        Colors.black,
                        Colors.white,
                      ].map((e) {
                        final isSelected = color == e;
                        return InkWell(
                          onTap: () {
                            setState(() {
                              color = e;
                            });
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
                                color: e,
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            objects.clear();
          });
        },
        child: const Icon(Icons.clear),
      ),
    );
  }
}
