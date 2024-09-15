import 'package:flutter/material.dart';
import 'package:magic_fit_workout/models/workout.dart';

import '../utils/datetime_formatter.dart';

class WorkoutListItem extends StatelessWidget {
  final Workout workout;
  final int workoutIndex;
  final VoidCallback onTap;

  const WorkoutListItem(
      {super.key,
      required this.workout,
      required this.workoutIndex,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text('${workout.workoutName} #${workoutIndex + 1} '),
        subtitle: Text(
          '${formatDateAndDay(workout.savedAt)}, ${getFormattedTimeOnly(workout.savedAt)}',
        ),
        leading: Container(
          width: 60,
          height: 60,
          color: Colors.deepPurple,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${workout.sets.length}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'SET(s)',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        onTap: onTap);
  }
}
