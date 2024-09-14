import 'package:flutter/material.dart';
import 'package:magic_fit_workout/views/workout_screen.dart';

class WorkoutListScreen extends StatelessWidget {
  const WorkoutListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
          color: Colors.white,
          child: const Center(child: Text('Workout List Screen')),
        )),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Add new workout functionality
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WorkoutScreen()),
            );
          },
          icon: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          label: const Text(
            "Add Workout",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.deepPurple, // Button color
        ));
  }
}
