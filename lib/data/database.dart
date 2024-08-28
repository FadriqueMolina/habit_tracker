import 'package:hive_flutter/hive_flutter.dart';

class HabitDataBase {
  static const String dbName = "habitBox";
  static const String habitsEntry = "ListOfHabits";
  List listOfHabits = [];
  final _box = Hive.box(dbName);

  HabitDataBase();

  void createInitialData() {
    listOfHabits = [
      {
        "Do homework": false,
      },
      {"Clean room": false}
    ];
  }

  void loadData() {
    listOfHabits = _box.get(habitsEntry);
  }

  void updateDataBase() {
    _box.put(habitsEntry, listOfHabits);
  }
}
