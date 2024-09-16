import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/constants.dart';
import '../viewmodel/workout_provider.dart';

class ExerciseDropDown extends StatelessWidget {
  final List<String> exerciseList;
  final ValueChanged<String?> onChanged;

  const ExerciseDropDown({
    super.key,
    required this.exerciseList,
    required this.onChanged, String? selectedExercise,
  });

  @override
  Widget build(BuildContext context) {
    final workoutProvider = Provider.of<WorkoutProvider>(context);

    return DropdownButtonFormField<String>(
      value: workoutProvider.selectedExercise,
      onChanged: (newValue) => workoutProvider.setSelectedExercise(newValue),
      items: exerciseList.map((exercise) {
        return DropdownMenuItem<String>(
          value: exercise,
          child: Text(exercise),
        );
      }).toList(),
      decoration: const InputDecoration(
          labelText: AppStrings.exerciseLabel, border: OutlineInputBorder()),
    );
  }
}
