import 'package:flutter/material.dart';

class BookingCard extends StatelessWidget {
  final String name;
  final String time;

  const BookingCard({required this.name, required this.time});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Text(name[0])),
        title: Text(name),
        subtitle: Text(time),
      ),
    );
  }
}
