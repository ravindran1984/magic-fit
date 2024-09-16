import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:magic_fit_workout/models/workout.dart';
import 'package:magic_fit_workout/models/workout_set.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'dart:io';

class MockPathProviderPlatform extends PathProviderPlatform {
  @override
  Future<String> getTemporaryPath() async {
    // Return a temporary directory path for testing
    final directory = Directory.systemTemp.createTempSync();
    return directory.path;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    final directory = await getTemporaryDirectory();
    Hive.init(directory.path);

    Hive.registerAdapter(WorkoutAdapter());
    Hive.registerAdapter(WorkoutSetAdapter());

    // Close all open boxes before opening the one needed for the test
    await Hive.deleteFromDisk();
    await Hive.openBox<Workout>('workoutsBox');
  });

  tearDown(() async {
    // Close all open boxes after each test
    await Hive.close();
  });

  test('Add a new workout', () async {
    final workoutBox = Hive.box<Workout>('workoutsBox');

    Workout workout = Workout(
      workoutName: 'Test Workout',
      savedAt: DateTime.now(),
      sets: [WorkoutSet(exercise: 'Push Ups', weight: 0, repetitions: 20)],
    );

    await workoutBox.add(workout);

    expect(workoutBox.length, 1); // Check if the workout was added
  });
}
