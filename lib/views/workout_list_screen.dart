import 'package:flutter/material.dart';
import 'package:magic_fit_workout/constants/constants.dart';
import 'package:magic_fit_workout/viewmodel/workout_list_provider.dart';
import 'package:magic_fit_workout/widgets/workout_list_item.dart';
import 'package:provider/provider.dart';
import '../utils/datetime_formatter.dart';

class WorkoutListScreen extends StatelessWidget {
  const WorkoutListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WorkoutListProvider(),
      child: Consumer<WorkoutListProvider>(
        builder: (context, viewModel, child) {
          return Scaffold(
            appBar: PreferredSize(
              preferredSize:
                  const Size.fromHeight(100.0), // Custom height for the AppBar
              child: AppBar(
                backgroundColor: Colors.white, // Make AppBar background white
                elevation: 0, // Remove shadow
                flexibleSpace: Padding(
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 40.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Greeting Section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Hi, User',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black, // Black text for contrast
                            ),
                          ),
                          const SizedBox(height: 4), // Spacing between texts
                          Text(
                            getFormattedDateToday(),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey, // Lighter color for subtitle
                            ),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: const Padding(
                            padding: EdgeInsets.all(5),
                            child: CircleAvatar(
                              radius: 20.0,
                              backgroundImage:
                                  AssetImage('assets/images/user.png'),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: SafeArea(
              child: viewModel.workouts.isEmpty
                  ? const Center(child: Text(AppStrings.noWorkoutSaved))
                  : ListView.builder(
                      itemCount: viewModel.workouts.length,
                      itemBuilder: (context, index) {
                        final workout = viewModel.workouts[index];
                        return Dismissible(
                          key: Key(workout.key
                              .toString()), // Unique key for each item
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) {
                            // Remove the item from the list and update the provider
                            viewModel.deleteWorkout(index);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(AppStrings.workoutDeleted),
                              ),
                            );
                          },
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          child: WorkoutListItem(
                            workout: workout,
                            workoutIndex: index,
                            onTap: () {
                              viewModel.openWorkoutDetailScreen(context);
                            },
                          ),
                        );
                      },
                    ),
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                viewModel.openWorkoutScreen(context);
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              label: const Text(
                AppStrings.addWorkout,
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}
