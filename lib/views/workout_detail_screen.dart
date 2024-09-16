import 'package:flutter/material.dart';
import 'package:magic_fit_workout/constants/constants.dart';
import 'package:magic_fit_workout/viewmodel/workout_detail_provider.dart';
import 'package:provider/provider.dart';

import '../utils/datetime_formatter.dart';

class WorkoutDetailScreen extends StatelessWidget {
  const WorkoutDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutDetailProvider>(
      builder: (context, viewModel, child) {
        final workout = viewModel.selectedWorkout;
        if (workout == null) {
          return Scaffold(
              appBar: AppBar(title: const Text(AppStrings.workoutDetail)),
              body: const Placeholder());
        }

        return Scaffold(
          appBar: AppBar(title: const Text(AppStrings.workoutDetail)),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  workout.workoutName,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  '${formatDateAndDay(workout.savedAt)}, ${getFormattedTimeOnly(workout.savedAt)}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: workout.sets.length,
                    itemBuilder: (context, index) {
                      final set = workout.sets[index];
                      return ListTile(
                          title: Text('SET #${index + 1}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(set.exercise),
                              Text('${set.weight} kg, ${set.repetitions} reps')
                            ],
                          ));
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        viewModel
                            .editWorkout(context); // Navigate to edit screen
                      },
                      child: const Text(AppStrings.textEdit),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: () {
                        viewModel.deleteWorkout(
                            Navigator.of(context, rootNavigator: true)
                                .context); // Delete and navigate back
                      },
                      child: const Text(AppStrings.textDelete),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
