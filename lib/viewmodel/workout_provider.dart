import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:magic_fit_workout/constants/constants.dart';
import 'package:magic_fit_workout/models/workout_set.dart';
import 'package:magic_fit_workout/utils/form_validators.dart';

import '../models/workout.dart';

class WorkoutProvider with ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController repetitionController = TextEditingController();

  List<WorkoutSet> _sets = [];
  String? _selectedExercise;
  int? _editingIndex;
  String? _exerciseError;
  Workout? editingWorkout; // The workout to edit

  List<WorkoutSet> get sets => _sets;
  String? get selectedExercise => _selectedExercise;
  int? get editingIndex => _editingIndex;
  String? get exerciseError => _exerciseError;
  Workout? currentWorkout;
  bool isEditing = false; // Flag to check if we're editing

  void setSelectedExercise(String? value) {
    _selectedExercise = value;
    _exerciseError = null;
    notifyListeners();
  }

  void setEditingIndex(int? index) {
    _editingIndex = index;
    if (index != null) {
      final set = _sets[index];
      _selectedExercise = set.exercise;
      weightController.text = set.weight.toString();
      repetitionController.text = set.repetitions.toString();
    }
    notifyListeners();
  }

  // Initialize provider with an existing workout if editing
  void initializeWithWorkout(Workout workout) {
    _sets = List.from(workout.sets); // Clone the workout's sets
    editingWorkout = workout;
    isEditing = true;
    notifyListeners();
  }

  void addSet(WorkoutSet set) {
    if (_editingIndex != null) {
      _sets[_editingIndex!] = set;
      _editingIndex = null;
    } else {
      _sets.add(set);
    }
    notifyListeners();
  }

  void removeSet(int index) {
    _sets.removeAt(index);
    notifyListeners();
  }

  // Method to update sets
  void updateWorkoutSets(List<WorkoutSet> newSets) {
    if (isEditing && editingWorkout != null) {
      editingWorkout!.sets = newSets;
    } else {
      _sets = newSets;
    }
    notifyListeners();
  }

  Future<void> saveWorkout(BuildContext context) async {
    final workoutBox = Hive.box<Workout>(AppStrings.workoutBox);

    if (isEditing && editingWorkout != null) {
      // Use Hive key to update the existing workout
      await workoutBox.put(editingWorkout!.key, editingWorkout!);

      // Show the updated values in SnackBar
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
        AppStrings.workoutUpdateMessage,
      )));
    } else {
      // Add a new workout
      Workout newWorkout = Workout(
        workoutName: AppStrings.workoutName, // Add your workout name logic here
        savedAt: DateTime.now(),
        sets: sets,
      );

      // Save the new workout to Hive
      await workoutBox.add(newWorkout);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.workoutValidMessage)),
      );
    }

    notifyListeners();
    // Clear form after saving and navigate back
    clearForm();
    Navigator.pop(context);
  }

  void clearForm() {
    _selectedExercise = null; // Clear the selected exercise
    _exerciseError = null; // Clear any existing errors
    _editingIndex = null; // Reset editing index
    weightController.clear(); // Clear weight input
    repetitionController.clear(); // Clear repetitions input
    notifyListeners(); // Notify listeners about the changes
  }

  bool validateForm() {
    final isFormValid = formKey.currentState?.validate() ?? false;
    final dropdownError = FormValidator.validateDropdown(_selectedExercise);

    if (dropdownError != null) {
      _exerciseError = dropdownError;
      notifyListeners();
      return false;
    }
    _exerciseError = null;
    notifyListeners();
    return isFormValid;
  }
}
