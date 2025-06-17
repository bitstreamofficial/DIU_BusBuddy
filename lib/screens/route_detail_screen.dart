import 'package:flutter/material.dart';
import 'dart:async';

class RouteDetailScreen extends StatefulWidget {
  final String routeName;
  final String origin;
  final String destination;
  final List<String> times;
  final Color color;

  const RouteDetailScreen({
    super.key,
    required this.routeName,
    required this.origin,
    required this.destination,
    required this.times,
    required this.color,
  });

  @override
  State<RouteDetailScreen> createState() => _RouteDetailScreenState();
}

class _RouteDetailScreenState extends State<RouteDetailScreen> {
  late Timer _timer;
  DateTime _currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Color(0xFF000000),
            size: 20,
          ),
        ),
        title: Text(
          widget.routeName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xFF000000),
            letterSpacing: -0.2,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Route Info Header
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [widget.color, widget.color.withOpacity(0.8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: widget.color.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Route ${widget.destination.substring(0, 1)}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF34C759).withOpacity(0.9),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.circle, color: Colors.white, size: 6),
                            SizedBox(width: 6),
                            Text(
                              'Live',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Route path
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          widget.origin,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: -0.1,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      const Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          widget.destination,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: -0.1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Quick stats
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStat(
                        '${widget.times.length}',
                        'Daily Trips',
                        Icons.directions_bus_rounded,
                      ),
                      _buildStat(
                        '45 min',
                        'Duration',
                        Icons.access_time_rounded,
                      ),
                      _buildStat('25 km', 'Distance', Icons.straighten_rounded),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Next Bus Card
            _buildNextBusCard(),
            const SizedBox(height: 24),

            // Today's Schedule
            const Text(
              'Today\'s Schedule',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF000000),
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 16), // Enhanced time slots with status
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 2.0,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: widget.times.length,
              itemBuilder: (context, index) {
                return _buildDetailedTimeSlot(widget.times[index], index);
              },
            ),
            const SizedBox(height: 24),

            // Route Stops
            const Text(
              'Route Stops',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF000000),
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.black.withOpacity(0.1),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: widget.color.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(children: _buildRouteStops()),
            ),
            const SizedBox(height: 24),

            // Route Map
            const Text(
              'Route Map',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF000000),
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 16),

            Container(
              height: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.black.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CustomPaint(
                  painter: RouteMapPainter(widget.color),
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.map_rounded,
                          size: 48,
                          color: Colors.black26,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Interactive Route Map',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String value, String label, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Colors.white.withOpacity(0.8),
            letterSpacing: -0.1,
          ),
        ),
      ],
    );
  }

  Widget _buildNextBusCard() {
    final now = _currentTime;
    final hour = now.hour;
    final minute = now.minute;
    final hour12 = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    final ampm = hour < 12 ? 'AM' : 'PM';
    final currentTimeStr =
        '${hour12.toString()}:${minute.toString().padLeft(2, '0')} $ampm';

    // Find the next bus
    final currentMinutes = _timeToMinutes(currentTimeStr);
    final futureBuses =
        widget.times
            .where((time) => _timeToMinutes(time) >= currentMinutes)
            .toList();

    if (futureBuses.isEmpty) {
      // No more buses today
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.withOpacity(0.3), width: 1),
        ),
        child: const Row(
          children: [
            Icon(Icons.info_outline_rounded, color: Colors.grey, size: 24),
            SizedBox(width: 12),
            Text(
              'No more buses today',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    // Get the very next bus
    futureBuses.sort((a, b) => _timeToMinutes(a).compareTo(_timeToMinutes(b)));
    final nextBusTime = futureBuses.first;
    final countdown = _getCountdown(nextBusTime, currentTimeStr);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF34C759),
            const Color(0xFF34C759).withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF34C759).withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.directions_bus_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Next Bus',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  nextBusTime,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'Leaves in',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  countdown,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: -0.2,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedTimeSlot(String time, int index) {
    final now = _currentTime;
    final hour = now.hour;
    final minute = now.minute;
    final hour12 = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    final ampm = hour < 12 ? 'AM' : 'PM';
    final currentTimeStr =
        '${hour12.toString()}:${minute.toString().padLeft(2, '0')} $ampm';

    final busStatus = _getBusStatus(time, currentTimeStr);
    final Color backgroundColor;
    final Color textColor;
    final Color borderColor;
    final String statusText;
    final IconData statusIcon;
    switch (busStatus) {
      case BusStatus.departed:
        backgroundColor = Colors.red.withOpacity(0.1);
        textColor = Colors.red.shade700;
        borderColor = Colors.red.shade300;
        statusText = 'Departed';
        statusIcon = Icons.check_circle_outline_rounded;
        break;
      case BusStatus.next:
        backgroundColor = const Color(0xFF34C759);
        textColor = Colors.white;
        borderColor = const Color(0xFF34C759);
        statusText = _getCountdown(time, currentTimeStr);
        statusIcon = Icons.schedule_rounded;
        break;
      case BusStatus.upcoming:
        backgroundColor = Colors.blue.withOpacity(0.1);
        textColor = Colors.blue.shade700;
        borderColor = Colors.blue.shade300;
        statusText = 'Scheduled';
        statusIcon = Icons.access_time_rounded;
        break;
      case BusStatus.current:
        // This case should not be used anymore, but keeping for safety
        backgroundColor = const Color(0xFF34C759);
        textColor = Colors.white;
        borderColor = const Color(0xFF34C759);
        statusText = _getCountdown(time, currentTimeStr);
        statusIcon = Icons.directions_bus_rounded;
        break;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 1),
        boxShadow:
            busStatus == BusStatus.next
                ? [
                  BoxShadow(
                    color: const Color(0xFF34C759).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
                : [],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(statusIcon, size: 16, color: textColor),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  time,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                    letterSpacing: -0.1,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            statusText,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: textColor.withOpacity(0.8),
              letterSpacing: 0.2,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  List<Widget> _buildRouteStops() {
    final stops = _getRouteStops();
    return stops.asMap().entries.map((entry) {
      final index = entry.key;
      final stop = entry.value;
      final isLast = index == stops.length - 1;

      return Column(
        children: [
          Row(
            children: [
              Column(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color:
                          index == 0 || isLast
                              ? widget.color
                              : widget.color.withOpacity(0.6),
                      shape: BoxShape.circle,
                    ),
                  ),
                  if (!isLast)
                    Container(
                      width: 2,
                      height: 40,
                      color: widget.color.withOpacity(0.3),
                    ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stop,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black.withOpacity(0.8),
                        letterSpacing: -0.1,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      index == 0
                          ? 'Origin'
                          : isLast
                          ? 'Destination'
                          : 'Stop ${index + 1}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(0.5),
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
              if (index == 0 || isLast)
                Icon(
                  index == 0 ? Icons.home_rounded : Icons.location_on_rounded,
                  color: widget.color,
                  size: 20,
                ),
            ],
          ),
          if (!isLast) const SizedBox(height: 8),
        ],
      );
    }).toList();
  }

  List<String> _getRouteStops() {
    // Generate route stops based on destination
    if (widget.destination.contains('Dhanmondi')) {
      return [
        widget.origin,
        'Savar Bus Stand',
        'Hemayetpur',
        'Aminbazar',
        'Gabtali',
        'Kalyanpur',
        'Shyamoli',
        'Dhanmondi 27',
        widget.destination,
      ];
    } else if (widget.destination.contains('Uttara')) {
      return [
        widget.origin,
        'Savar Bus Stand',
        'Aminbazar',
        'Gabtali',
        'Mirpur 1',
        'Mirpur 10',
        'Kazipara',
        'Uttara Sector 3',
        widget.destination,
      ];
    } else if (widget.destination.contains('Mirpur')) {
      return [
        widget.origin,
        'Savar Bus Stand',
        'Aminbazar',
        'Gabtali',
        'Mirpur 14',
        'Mirpur 10',
        'Mirpur 1',
        widget.destination,
      ];
    } else {
      return [
        widget.origin,
        'Savar Bus Stand',
        'Dhamrai',
        'Nabinagar',
        'Maowa',
        'Shimulia',
        'Bandar',
        widget.destination,
      ];
    }
  }

  BusStatus _getBusStatus(String busTime, String currentTime) {
    final busMinutes = _timeToMinutes(busTime);
    final currentMinutes = _timeToMinutes(currentTime);

    if (busMinutes < currentMinutes) {
      return BusStatus.departed;
    }

    // Find all future buses
    final futureBuses =
        widget.times
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

    // Handle both "MM AM/PM" and "MM" formats
    String minutePart = parts[1];
    int minute;
    bool isAM = true;

    if (minutePart.contains('AM') || minutePart.contains('PM')) {
      isAM = minutePart.contains('AM');
      minute = int.parse(minutePart.replaceAll(RegExp(r'[^0-9]'), ''));
    } else {
      minute = int.parse(minutePart);
      // If no AM/PM, assume 24-hour format
      return hour * 60 + minute;
    }

    final hour24 =
        isAM ? (hour == 12 ? 0 : hour) : (hour == 12 ? 12 : hour + 12);
    return hour24 * 60 + minute;
  }

  String _getCountdown(String busTime, String currentTime) {
    final busDateTime = _parseTimeToDateTime(busTime);
    final now = _currentTime;

    final diff = busDateTime.difference(now);

    if (diff.isNegative || diff.inSeconds <= 0) return 'Now';

    final hours = diff.inHours;
    final minutes = diff.inMinutes % 60;
    final seconds = diff.inSeconds % 60;

    // Format the countdown
    if (hours > 0) {
      return '${hours}h ${minutes}m ${seconds}s';
    } else if (minutes > 0) {
      return '${minutes}m ${seconds}s';
    } else {
      return '${seconds}s';
    }
  }

  DateTime _parseTimeToDateTime(String time) {
    final parts = time.split(':');
    final hour = int.parse(parts[0]);

    String minutePart = parts[1];
    int minute;
    bool isAM = true;

    if (minutePart.contains('AM') || minutePart.contains('PM')) {
      isAM = minutePart.contains('AM');
      minute = int.parse(minutePart.replaceAll(RegExp(r'[^0-9]'), ''));
    } else {
      minute = int.parse(minutePart);
      // If no AM/PM, assume 24-hour format
      final now = DateTime.now();
      return DateTime(now.year, now.month, now.day, hour, minute);
    }

    final hour24 =
        isAM ? (hour == 12 ? 0 : hour) : (hour == 12 ? 12 : hour + 12);
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hour24, minute);
  }
}

enum BusStatus { departed, current, next, upcoming }

class RouteMapPainter extends CustomPainter {
  final Color color;

  RouteMapPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color.withOpacity(0.3)
          ..strokeWidth = 3
          ..style = PaintingStyle.stroke;

    final path = Path();

    // Draw a simple route line
    path.moveTo(20, size.height * 0.8);
    path.quadraticBezierTo(
      size.width * 0.3,
      size.height * 0.2,
      size.width * 0.6,
      size.height * 0.6,
    );
    path.quadraticBezierTo(
      size.width * 0.8,
      size.height * 0.9,
      size.width - 20,
      size.height * 0.2,
    );

    canvas.drawPath(path, paint);

    // Draw stops
    final stopPaint =
        Paint()
          ..color = color
          ..style = PaintingStyle.fill;

    final stops = [
      Offset(20, size.height * 0.8),
      Offset(size.width * 0.25, size.height * 0.4),
      Offset(size.width * 0.5, size.height * 0.7),
      Offset(size.width * 0.75, size.height * 0.3),
      Offset(size.width - 20, size.height * 0.2),
    ];

    for (final stop in stops) {
      canvas.drawCircle(stop, 6, stopPaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
