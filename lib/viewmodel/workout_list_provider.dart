import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:magic_fit_workout/models/workout.dart';
import '../constants/constants.dart';
import '../views/workout_screen.dart';

class WorkoutListProvider extends ChangeNotifier {
  late Box<Workout> workoutBox;
  List<Workout> workoutsList = [];

  WorkoutListProvider() {
    _init();
  }

  Future<void> _init() async {
    try {
      workoutBox = Hive.box<Workout>(AppStrings.workoutBox);
      notifyListeners();
    } catch (e) {
      // Navigate back to WorkoutListScreen
      print('Error accessing Hive box: $e');
    }
  }

  List<Workout> get workouts {
    return workoutBox.values.toList();
  }

  void openWorkoutScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const WorkoutScreen(isEditing: false)),
    ).then((_) => _refreshData()); // Refresh data when coming back
  }

  Future<void> deleteWorkout(int index) async {
    await workoutBox.deleteAt(index);
    _refreshData();
  }

  void _refreshData() {
    notifyListeners(); // Notify listeners to rebuild the UI
  }

  void loadWorkouts() {
    try {
      final workoutBox = Hive.box<Workout>(AppStrings.workoutBox);
      workoutsList = workoutBox.values.toList();
      notifyListeners(); // Notify listeners to update the UI
    } catch (e) {
      // Navigate back to WorkoutListScreen
      print('Error accessing Hive box: $e');
    }
  }
}
