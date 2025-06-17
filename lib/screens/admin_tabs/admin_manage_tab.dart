import 'package:flutter/material.dart';

class AdminManageTab extends StatefulWidget {
  const AdminManageTab({super.key});

  @override
  State<AdminManageTab> createState() => _AdminManageTabState();
}

class _AdminManageTabState extends State<AdminManageTab> {
  // Sample data for dropdowns
  final List<String> _buses = [
    'Dolphin 1',
    'Dolphin 2',
    'Dolphin 3',
    'Dolphin 4',
    'Dolphin 5',
    'Eagle 1',
    'Eagle 2',
    'Eagle 3',
    'Eagle 4',
    'Eagle 5',
    'Phoenix 1',
    'Phoenix 2',
    'Phoenix 3',
    'Phoenix 4',
    'Phoenix 5',
    'Hawk 1',
    'Hawk 2',
    'Hawk 3',
    'Hawk 4',
    'Hawk 5',
  ];

  final List<Map<String, String>> _routes = [
    {'name': 'Route A', 'description': 'Dhanmondi → DIU Campus'},
    {'name': 'Route B', 'description': 'Uttara → DIU Campus'},
    {'name': 'Route C', 'description': 'Mirpur → DIU Campus'},
    {'name': 'Route D', 'description': 'Gulshan → DIU Campus'},
    {'name': 'Route E', 'description': 'Wari → DIU Campus'},
  ];

