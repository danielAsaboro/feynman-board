import 'package:flutter/material.dart';

class UndoChangesButton extends StatelessWidget {
  const UndoChangesButton({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: 50,
              width: 50,
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
              ),
              child: const Icon(
                Icons.replay_circle_filled_sharp,
                size: 50,
              )),
        ],
      ),
    );
  }
}
