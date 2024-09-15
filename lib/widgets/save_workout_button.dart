import 'package:flutter/material.dart';
import 'package:magic_fit_workout/constants/constants.dart';
import 'package:magic_fit_workout/models/workout_set.dart';

class SaveWorkoutButton extends StatelessWidget {
  final List<WrokoutSet> sets;

  const SaveWorkoutButton({super.key, required this.sets});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Full-width button
      child: ElevatedButton(
        onPressed: () {
          // Logic to save the workout
          if (sets.isNotEmpty) {
            // Add offline storage
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text(AppStrings.workoutValidMessage)),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text(AppStrings.workoutInvalidMessage)),
            );
          }
        },
        child: const Text(AppStrings.saveWorkout),
      ),
    );
  }
}
