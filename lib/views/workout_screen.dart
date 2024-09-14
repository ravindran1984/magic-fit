import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:magic_fit_workout/constants/constants.dart';
import 'package:magic_fit_workout/utils/form_validators.dart';
import 'package:magic_fit_workout/widgets/add_set_button.dart';
import 'package:magic_fit_workout/widgets/exercise_dropdown.dart';
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
                  onPressed: () {
                    if (_validateForm()) {
                      final exercise = selectedExercise!;
                      final weight = double.parse(_weightController.text);
                      final reps = int.parse(_repetitionController.text);

                      // Logic to add the set to the workout
                      print('Set added: $exercise, $weight kg, $reps reps');

                      // Clear the input fields
                      _weightController.clear();
                      _repetitionController.clear();
                      setState(() {
                        selectedExercise = null; // Reset exercise selection
                      });
                    }
                  },
                )
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
            style: TextStyle(color: Colors.red),
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
}
