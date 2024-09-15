import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:magic_fit_workout/constants/constants.dart';
import 'package:magic_fit_workout/models/workout.dart';
import 'package:magic_fit_workout/models/workout_set.dart';

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
          // Logic to save the workout
          if (sets.isNotEmpty) {
            // Add offline storage
            await _saveWorkout('Workout', sets);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text(AppStrings.workoutValidMessage)),
            );

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

Future<void> _saveWorkout(String workoutName, List<WorkoutSet> sets) async {
  final workoutBox = Hive.box<Workout>('workoutsBox');
  final workout =
      Workout(workoutName: workoutName, sets: sets, savedAt: DateTime.now());
  await workoutBox.add(workout);
}
