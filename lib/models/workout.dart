import 'package:hive/hive.dart';
import 'workout_set.dart';

part 'workout.g.dart'; // To generate the adapter

@HiveType(typeId: 1) // Unique typeId for Hive
class Workout extends HiveObject {
  @HiveField(0)
  String workoutName;

  @HiveField(1)
  List<WorkoutSet> sets;

  @HiveField(2)
  final DateTime savedAt;

  Workout(
      {required this.workoutName, required this.sets, required this.savedAt});

  Map<String, dynamic> toJson() => {
        'workoutName': workoutName,
        'sets': sets.map((set) => set.toJson()).toList(),
        'savedAt': savedAt.toIso8601String(),
      };
}
