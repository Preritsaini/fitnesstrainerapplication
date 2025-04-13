import 'package:flutter/material.dart';

class UpcomingSlotCard extends StatelessWidget {
  final String time;

  const UpcomingSlotCard({required this.time});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.schedule),
        title: Text("Upcoming Slot"),
        subtitle: Text(time),
      ),
    );
  }
}
