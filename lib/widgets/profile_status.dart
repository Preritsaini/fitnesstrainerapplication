import 'package:flutter/material.dart';

class ProfileStatusCard extends StatelessWidget {
  final String status;

  const ProfileStatusCard({required this.status});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green[100],
      child: ListTile(
        leading: Icon(Icons.verified, color: Colors.green),
        title: Text("Profile Status: $status"),
      ),
    );
  }
}