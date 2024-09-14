import 'package:flutter/material.dart';
import 'package:magic_fit_workout/constants/constants.dart';

class AddSetButton extends StatelessWidget {
  final VoidCallback onPressed; // Function to handle button press
  const AddSetButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text(AppStrings.addSet),
    );
  }
}
