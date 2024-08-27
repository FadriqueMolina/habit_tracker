import 'package:flutter/material.dart';

class MyFloatingButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const MyFloatingButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: const Icon(Icons.add),
    );
  }
}
