import 'package:flutter/material.dart';
import 'package:habit_tracker/components/my_alert_dialog.dart';
import 'package:habit_tracker/components/my_floating_button.dart';
import 'package:habit_tracker/components/my_habit_tile.dart';
import 'package:habit_tracker/data/database.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController habitNameController = TextEditingController();

  final HabitDataBase db = HabitDataBase();
  final _box = Hive.box(HabitDataBase.dbName);

  @override
  void initState() {
    if (_box.get(HabitDataBase.habitsEntry) == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }

    super.initState();
  }

  void onHabitCheckMarkTapped(bool? value, int index) {
    //Get the name of the habit so we can update the value (Boolean).
    String habitName = db.listOfHabits[index].keys.first;
    setState(() {
      db.listOfHabits[index][habitName] = value!;
    });
    db.updateDataBase();
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
      db.listOfHabits.add({habitNameController.text: false});
    });
    Navigator.pop(context);
    habitNameController.clear();
    db.updateDataBase();
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
    String habitName = db.listOfHabits[index].keys.first;
    setState(() {
      db.listOfHabits[index] = {
        habitNameController.text: db.listOfHabits[index][habitName]!
      };
    });
    Navigator.pop(context);
    habitNameController.clear();
    db.updateDataBase();
  }

  void onDeleteHabitTile(BuildContext context, int index) {
    setState(() {
      db.listOfHabits.removeAt(index);
    });
    db.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: db.listOfHabits.isEmpty
          ? const Center(child: Text("The list is empty."))
          : ListView.builder(
              shrinkWrap: true,
              itemCount: db.listOfHabits.length,
              itemBuilder: (context, index) {
                var habit = db.listOfHabits[index];
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
