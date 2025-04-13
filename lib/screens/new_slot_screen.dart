import 'package:flutter/material.dart';

class NewSlotScreen extends StatelessWidget {
  const NewSlotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Slot"),
      ),
      body: Center(
        child: Text("This is a dummy Add Slot screen", style: Theme.of(context).textTheme.titleLarge),
      ),
    );
  }
}
