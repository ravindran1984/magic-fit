import 'package:flutter/material.dart';
import 'package:magic_fit_workout/models/workout_set.dart';
import 'package:magic_fit_workout/utils/form_validators.dart';

class WorkoutProvider with ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController repetitionController = TextEditingController();

  List<WorkoutSet> _sets = [];
  String? _selectedExercise;
  int? _editingIndex;
  String? _exerciseError;

  List<WorkoutSet> get sets => _sets;
  String? get selectedExercise => _selectedExercise;
  int? get editingIndex => _editingIndex;
  String? get exerciseError => _exerciseError;

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
