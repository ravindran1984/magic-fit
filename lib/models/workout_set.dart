// Define a simple Set model class
import 'package:hive/hive.dart';

part 'workout_set.g.dart';

@HiveType(typeId: 0)
class WorkoutSet extends HiveObject {
// This line tells the generator to create this file.

  @HiveField(0)
  String exercise;
  @HiveField(1)
  double weight;
  @HiveField(2)
  int repetitions;

  WorkoutSet({
    required this.exercise,
    required this.weight,
    required this.repetitions,
  });

  Map<String, dynamic> toJson() => {
        'exercise': exercise,
        'weight': weight,
        'repetitions': repetitions,
      };
}
