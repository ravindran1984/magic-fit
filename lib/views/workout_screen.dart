import 'package:flutter/material.dart';
import 'package:magic_fit_workout/constants/constants.dart';
import 'package:magic_fit_workout/widgets/common_widgets.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100.0),
          child: AppBar(
              backgroundColor: Colors.white,
              //title: Text('Add Workout'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ))),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildInputFields(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildInputFields() {
  String? selectedExercise;
  final weightController = TextEditingController();
  final repetitionController = TextEditingController();
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    ExerciseDropDown(
        selectedExercise: selectedExercise,
        exerciseList: exercises,
        onChanged: (newValue) {
          selectedExercise = newValue;
        }),
    const SizedBox(
      height: 20,
    ),
    Row(
      children: [
        Expanded(
            child: InputFieldWidget(
          controller: weightController,
          label: 'Weight (kg)',
          inputType: TextInputType.number,
        )),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: InputFieldWidget(
              controller: repetitionController,
              label: 'Repitions',
              inputType: const TextInputType.numberWithOptions(decimal: false)),
        )
      ],
    ),
  ]);
}
