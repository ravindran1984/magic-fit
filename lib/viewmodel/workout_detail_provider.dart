import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:magic_fit_workout/constants/constants.dart';
import 'package:magic_fit_workout/models/workout.dart';
import 'package:magic_fit_workout/views/workout_screen.dart';

class WorkoutDetailProvider extends ChangeNotifier {
  Workout? _selectedWorkout;
  int? _workoutIndex;

  Workout? get selectedWorkout => _selectedWorkout;

  Future<void> setWorkout(int index) async {
    _workoutIndex = index;
    try {
      final workoutBox = Hive.box<Workout>(AppStrings.workoutBox);
      _selectedWorkout = workoutBox.getAt(index);
      notifyListeners();
    } catch (e) {
      print('Error accessing Hive box: $e');
    }
  }

/*
  void setWorkoutForEdit(Workout workout) {
    _selectedWorkout = workout;
    notifyListeners();
  }
*/

  Future<void> deleteWorkout(BuildContext context) async {
    if (_workoutIndex == null || _selectedWorkout == null) return;

    try {
      final workoutBox = Hive.box<Workout>(AppStrings.workoutBox);
      await workoutBox.deleteAt(_workoutIndex!);
      // After the deletion completes, navigate back
      if (context.mounted) {
        // Ensure the context is still valid
        Navigator.pop(context);
      }
    } catch (e) {
      // Navigate back to WorkoutListScreen
      print('Error accessing Hive box: $e');
    }
  }

  Future<void> editWorkout(BuildContext context) async {
    if (_workoutIndex == null || _selectedWorkout == null) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkoutScreen(
          isEditing: true,
          workout: selectedWorkout, // Pass the workout to WorkoutScreen
        ),
      ),
    );
  }
}
