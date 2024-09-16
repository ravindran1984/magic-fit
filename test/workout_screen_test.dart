import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_fit_workout/views/workout_screen.dart';
import 'package:provider/provider.dart';
import 'package:magic_fit_workout/viewmodel/workout_provider.dart';
import 'package:magic_fit_workout/widgets/sets_list_tile.dart';

void main() {
  testWidgets('Add, Edit, and Remove Workout Sets',
      (WidgetTester tester) async {
    // Build the widget tree
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => WorkoutProvider(),
        child: MaterialApp(
          home: WorkoutScreen(
            isEditing: false,
          ),
        ),
      ),
    );

    // Verify initial state
    expect(find.text('Add Set'), findsOneWidget);
    expect(find.byType(SetsListTile), findsNothing);

    // Add a new set
    await tester.enterText(find.byType(TextFormField).first, 'Push-up');
    await tester.enterText(find.byType(TextFormField).at(1), '50');
    await tester.enterText(find.byType(TextFormField).last, '15');
    await tester.tap(find.text('Add Set'));
    await tester.pump(); // Rebuild the widget tree

    // Debug: Print widget tree for inspection
    debugDumpApp();

    // Verify that the set was added
    expect(find.byType(SetsListTile), findsOneWidget);
    expect(find.text('Push-up'), findsOneWidget);
    expect(find.text('50 kg, 15 reps'), findsOneWidget);

    // Edit the set
    await tester.tap(find.byIcon(Icons.edit));
    await tester.pump();
    await tester.enterText(find.byType(TextFormField).first, 'Pull-up');
    await tester.enterText(find.byType(TextFormField).at(1), '40');
    await tester.enterText(find.byType(TextFormField).last, '10');
    await tester.tap(find.text('Update Set'));
    await tester.pump();

    // Debug: Print widget tree for inspection
    debugDumpApp();

    // Verify that the set was updated
    expect(find.byType(SetsListTile), findsOneWidget);
    expect(find.text('Pull-up'), findsOneWidget);
    expect(find.text('40 kg, 10 reps'), findsOneWidget);

    // Delete the set
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pump();

    // Debug: Print widget tree for inspection
    debugDumpApp();

    // Verify that the set was removed
    expect(find.byType(SetsListTile), findsNothing);
  });
}
