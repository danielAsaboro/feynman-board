// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../domain/enums/shape_type.dart';
// import '../controllers/board_config.dart';

// class ShapePalletteStore extends StatelessWidget {
//   const ShapePalletteStore({
//     super.key,
//     required this.ref,
//   });

//   final WidgetRef ref;

//   @override
//   Widget build(BuildContext context) {
//     return Positioned(
//       left: 20,
//       top: 100,
//       child: Column(
//         children: [
//           GestureDetector(
//             onTap: () {
//               ref
//                   .read(boardConfigProvider.notifier)
//                   .changeShape(ScribbleType.rectangle);
//             },
//             child: Container(
//               height: 30,
//               width: 30,
//               color: Colors.green,
//               child: const SizedBox(height: 50, child: Text('Rectangle')),
//             ),
//           ),
//           const SizedBox(
//             height: 30,
//             width: 30,
//           ),
//           GestureDetector(
//             onTap: () {
//               // ref
//               //     .read(boardConfigProvider.notifier)
//               //     .changeShape(ScribbleType.doodle);
//             },
//             child: Container(
//               height: 30,
//               width: 30,
//               color: Colors.green,
//               child: const Text("Scribble"),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
