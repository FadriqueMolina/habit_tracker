import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  final TextEditingController habitNameController;
  final Function()? onAddHabitAccepted;
  final Function()? onAddHabitCancelled;
  const MyAlertDialog(
      {super.key,
      required this.habitNameController,
      required this.onAddHabitAccepted,
      required this.onAddHabitCancelled});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      content: myTextField(),
      actions: [
        myAlertButton(onAddHabitAccepted, "Add"),
        myAlertButton(onAddHabitCancelled, "Cancel"),
      ],
    );
  }

  MaterialButton myAlertButton(Function()? onpressed, String title) {
    return MaterialButton(
        color: Colors.white, onPressed: onpressed, child: Text(title));
  }

  TextField myTextField() {
    return TextField(
        controller: habitNameController,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
            hintText: "Enter habit name",
            hintStyle: TextStyle(color: Colors.white),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            )));
  }
}
