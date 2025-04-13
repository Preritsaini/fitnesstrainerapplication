import 'package:flutter/material.dart';

class EarningsCard extends StatelessWidget {
  final String amount;

  const EarningsCard({required this.amount});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.attach_money),
        title: Text("Earnings This Week"),
        subtitle: Text(amount),
      ),
    );
  }
}
