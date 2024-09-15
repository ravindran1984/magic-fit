import 'package:flutter/material.dart';
import 'package:magic_fit_workout/constants/constants.dart';

class ExerciseDropDown extends StatelessWidget {
  final String? selectedExercise;
  final List<String> exerciseList;
  final ValueChanged<String?> onChanged;

  const ExerciseDropDown(
      {super.key,
      this.selectedExercise,
      required this.exerciseList,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
        decoration: const InputDecoration(
            labelText: AppStrings.exerciseLabel, border: OutlineInputBorder()),
        value: selectedExercise,
        items: exerciseList.map((String exercise) {
          return DropdownMenuItem<String>(
              value: exercise, child: Text(exercise));
        }).toList(),
        onChanged: onChanged);
  }
}
