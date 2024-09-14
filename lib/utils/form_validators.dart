import 'package:magic_fit_workout/constants/constants.dart';

class FormValidator {
  //validate weight input
  static String? validateWeight(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.weightEmpty;
    }
    final weight = double.tryParse(value);
    if (weight == null || weight <= 0) {
      return AppStrings.weightValid;
    }
    return null;
  }

  //validate repetition input
  static String? validateReps(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.weightEmpty;
    }
    final weight = int.tryParse(value);
    if (weight == null || weight <= 0) {
      return AppStrings.repsValid;
    }
    return null;
  }

  // Validate dropdown selection
  static String? validateDropdown(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.exerciseEmpty;
    }
    return null;
  }
}
