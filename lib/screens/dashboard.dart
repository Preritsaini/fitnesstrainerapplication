import 'package:flutter/material.dart';
import '../utils/theme_provider.dart';
import '../widgets/earning.dart';
import '../widgets/profile_status.dart';
import '../widgets/upcoming.dart';
import 'new_slot_screen.dart';
import '../widgets/greeting_header.dart';
import '../widgets/booking_card.dart';

class DashboardScreen extends StatelessWidget {
  final ThemeProvider themeProvider;
  DashboardScreen({required this.themeProvider});

  final List<Map<String, String>> bookings = [
    {'name': 'Rohan', 'time': '10:00 AM'},
    {'name': 'Priya', 'time': '11:30 AM'},
    {'name': 'Karan', 'time': '2:00 PM'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trainer Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(themeProvider.isDarkMode.value
                ? Icons.light_mode
                : Icons.dark_mode),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            GreetingHeader(name: 'Ayush'),
            SizedBox(height: 16),
            EarningsCard(amount: '₹4,200'),
            SizedBox(height: 16),
            Text("Today's Bookings", style: Theme.of(context).textTheme.titleMedium),
            SizedBox(height: 8),
            ...bookings.map((b) => BookingCard(name: b['name']!, time: b['time']!)),
            SizedBox(height: 16),
            UpcomingSlotCard(time: '2:00 PM with Karan'),
            SizedBox(height: 16),
            ProfileStatusCard(status: 'Verified'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => NewSlotScreen()));
              },
              child: Text("Add New Slot"),
            ),
          ],
        ),
      ),
    );
  }
}
