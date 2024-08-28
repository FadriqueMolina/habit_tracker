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
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Slidable(
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          SlidableAction(
            onPressed: (context) => onModify!(context, index),
            icon: Icons.settings,
            backgroundColor: Colors.grey,
            borderRadius: BorderRadius.circular(8),
          ),
          SlidableAction(
            onPressed: (context) => onDelete!(context, index),
            icon: Icons.delete,
            backgroundColor: Colors.red,
            borderRadius: BorderRadius.circular(8),
          ),
        ]),
        child: habitTile(),
      ),
    );
  }

  Container habitTile() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Checkbox(value: completed, onChanged: onChecked),
          Text(
            title,
            style: completed
                ? const TextStyle(
                    color: Colors.grey,
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Colors.grey,
                    decorationThickness: 2)
                : const TextStyle(color: Colors.black),
          )
        ],
      ),
    );
  }
}
