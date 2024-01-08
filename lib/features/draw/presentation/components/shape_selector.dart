import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/enums/shape_type.dart';
import '../controllers/board_controller.dart';

class ShapePalletteStore extends StatelessWidget {
  const ShapePalletteStore({
    super.key,
    required this.ref,
  });

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20,
      top: 100,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              ref
                  .read(boardContentProvider.notifier)
                  .changeShape(ShapeType.line);
            },
            child: Container(
              height: 30,
              width: 30,
              color: Colors.green,
              child: SizedBox(height: 50, child: Text('Line')),
            ),
          ),
          Container(
            height: 30,
            width: 30,
          ),
          GestureDetector(
            onTap: () {
              ref
                  .read(boardContentProvider.notifier)
                  .changeShape(ShapeType.scribble);
            },
            child: Container(
              height: 30,
              width: 30,
              color: Colors.green,
              child: Text("Scribble"),
            ),
          ),
        ],
      ),
    );
  }
}
