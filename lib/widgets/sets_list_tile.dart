import 'package:flutter/material.dart';
import 'package:magic_fit_workout/models/workout_set.dart';
import 'package:magic_fit_workout/widgets/delete_button.dart';
import 'package:magic_fit_workout/widgets/edit_button.dart';

class SetsListTile extends StatelessWidget {
  final WrokoutSet set;
  final int setIndex;
  final VoidCallback onEditPressed;
  final VoidCallback onDeletePressed;

  const SetsListTile(
      {super.key,
      required this.set,
      required this.setIndex,
      required this.onEditPressed,
      required this.onDeletePressed});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Set #${setIndex + 1}'),
      subtitle:
          Text('${set.exercise} - ${set.weight} kg, ${set.repetitions} reps'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          EditButton(onPressed: onEditPressed),
          DeleteButton(onPressed: onDeletePressed)
        ],
      ),
    );
  }
}
