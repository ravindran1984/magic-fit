import 'package:flutter/material.dart';

class EditButton extends StatelessWidget {
  final VoidCallback onPressed;

  const EditButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.edit, color: Colors.deepPurple),
        onPressed: onPressed
        // Remove set from list
        );
  }
}
