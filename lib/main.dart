import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  void toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trainer Dashboard',
      theme: _isDarkMode ? ThemeData.dark().copyWith(
        primaryColor: Colors.tealAccent,
        colorScheme: const ColorScheme.dark(
          primary: Colors.tealAccent,
          secondary: Colors.tealAccent,
        ),
        cardTheme: CardTheme(
          color: Colors.grey[850],
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ) : ThemeData.light().copyWith(
        primaryColor: Colors.teal,
        colorScheme: const ColorScheme.light(
          primary: Colors.teal,
          secondary: Colors.teal,
        ),
        cardTheme: CardTheme(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
      home: TrainerDashboard(toggleTheme: toggleTheme, isDarkMode: _isDarkMode),
    );
  }
}

class TrainerDashboard extends StatefulWidget {
  final Function toggleTheme;
  final bool isDarkMode;

  const TrainerDashboard({
    Key? key,
    required this.toggleTheme,
    required this.isDarkMode,
  }) : super(key: key);

  @override
  State<TrainerDashboard> createState() => _TrainerDashboardState();
}

class _TrainerDashboardState extends State<TrainerDashboard> {
  final List<Map<String, dynamic>> _bookings = [
    {
      'name': 'Sarah Johnson',
      'time': '08:00 AM',
      'duration': '60 min',
      'type': 'Strength Training'
    },
    {
      'name': 'Mike Reynolds',
      'time': '10:30 AM',
      'duration': '45 min',
      'type': 'HIIT Workout'
    },
    {
      'name': 'Emma Thompson',
      'time': '02:15 PM',
      'duration': '60 min',
      'type': 'Yoga Session'
    },
    {
      'name': 'James Wilson',
      'time': '04:30 PM',
      'duration': '45 min',
      'type': 'Personal Training'
    },
  ];

  final Map<String, dynamic> _nextBooking = {
    'name': 'Sarah Johnson',
    'time': '08:00 AM',
    'duration': '60 min',
    'type': 'Strength Training'
  };

  final double _weeklyEarnings = 1250.00;
  final String _trainerStatus = 'Verified';
  DateTime _selectedDate = DateTime.now();

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  void _showAddSlotDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Slot'),
        content: const Text('This is a placeholder for the Add New Slot screen.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildCalendarStrip(),
              const SizedBox(height: 24),
              _buildEarningsCard(),
              const SizedBox(height: 24),
              _buildUpcomingSlotCard(),
              const SizedBox(height: 24),
              _buildTodayBookingsSection(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddSlotDialog,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildHeader() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${_getGreeting()}, Ayush!',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.verified,
                    color: _trainerStatus == 'Verified'
                        ? Colors.green
                        : Colors.orange,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    _trainerStatus,
                    style: TextStyle(
                      color: _trainerStatus == 'Verified'
                          ? Colors.green
                          : Colors.orange,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
                onPressed: () => widget.toggleTheme(),
              ),
              const CircleAvatar(
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarStrip() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'April 2025',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 90,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 7,
            itemBuilder: (context, index) {
              final date = DateTime.now().add(Duration(days: index));
              final isSelected = date.day == _selectedDate.day &&
                  date.month == _selectedDate.month &&
                  date.year == _selectedDate.year;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedDate = date;
                  });
                },
                child: Container(
                  width: 60,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).cardTheme.color,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat('E').format(date).substring(0, 3),
                        style: TextStyle(
                          color: isSelected ? Colors.white : null,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected
                              ? Colors.white
                              : Theme.of(context).colorScheme.primary.withOpacity(0.1),
                        ),
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isSelected
                                ? Theme.of(context).colorScheme.primary
                                : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEarningsCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Earnings This Week',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Icon(Icons.bar_chart),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              '\$${_weeklyEarnings.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.arrow_upward,
                    color: Colors.green,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '12% from last week',
                    style: TextStyle(
                      color: Colors.green[700],
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingSlotCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Upcoming Slot',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Today',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.fitness_center,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _nextBooking['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        _nextBooking['type'],
                        style: TextStyle(
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      _nextBooking['time'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      _nextBooking['duration'],
                      style: TextStyle(
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodayBookingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Today\'s Bookings',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'See All',
              style: TextStyle(
                color: Colors.teal,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _bookings.length,
          itemBuilder: (context, index) {
            final booking = _bookings[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: index % 2 == 0
                              ? Colors.orangeAccent.withOpacity(0.1)
                              : Colors.purpleAccent.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          index % 2 == 0 ? Icons.sports_gymnastics : Icons.self_improvement,
                          color: index % 2 == 0 ? Colors.orangeAccent : Colors.purpleAccent,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              booking['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              booking['type'],
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodySmall?.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            booking['time'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            booking['duration'],
                            style: TextStyle(
                              color: Theme.of(context).textTheme.bodySmall?.color,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}