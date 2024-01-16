// enum ScribbleType {
//   oval,
//   line,
//   diamond,
//   doodle,
//   rectangle,
// }

import 'package:flutter/material.dart';

enum ShapeType {
  pen(Icons.edit),
  line(Icons.remove),
  oval(Icons.circle_outlined),
  rectangle(Icons.crop_square);

  final IconData icon;

  const ShapeType(this.icon);
}
