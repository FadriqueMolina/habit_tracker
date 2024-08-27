import 'package:flutter/material.dart';
import 'package:habit_tracker/components/my_alert_dialog.dart';
import 'package:habit_tracker/components/my_floating_button.dart';
import 'package:habit_tracker/components/my_habit_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController habitNameController = TextEditingController();

  final List<Map<String, bool>> listOfHabits = [];

  void onHabitCheckMarkTapped(bool? value, int index) {
    //Get the name of the habit so we can update the value (Boolean).
    String habitName = listOfHabits[index].keys.first;
    setState(() {
      listOfHabits[index][habitName] = value!;
    });
  }

  void addHabitFloatingButtonPressed() {
    showDialog(
        context: context,
        builder: (context) {
          return MyAlertDialog(
            habitNameController: habitNameController,
            onAddHabitAccepted: onAddHabitAccepted,
            onAddHabitCancelled: onAddHabitCancelled,
          );
        });
  }

  void onAddHabitAccepted() {
    setState(() {
      listOfHabits.add({habitNameController.text: false});
    });
    Navigator.pop(context);
    habitNameController.clear();
  }

  void onAddHabitCancelled() {
    Navigator.pop(context);
    habitNameController.clear();
  }

  void onModifyHabitTile(BuildContext context, int index) {
    showDialog(
        context: context,
        builder: (context) {
          return MyAlertDialog(
            habitNameController: habitNameController,
            onAddHabitAccepted: () => onModifyHabit(context, index),
            onAddHabitCancelled: onAddHabitCancelled,
          );
        });
  }

  void onModifyHabit(BuildContext context, int index) {
    String habitName = listOfHabits[index].keys.first;
    setState(() {
      listOfHabits[index] = {
        habitNameController.text: listOfHabits[index][habitName]!
      };
    });
    Navigator.pop(context);
    habitNameController.clear();
  }

  void onDeleteHabitTile(BuildContext context, int index) {
    setState(() {
      listOfHabits.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: listOfHabits.length,
        itemBuilder: (context, index) {
          var habit = listOfHabits[index];
          return MyHabitTile(
            index: index,
            title: habit.keys.first,
            completed: habit.values.first,
            onChecked: (value) => onHabitCheckMarkTapped(value, index),
            onModify: (p0, p1) => onModifyHabitTile(context, index),
            onDelete: (p0, p1) => onDeleteHabitTile(context, index),
          );
        },
      ),
      floatingActionButton: MyFloatingButton(
        onPressed: addHabitFloatingButtonPressed,
      ),
    );
  }
}
