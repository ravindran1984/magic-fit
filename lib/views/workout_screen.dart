import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:magic_fit_workout/constants/constants.dart';
import 'package:magic_fit_workout/widgets/add_set_button.dart';
import 'package:magic_fit_workout/widgets/exercise_dropdown.dart';
import 'package:magic_fit_workout/widgets/save_workout_button.dart';
import 'package:magic_fit_workout/widgets/sets_list_tile.dart';
import 'package:magic_fit_workout/widgets/text_input_widget.dart';

import '../models/workout_set.dart';
import '../utils/form_validators.dart';
import '../viewmodel/workout_provider.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WorkoutProvider(),
      child: Consumer<WorkoutProvider>(
        builder: (context, workoutProvider, child) {
          return Scaffold(
            appBar: PreferredSize(
                preferredSize: const Size.fromHeight(100.0),
                child: AppBar(
                    backgroundColor: Colors.white,
                    title: const Text(AppStrings.workoutTitle),
                    leading: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ))),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: workoutProvider.formKey,
                  child: Column(
                    children: [
                      _buildInputFields(workoutProvider),
                      const SizedBox(
                        height: 20,
                      ),
                      AddSetButton(
                        btnTitle: workoutProvider.editingIndex != null
                            ? AppStrings.updateSet
                            : AppStrings.addSet,
                        onPressed: () {
                          if (workoutProvider.validateForm()) {
                            final exercise = workoutProvider.selectedExercise!;
                            final weight = double.parse(
                                workoutProvider.weightController.text);
                            final reps = int.parse(
                                workoutProvider.repetitionController.text);

                            final newSet = WorkoutSet(
                              exercise: exercise,
                              weight: weight,
                              repetitions: reps,
                            );

                            workoutProvider.addSet(newSet);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Set ${workoutProvider.editingIndex != null ? 'modified' : 'added'}: $exercise, $weight, $reps')),
                            );

                            workoutProvider.clearForm();
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: workoutProvider.sets.length,
                          itemBuilder: (context, index) {
                            final set = workoutProvider.sets[index];
                            return SetsListTile(
                              set: set,
                              onEditPressed: () {
                                workoutProvider.setEditingIndex(index);
                              },
                              onDeletePressed: () =>
                                  workoutProvider.removeSet(index),
                              setIndex: index,
                            );
                          },
                        ),
                      ),
                      SaveWorkoutButton(
                        sets: workoutProvider.sets,
                        onWorkoutSaved: workoutProvider.clearForm,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInputFields(WorkoutProvider workoutProvider) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ExerciseDropDown(
          exerciseList: exercises,
          onChanged: (newValue) {
            workoutProvider.setSelectedExercise(newValue);
          }),
      if (workoutProvider.exerciseError != null)
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            workoutProvider.exerciseError!,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      const SizedBox(
        height: 20,
      ),
      Row(
        children: [
          Expanded(
              child: InputFieldWidget(
                  controller: workoutProvider.weightController,
                  label: AppStrings.weightLabel,
                  inputType: TextInputType.number,
                  validator: FormValidator.validateWeight)),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: InputFieldWidget(
              controller: workoutProvider.repetitionController,
              label: AppStrings.repetitionsLabel,
              inputType: const TextInputType.numberWithOptions(decimal: false),
              validator: FormValidator.validateReps,
            ),
          )
        ],
      ),
    ]);
  }
}
