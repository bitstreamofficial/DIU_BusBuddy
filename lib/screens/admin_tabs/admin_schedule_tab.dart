import 'package:flutter/material.dart';
import 'dart:async';
import '../route_detail_screen.dart';

enum BusStatus { departed, current, next, upcoming }

class AdminScheduleTab extends StatefulWidget {
  const AdminScheduleTab({super.key});

  @override
  State<AdminScheduleTab> createState() => _AdminScheduleTabState();
}

class _AdminScheduleTabState extends State<AdminScheduleTab>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _startTimer();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (mounted) {
        setState(() {
          // Update the UI every 30 seconds to refresh time-based colors
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                const Text(
                  'Bus Schedule',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF000000),
                    letterSpacing: -0.3,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF34C759).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: Color(0xFF34C759),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'Live',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF34C759),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Tab Bar
            Container(
              height: 48,
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.black.withOpacity(0.08),
                  width: 1,
                ),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF007AFF), Color(0xFF5AC8FA)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF007AFF).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.black.withOpacity(0.6),
                labelStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.2,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.2,
                ),
                tabs: const [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.directions_bus_outlined, size: 16),
                        SizedBox(width: 6),
                        Text('To Destination'),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.home_outlined, size: 16),
                        SizedBox(width: 6),
                        Text('To DSC'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Tab Bar View
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildScheduleList(isDSCToDestination: true),
                  _buildScheduleList(isDSCToDestination: false),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleList({required bool isDSCToDestination}) {
    return ListView(
      children: [
        _buildRouteSchedule(
          context: context,
          routeName:
              isDSCToDestination ? 'DSC to Dhanmondi' : 'Dhanmondi to DSC',
          origin: isDSCToDestination ? 'Daffodil Smart City' : 'Dhanmondi',
          destination: isDSCToDestination ? 'Dhanmondi' : 'Daffodil Smart City',
          times:
              isDSCToDestination
                  ? [
                    '7:00 AM',
                    '8:30 AM',
                    '10:00 AM',
                    '12:00 PM',
                    '2:00 PM',
                    '8:00 PM',
                    '9:00 PM',
                  ]
                  : [
                    '8:00 AM',
                    '9:30 AM',
                    '11:00 AM',
                    '1:00 PM',
                    '3:00 PM',
                    '5:00 PM',
                    '7:00 PM',
                  ],
          color: const Color(0xFF007AFF),
        ),
        const SizedBox(height: 16),
        _buildRouteSchedule(
          context: context,
          routeName: isDSCToDestination ? 'DSC to Uttara' : 'Uttara to DSC',
          origin: isDSCToDestination ? 'Daffodil Smart City' : 'Uttara',
          destination: isDSCToDestination ? 'Uttara' : 'Daffodil Smart City',
          times:
              isDSCToDestination
                  ? [
                    '7:30 AM',
                    '9:00 AM',
                    '11:00 AM',
                    '1:00 PM',
                    '3:00 PM',
                    '5:00 PM',
                    '7:00 PM',
                  ]
                  : [
                    '8:30 AM',
                    '10:00 AM',
                    '12:00 PM',
                    '2:00 PM',
                    '4:00 PM',
                    '6:00 PM',
                    '8:00 PM',
                  ],
          color: const Color(0xFF34C759),
        ),
        const SizedBox(height: 16),
        _buildRouteSchedule(
          context: context,
          routeName: isDSCToDestination ? 'DSC to Mirpur' : 'Mirpur to DSC',
          origin: isDSCToDestination ? 'Daffodil Smart City' : 'Mirpur',
          destination: isDSCToDestination ? 'Mirpur' : 'Daffodil Smart City',
          times:
              isDSCToDestination
                  ? [
                    '8:00 AM',
                    '9:30 AM',
                    '11:30 AM',
                    '1:30 PM',
                    '3:30 PM',
                    '5:30 PM',
                    '7:30 PM',
                  ]
                  : [
                    '9:00 AM',
                    '10:30 AM',
                    '12:30 PM',
                    '2:30 PM',
                    '4:30 PM',
                    '6:30 PM',
                    '8:30 PM',
                  ],
          color: const Color(0xFFFF9500),
        ),
        const SizedBox(height: 16),
        _buildRouteSchedule(
          context: context,
          routeName:
              isDSCToDestination ? 'DSC to Narayanganj' : 'Narayanganj to DSC',
          origin: isDSCToDestination ? 'Daffodil Smart City' : 'Narayanganj',
          destination:
              isDSCToDestination ? 'Narayanganj' : 'Daffodil Smart City',
          times:
              isDSCToDestination
                  ? [
                    '8:30 AM',
                    '10:30 AM',
                    '12:30 PM',
                    '2:30 PM',
                    '4:30 PM',
                    '6:30 PM',
                  ]
                  : [
                    '9:30 AM',
                    '11:30 AM',
                    '1:30 PM',
                    '3:30 PM',
                    '5:30 PM',
                    '7:30 PM',
                  ],
          color: const Color(0xFFFF5733),
        ),
        const SizedBox(height: 32),

        // Footer info
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.black.withOpacity(0.1), width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: 20,
                    color: Colors.black.withOpacity(0.6),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Schedule Information',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF000000),
                      letterSpacing: -0.1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                isDSCToDestination
                    ? '• All schedules are from Daffodil Smart City (DSC)\n'
                        '• Buses arrive 5-10 minutes before departure\n'
                        '• Schedule may vary on weekends and holidays\n'
                        '• Check live tracking for real-time updates'
                    : '• Return schedules to Daffodil Smart City (DSC)\n'
                        '• Buses arrive 5-10 minutes before departure\n'
                        '• Schedule may vary on weekends and holidays\n'
                        '• Check live tracking for real-time updates',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withOpacity(0.7),
                  letterSpacing: -0.1,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRouteSchedule({
    required BuildContext context,
    required String routeName,
    required String origin,
    required String destination,
    required List<String> times,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) => RouteDetailScreen(
                  routeName: routeName,
                  origin: origin,
                  destination: destination,
                  times: times,
                  color: color,
                ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black.withOpacity(0.1), width: 1),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.08),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Route header
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Route ${destination.substring(0, 1)}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      routeName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF000000),
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '${times.length} trips',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: color,
                      letterSpacing: -0.1,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),
            // Route full name with location icon
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.place_outlined,
                  size: 14,
                  color: Colors.black.withOpacity(0.5),
                ),
                const SizedBox(width: 4),
                Text(
                  origin,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.6),
                    letterSpacing: -0.1,
                  ),
                ),
                const SizedBox(width: 6),
                Icon(
                  Icons.arrow_forward_rounded,
                  size: 14,
                  color: Colors.black.withOpacity(0.4),
                ),
                const SizedBox(width: 6),
                Text(
                  destination,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black.withOpacity(0.6),
                    letterSpacing: -0.1,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            // Time slots
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children:
                  times
                      .map((time) => _buildTimeSlot(time, times, color))
                      .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeSlot(String time, List<String> allTimes, Color color) {
    final now = DateTime.now();
    final currentTime =
        '${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}';

    final busStatus = _getNextBusStatus(time, allTimes, currentTime);

    // Determine colors based on bus status
    Color backgroundColor;
    Color textColor;
    Color borderColor;
    IconData? statusIcon;

    switch (busStatus) {
      case BusStatus.departed:
        backgroundColor = Colors.red.withOpacity(0.1);
        textColor = Colors.red.shade700;
        borderColor = Colors.red.shade300;
        statusIcon = Icons.check_circle_outline_rounded;
        break;
      case BusStatus.current:
        backgroundColor = const Color(0xFF34C759);
        textColor = Colors.white;
        borderColor = const Color(0xFF34C759);
        statusIcon = Icons.directions_bus_rounded;
        break;
      case BusStatus.next:
        backgroundColor = const Color(0xFF34C759).withOpacity(0.1);
        textColor = const Color(0xFF34C759);
        borderColor = const Color(0xFF34C759).withOpacity(0.3);
        statusIcon = Icons.schedule_rounded;
        break;
      case BusStatus.upcoming:
        backgroundColor = Colors.blue.withOpacity(0.1);
        textColor = Colors.blue.shade700;
        borderColor = Colors.blue.shade300;
        statusIcon = null;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor, width: 1),
        boxShadow:
            busStatus == BusStatus.current
                ? [
                  BoxShadow(
                    color: const Color(0xFF34C759).withOpacity(0.3),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ]
                : [],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (statusIcon != null) Icon(statusIcon, size: 14, color: textColor),
          if (statusIcon != null) const SizedBox(width: 4),
          Text(
            time,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: textColor,
              letterSpacing: -0.1,
            ),
          ),
        ],
      ),
    );
  }

  BusStatus _getNextBusStatus(
    String busTime,
    List<String> allTimes,
    String currentTime,
  ) {
    final busMinutes = _timeToMinutes(busTime);
    final currentMinutes = _timeToMinutes(currentTime);

    if (busMinutes < currentMinutes) {
      return BusStatus.departed;
    }

    // Find all future buses
    final futureBuses =
        allTimes
            .where((time) => _timeToMinutes(time) >= currentMinutes)
            .map((time) => _timeToMinutes(time))
            .toList()
          ..sort();

    if (futureBuses.isEmpty) {
      return BusStatus.departed;
    }

    // The very next bus is green (next)
    if (busMinutes == futureBuses.first) {
      return BusStatus.next;
    }

    // All other future buses are blue (upcoming)
    return BusStatus.upcoming;
  }

  int _timeToMinutes(String time) {
    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1].split(' ')[0]);
    final isAM = time.contains('AM');
    final hour24 =
        isAM ? (hour == 12 ? 0 : hour) : (hour == 12 ? 12 : hour + 12);
    return hour24 * 60 + minute;
  }
}
