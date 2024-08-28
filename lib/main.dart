import 'package:flutter/material.dart';
import 'package:habit_tracker/data/database.dart';
import 'package:habit_tracker/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox(HabitDataBase.dbName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      title: 'Habit Tracker',
      theme: ThemeData(primarySwatch: Colors.lightBlue),
    );
  }
}
