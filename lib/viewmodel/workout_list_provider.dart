import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:magic_fit_workout/models/workout.dart';

import '../views/workout_detail_screen.dart';
import '../views/workout_screen.dart';

class WorkoutListProvider extends ChangeNotifier {
  late Box<Workout> workoutBox;

  WorkoutListProvider() {
    _init();
  }

  Future<void> _init() async {
    workoutBox = Hive.box<Workout>('workoutsBox');
    notifyListeners();
  }

  List<Workout> get workouts {
    return workoutBox.values.toList();
  }

  void openWorkoutScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const WorkoutScreen()),
    ).then((_) => _refreshData()); // Refresh data when coming back
  }

  void openWorkoutDetailScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const WorkoutDetailScreen()),
    ).then((_) => _refreshData()); // Refresh data when coming back
  }

  Future<void> deleteWorkout(int index) async {
    await workoutBox.deleteAt(index);
    _refreshData();
  }

  void _refreshData() {
    notifyListeners(); // Notify listeners to rebuild the UI
  }
}
