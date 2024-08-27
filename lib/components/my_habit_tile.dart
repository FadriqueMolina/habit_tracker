import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyHabitTile extends StatelessWidget {
  final int index;
  final String title;
  final bool completed;
  final Function(bool?)? onChecked;
  final Function(BuildContext, int)? onModify;
  final Function(BuildContext, int)? onDelete;

  const MyHabitTile(
      {super.key,
      required this.index,
      required this.title,
      required this.completed,
      required this.onChecked,
      required this.onModify,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(motion: const ScrollMotion(), children: [
        SlidableAction(
          onPressed: (context) => onModify!(context, index),
          icon: Icons.settings,
          backgroundColor: Colors.grey,
        ),
        SlidableAction(
          onPressed: (context) => onDelete!(context, index),
          icon: Icons.delete,
          backgroundColor: Colors.red,
        ),
      ]),
      child: habitTile(),
    );
  }

  Container habitTile() {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Checkbox(value: completed, onChanged: onChecked),
          Text(title)
        ],
      ),
    );
  }
}
