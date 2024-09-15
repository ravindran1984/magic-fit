import 'package:flutter/material.dart';
import 'package:magic_fit_workout/constants/constants.dart';
import 'package:magic_fit_workout/models/workout_set.dart';
import 'package:magic_fit_workout/utils/form_validators.dart';
import 'package:magic_fit_workout/widgets/add_set_button.dart';
import 'package:magic_fit_workout/widgets/delete_button.dart';
import 'package:magic_fit_workout/widgets/edit_button.dart';
import 'package:magic_fit_workout/widgets/exercise_dropdown.dart';
import 'package:magic_fit_workout/widgets/save_workout_button.dart';
import 'package:magic_fit_workout/widgets/sets_list_tile.dart';
import 'package:magic_fit_workout/widgets/text_input_widget.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  final _formKey = GlobalKey<FormState>();

  String? selectedExercise;

  final _weightController = TextEditingController();

  final _repetitionController = TextEditingController();
  String? _exerciseError; // Track exercise validation error
  final List<WrokoutSet> _sets = []; // List to store valid sets
  int? _editingIndex; // Track index of the set being edited

  @override
  Widget build(BuildContext context) {
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
            key: _formKey,
            child: Column(
              children: [
                _buildInputFields(),
                const SizedBox(
                  height: 20,
                ),
                AddSetButton(
                  btnTitle: _editingIndex != null
                      ? AppStrings.updateSet
                      : AppStrings.addSet,
                  onPressed: () {
                    if (_validateForm()) {
                      final exercise = selectedExercise!;
                      final weight = double.parse(_weightController.text);
                      final reps = int.parse(_repetitionController.text);

                      final newSet = WrokoutSet(
                        exercise: exercise,
                        weight: weight,
                        repetitions: reps,
                      );

                      setState(() {
                        if (_editingIndex != null) {
                          // Update existing set
                          _sets[_editingIndex!] = newSet;
                          _editingIndex = null; // Clear editing index
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'Set modified with : $exercise, $weight, $reps')),
                          );
                        } else {
                          // Add new set
                          _sets.add(newSet);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'Set added : $exercise, $weight, $reps')),
                          );
                        }
                        selectedExercise = null;
                        // Clear the input fields
                        _weightController.clear();
                        _repetitionController
                            .clear(); // Reset exercise selection
                      });
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                _addedSets(),
                SaveWorkoutButton(sets: _sets)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputFields() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ExerciseDropDown(
          selectedExercise: selectedExercise,
          exerciseList: exercises,
          onChanged: (newValue) {
            setState(() {
              selectedExercise = newValue;
              _exerciseError =
                  null; // Clear error when a valid selection is made
            });
          }),
      if (_exerciseError != null)
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            _exerciseError!,
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
                  controller: _weightController,
                  label: AppStrings.weightLabel,
                  inputType: TextInputType.number,
                  validator: FormValidator.validateWeight)),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: InputFieldWidget(
              controller: _repetitionController,
              label: AppStrings.repetitionsLabel,
              inputType: const TextInputType.numberWithOptions(decimal: false),
              validator: FormValidator.validateReps,
            ),
          )
        ],
      ),
    ]);
  }

  // Validate form fields including dropdown
  bool _validateForm() {
    final isFormValid = _formKey.currentState?.validate() ?? false;
    final dropdownError = FormValidator.validateDropdown(selectedExercise);

    if (dropdownError != null) {
      setState(() {
        _exerciseError = dropdownError;
      });
      return false;
    }
    setState(() {
      _exerciseError = null; // Clear the error if validation passes
    });
    return isFormValid;
  }

  Widget _addedSets() {
    return Expanded(
      child: ListView.builder(
        itemCount: _sets.length,
        itemBuilder: (context, index) {
          final set = _sets[index];
          return SetsListTile(
            set: set,
            onEditPressed: () => _editSet(index),
            onDeletePressed: () => _removeSet(index),
            setIndex: index,
          );
        },
      ),
    );
  }

  // Edit a set
  void _editSet(int index) {
    final set = _sets[index];
    setState(() {
      selectedExercise = set.exercise;
      _weightController.text = set.weight.toString();
      _repetitionController.text = set.repetitions.toString();
      _editingIndex = index; // Set index for editing
    });
  }

  // Remove a set from the list
  void _removeSet(int index) {
    setState(() {
      _sets.removeAt(index); // Remove set from the list
    });
  }
}
