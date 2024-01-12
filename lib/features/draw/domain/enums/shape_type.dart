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
  circle(Icons.circle_outlined),
  oval(Icons.circle_outlined),
  rectangle(Icons.crop_square);

  final IconData icon;

  const ShapeType(this.icon);
}
