import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/constants.dart';
import '../models/workout_set.dart';
import '../viewmodel/workout_provider.dart';

class SaveWorkoutButton extends StatelessWidget {
  final List<WorkoutSet> sets;
  final VoidCallback onWorkoutSaved;

  const SaveWorkoutButton({
    super.key,
    required this.sets,
    required this.onWorkoutSaved,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Full-width button
      child: ElevatedButton(
        onPressed: () async {
          if (sets.isNotEmpty) {
            final workoutProvider =
                Provider.of<WorkoutProvider>(context, listen: false);

            // Set the current sets in WorkoutProvider
            workoutProvider.updateWorkoutSets(sets);

            // Save the workout with updated sets
            await workoutProvider.saveWorkout(context);

            // Notify parent widget to clear the form after saving
            onWorkoutSaved();
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
