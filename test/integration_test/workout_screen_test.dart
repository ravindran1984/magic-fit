import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:magic_fit_workout/views/workout_screen.dart';
import 'package:provider/provider.dart';
import 'package:magic_fit_workout/viewmodel/workout_provider.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Add, Edit and Delete Workout', (WidgetTester tester) async {
    // Set up mock data and initial conditions
    final workoutProvider = WorkoutProvider();

    // Build the widget tree
    await tester.pumpWidget(
      ChangeNotifierProvider.value(
        value: workoutProvider,
        child: MaterialApp(
          home: WorkoutScreen(isEditing: false),
        ),
      ),
    );

    // Verify initial state
    expect(find.text('Add Set'), findsOneWidget);
    expect(find.byType(ElevatedButton),
        findsOneWidget); // Assumes a button for saving the workout

    // Simulate adding a new workout
    await tester.tap(find.text('Add Set'));
    await tester.pump(); // Rebuild the widget tree

    // Verify the set was added
    expect(workoutProvider.sets.isNotEmpty, true);

    // Simulate filling out the form and saving the workout
    // For simplicity, assume that there's a TextFormField with a key 'workoutName'
    await tester.enterText(find.byType(TextFormField).at(0), 'Test Workout');
    await tester.tap(find.text('Save Workout'));
    await tester.pumpAndSettle(); // Wait for animations to complete

    // Verify the workout was saved
    expect(find.text('Test Workout'), findsOneWidget);

    // Simulate editing a workout
    await tester.tap(
        find.byType(IconButton)); // Assuming there's an icon button for editing
    await tester.pump();

    await tester.enterText(find.byType(TextFormField).at(0), 'Updated Workout');
    await tester.tap(find.text('Save Workout'));
    await tester.pumpAndSettle();

    // Verify the workout was updated
    expect(find.text('Updated Workout'), findsOneWidget);

    // Simulate deleting a workout
    await tester
        .tap(find.byIcon(Icons.delete)); // Assuming delete is an icon button
    await tester.pumpAndSettle();

    // Verify the workout was deleted
    expect(find.text('Updated Workout'), findsNothing);
  });
}