  final List<String> _times = [
    '7:00 AM',
    '7:15 AM',
    '7:30 AM',
    '7:45 AM',
    '8:00 AM',
    '8:15 AM',
    '8:30 AM',
    '8:45 AM',
    '9:00 AM',
    '9:15 AM',
    '9:30 AM',
    '9:45 AM',
    '10:00 AM',
    '2:00 PM',
    '2:15 PM',
    '2:30 PM',
    '2:45 PM',
    '3:00 PM',
    '3:15 PM',
    '3:30 PM',
    '3:45 PM',
    '4:00 PM',
    '4:15 PM',
    '4:30 PM',
    '4:45 PM',
    '5:00 PM',
    '5:15 PM',
    '5:30 PM',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Text(
              'Manage',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w700,
                color: Color(0xFF000000),
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Send notices and assign buses to routes',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
            const SizedBox(height: 32),

            // Management Options
            Expanded(
              child: Column(
                children: [
                  // Send Notice Card
                  _buildManagementCard(
                    title: 'Send Notice',
                    subtitle: 'Send notifications to all students',
                    icon: Icons.notifications_rounded,
                    color: const Color(0xFF34C759),
                    onTap: () {
                      // TODO: Navigate to send notice screen
                    },
                  ),
                  const SizedBox(height: 16), // Assign Bus Card
                  _buildManagementCard(
                    title: 'Assign Bus',
                    subtitle: 'Assign a bus to a route and time',
                    icon: Icons.directions_bus_rounded,
                    color: const Color(0xFF007AFF),
                    onTap: () {
                      _showAssignBusModal(context);
                    },
                  ),
                  const SizedBox(height: 16),

                  // Manage Routes Card
                  _buildManagementCard(
                    title: 'Manage Routes',
                    subtitle: 'Add or modify bus routes',
                    icon: Icons.route_rounded,
                    color: const Color(0xFFFF9500),
                    onTap: () {
                      // TODO: Navigate to manage routes screen
                    },
                  ),
                  const SizedBox(height: 16),

                  // View Reports Card
                  _buildManagementCard(
                    title: 'View Reports',
                    subtitle: 'Analytics and usage reports',
                    icon: Icons.analytics_rounded,
                    color: const Color(0xFF9C27B0),
                    onTap: () {
                      // TODO: Navigate to reports screen
                    },
                  ),

                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildManagementCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.1), width: 1),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Icon container
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, size: 28, color: color),
                ),
                const SizedBox(width: 16),

                // Text content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF000000),
                          letterSpacing: -0.2,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withOpacity(0.6),
                          letterSpacing: -0.1,
                        ),
                      ),
                    ],
                  ),
                ),

                // Arrow icon
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: Colors.black.withOpacity(0.4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAssignBusModal(BuildContext context) {
    String? selectedBus;
    String? selectedRoute;
    String? selectedTime;
    List<String> filteredBuses = List.from(_buses);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder:
          (context) => StatefulBuilder(
            builder:
                (context, setModalState) => Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF007AFF).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.directions_bus_rounded,
                                color: Color(0xFF007AFF),
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Assign Bus',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF000000),
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: const Icon(Icons.close),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Bus Selection with Search
                        const Text(
                          'Select Bus',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF000000),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black.withOpacity(0.1),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              // Search field
                              TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search bus...',
                                  prefixIcon: const Icon(Icons.search),
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.all(16),
                                ),
                                onChanged: (value) {
                                  setModalState(() {
                                    filteredBuses =
                                        _buses
                                            .where(
                                              (bus) =>
                                                  bus.toLowerCase().contains(
                                                    value.toLowerCase(),
                                                  ),
                                            )
                                            .toList();
                                  });
                                },
                              ),
                              // Dropdown for buses
                              Container(
                                height: 150,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: ListView.builder(
                                  itemCount: filteredBuses.length,
                                  itemBuilder: (context, index) {
                                    final bus = filteredBuses[index];
                                    final isSelected = selectedBus == bus;
                                    return ListTile(
                                      title: Text(
                                        bus,
                                        style: TextStyle(
                                          fontWeight:
                                              isSelected
                                                  ? FontWeight.w600
                                                  : FontWeight.w400,
                                          color:
                                              isSelected
                                                  ? const Color(0xFF007AFF)
                                                  : null,
                                        ),
                                      ),
                                      trailing:
                                          isSelected
                                              ? const Icon(
                                                Icons.check,
                                                color: Color(0xFF007AFF),
                                              )
                                              : null,
                                      onTap: () {
                                        setModalState(() {
                                          selectedBus = bus;
                                        });
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Route Selection
                        const Text(
                          'Select Route',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF000000),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black.withOpacity(0.1),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: const Text('Choose a route'),
                              value: selectedRoute,
                              isExpanded: true,
                              items:
                                  _routes.map((route) {
                                    return DropdownMenuItem<String>(
                                      value: route['name'],
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            route['name']!,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                            route['description']!,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black.withOpacity(
                                                0.6,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                              onChanged: (value) {
                                setModalState(() {
                                  selectedRoute = value;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Time Selection
                        const Text(
                          'Select Time',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF000000),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black.withOpacity(0.1),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: const Text('Choose departure time'),
                              value: selectedTime,
                              isExpanded: true,
                              items:
                                  _times.map((time) {
                                    return DropdownMenuItem<String>(
                                      value: time,
                                      child: Text(time),
                                    );
                                  }).toList(),
                              onChanged: (value) {
                                setModalState(() {
                                  selectedTime = value;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Action Buttons
                        Row(
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () => Navigator.pop(context),
                                style: TextButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: BorderSide(
                                      color: Colors.black.withOpacity(0.1),
                                    ),
                                  ),
                                ),
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                onPressed:
                                    selectedBus != null &&
                                            selectedRoute != null &&
                                            selectedTime != null
                                        ? () {
                                          _assignBus(
                                            selectedBus!,
                                            selectedRoute!,
                                            selectedTime!,
                                          );
                                          Navigator.pop(context);
                                        }
                                        : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF007AFF),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  'Assign Bus',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
          ),
    );
  }

  void _assignBus(String bus, String route, String time) {
    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Successfully assigned $bus to $route at $time',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF34C759),
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );

    // Here you would typically save the assignment to a database
    // For now, we'll just show the success message
  }
}
