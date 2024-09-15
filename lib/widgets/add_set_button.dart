import 'package:flutter/material.dart';

class AddSetButton extends StatelessWidget {
  final VoidCallback onPressed;

  final String? btnTitle; // Function to handle button press

  const AddSetButton({super.key, required this.onPressed, this.btnTitle});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Text(btnTitle!));
  }
}
