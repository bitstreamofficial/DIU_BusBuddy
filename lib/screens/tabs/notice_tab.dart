import 'package:flutter/material.dart';

class NoticeTab extends StatefulWidget {
  const NoticeTab({super.key});

  @override
  State<NoticeTab> createState() => _NoticeTabState();
}

class _NoticeTabState extends State<NoticeTab> {
  // Sample notice data - in a real app, this would come from a backend
  final List<Notice> _notices = [
    Notice(
      id: '1',
      title: 'New Bus "Dolphin 9" Added to Route A',
      message:
          'A new bus "Dolphin 9" has been assigned to Route A (DSC to Uttara) for the 8:30 AM schedule to handle increased passenger volume. This modern AC bus has enhanced safety features.',
      type: NoticeType.busAssignment,
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      routeAffected: 'Route A - DSC to Uttara',
      isRead: false,
    ),
    Notice(
      id: '2',
      title: 'Route B Schedule Update',
      message:
          'The 6:00 PM departure from Dhanmondi has been moved to 6:15 PM due to traffic conditions. Please plan accordingly.',
      type: NoticeType.scheduleChange,
      timestamp: DateTime.now().subtract(const Duration(hours: 5)),
      routeAffected: 'Route B - DSC to Dhanmondi',
      isRead: true,
    ),
    Notice(
      id: '3',
      title: 'Temporary Route Suspension',
      message:
          'Route D (DSC to Wari) will be temporarily suspended from 2:00 PM to 4:00 PM today due to road construction work.',
      type: NoticeType.routeSuspension,
      timestamp: DateTime.now().subtract(const Duration(hours: 8)),
      routeAffected: 'Route D - DSC to Wari',
      isRead: false,
    ),
    Notice(
      id: '4',
      title: 'Holiday Schedule Notice',
      message:
          'Special holiday schedule will be in effect from December 24-26. Limited bus services will be available. Check the updated schedule.',
      type: NoticeType.general,
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      routeAffected: 'All Routes',
      isRead: true,
    ),
    Notice(
      id: '5',
      title: 'Emergency Contact Update',
      message:
          'New emergency contact number for bus-related issues: +880-1234-567890. Save this number for immediate assistance.',
      type: NoticeType.general,
      timestamp: DateTime.now().subtract(const Duration(days: 2)),
      routeAffected: 'All Routes',
      isRead: false,
    ),
    Notice(
      id: '6',
      title: 'New Bus "Eagle 12" Added to Route B',
      message:
          'A new premium bus "Eagle 12" has been added to Route B (DSC to Dhanmondi) for the 9:00 AM and 5:00 PM schedules. Features include reclining seats and USB charging ports.',
      type: NoticeType.busAssignment,
      timestamp: DateTime.now().subtract(const Duration(hours: 12)),
      routeAffected: 'Route B - DSC to Dhanmondi',
      isRead: true,
    ),
    Notice(
      id: '7',
      title: 'Bus "Tiger 7" Back in Service',
      message:
          'Bus "Tiger 7" has returned to service on Route C (DSC to Mirpur) after maintenance. The bus now features upgraded air conditioning and safety systems.',
      type: NoticeType.busAssignment,
      timestamp: DateTime.now().subtract(const Duration(days: 3)),
      routeAffected: 'Route C - DSC to Mirpur',
      isRead: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final unreadCount = _notices.where((notice) => !notice.isRead).length;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with unread count
            Row(
              children: [
                const Text(
                  'Notices',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF000000),
                    letterSpacing: -0.3,
                  ),
                ),
                const Spacer(),
                if (unreadCount > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '$unreadCount new',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 24),

            // Notices list
            Expanded(
              child:
                  _notices.isEmpty
                      ? _buildEmptyState()
                      : ListView.builder(
                        itemCount: _notices.length,
                        itemBuilder: (context, index) {
                          return _buildNoticeCard(_notices[index]);
                        },
                      ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_outlined,
            size: 64,
            color: Colors.black.withOpacity(0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'No New Notices',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'All administrative notices will appear here',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoticeCard(Notice notice) {
    return GestureDetector(
      onTap: () => _showNoticeDetails(notice),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: notice.isRead ? Colors.white : const Color(0xFFF0F8FF),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color:
                notice.isRead
                    ? Colors.black.withOpacity(0.1)
                    : const Color(0xFF007AFF).withOpacity(0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with type icon and timestamp
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: _getNoticeTypeColor(notice.type).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    _getNoticeTypeIcon(notice.type),
                    size: 20,
                    color: _getNoticeTypeColor(notice.type),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    notice.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF000000),
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
                if (!notice.isRead)
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFF007AFF),
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),

            // Notice message
            Text(
              notice.message,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black.withOpacity(0.7),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),

            // Route affected and timestamp
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF007AFF).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    notice.routeAffected,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF007AFF),
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  _formatTimestamp(notice.timestamp),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showNoticeDetails(Notice notice) {
    // Mark notice as read when viewed
    setState(() {
      final noticeIndex = _notices.indexWhere((n) => n.id == notice.id);
      if (noticeIndex != -1 && !_notices[noticeIndex].isRead) {
        _notices[noticeIndex] = Notice(
          id: notice.id,
          title: notice.title,
          message: notice.message,
          type: notice.type,
          timestamp: notice.timestamp,
          routeAffected: notice.routeAffected,
          isRead: true,
        );
      }
    });

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildNoticeDetailModal(notice),
    );
  }

  Widget _buildNoticeDetailModal(Notice notice) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Column(
            children: [
              // Handle bar
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header with icon and type
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: _getNoticeTypeColor(
                                notice.type,
                              ).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              _getNoticeTypeIcon(notice.type),
                              size: 24,
                              color: _getNoticeTypeColor(notice.type),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _getNoticeTypeLabel(notice.type),
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: _getNoticeTypeColor(notice.type),
                                    letterSpacing: -0.1,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _formatDetailedTimestamp(notice.timestamp),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // Title
                      Text(
                        notice.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF000000),
                          letterSpacing: -0.3,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Route affected
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF007AFF).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0xFF007AFF).withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.route_rounded,
                              size: 16,
                              color: Color(0xFF007AFF),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              notice.routeAffected,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF007AFF),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Message content
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F9FA),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.1),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          notice.message,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF000000),
                            height: 1.6,
                            letterSpacing: -0.1,
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Additional details based on notice type
                      _buildAdditionalDetails(notice),

                      const SizedBox(height: 32),

                      // Action buttons
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () => Navigator.pop(context),
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                side: BorderSide(
                                  color: Colors.black.withOpacity(0.2),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Close',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF000000),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                // Navigate to schedule tab or relevant action
                                DefaultTabController.of(context).animateTo(1);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF007AFF),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'View Schedule',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _getNoticeTypeLabel(NoticeType type) {
    switch (type) {
      case NoticeType.busAssignment:
        return 'Bus Assignment';
      case NoticeType.scheduleChange:
        return 'Schedule Change';
      case NoticeType.routeSuspension:
        return 'Route Suspension';
      case NoticeType.general:
        return 'General Notice';
    }
  }

  String _formatDetailedTimestamp(DateTime timestamp) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];

    final day = timestamp.day;
    final month = months[timestamp.month - 1];
    final year = timestamp.year;
    final hour = timestamp.hour;
    final minute = timestamp.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);

    return '$day $month $year at $displayHour:$minute $period';
  }

  Widget _buildAdditionalDetails(Notice notice) {
    switch (notice.type) {
      case NoticeType.busAssignment:
        return _buildBusAssignmentDetails(notice);
      case NoticeType.scheduleChange:
        return _buildScheduleChangeDetails();
      case NoticeType.routeSuspension:
        return _buildRouteSuspensionDetails();
      case NoticeType.general:
        return _buildGeneralNoticeDetails();
    }
  }

  Widget _buildBusAssignmentDetails(Notice notice) {
    // Extract bus name from notice title
    String busName = 'Unknown Bus';
    String busNumber = 'DHK-TA-XX-XXXX';
    String features = 'Standard Features';
    String driver = 'Driver Name';

    // Parse different bus assignments
    if (notice.title.contains('Dolphin 9')) {
      busName = 'Dolphin 9';
      busNumber = 'DHK-TA-11-4529';
      features = 'AC, GPS Tracking, Wi-Fi';
      driver = 'Md. Karim Rahman';
    } else if (notice.title.contains('Eagle 12')) {
      busName = 'Eagle 12';
      busNumber = 'DHK-TA-12-7834';
      features = 'Premium AC, Reclining Seats, USB Charging';
      driver = 'Md. Rashid Ahmed';
    } else if (notice.title.contains('Tiger 7')) {
      busName = 'Tiger 7';
      busNumber = 'DHK-TA-09-2156';
      features = 'Upgraded AC, Enhanced Safety Systems';
      driver = 'Md. Habibur Rahman';
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF34C759).withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF34C759).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.directions_bus_rounded,
                size: 20,
                color: const Color(0xFF34C759),
              ),
              const SizedBox(width: 8),
              const Text(
                'Bus Assignment Details',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF34C759),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildDetailRow('Bus Name:', busName),
          _buildDetailRow('Bus Number:', busNumber),
          _buildDetailRow('Time Slot:', '8:30 AM - 9:00 AM'),
          _buildDetailRow('Capacity:', '45 passengers'),
          _buildDetailRow('Features:', features),
          _buildDetailRow('Driver:', driver),
        ],
      ),
    );
  }

  Widget _buildScheduleChangeDetails() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFF9500).withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFFF9500).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.schedule_rounded,
                size: 20,
                color: const Color(0xFFFF9500),
              ),
              const SizedBox(width: 8),
              const Text(
                'Schedule Change Details',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFFF9500),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildDetailRow('Previous Time:', '6:00 PM'),
          _buildDetailRow('New Time:', '6:15 PM'),
          _buildDetailRow('Effective Date:', 'Today onwards'),
          _buildDetailRow('Reason:', 'Traffic conditions'),
        ],
      ),
    );
  }

  Widget _buildRouteSuspensionDetails() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFF3B30).withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFFF3B30).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.warning_rounded,
                size: 20,
                color: const Color(0xFFFF3B30),
              ),
              const SizedBox(width: 8),
              const Text(
                'Suspension Details',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFFFF3B30),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildDetailRow('Suspension Period:', '2:00 PM - 4:00 PM'),
          _buildDetailRow('Duration:', 'Today only'),
          _buildDetailRow('Reason:', 'Road construction'),
          _buildDetailRow('Alternative:', 'Use Route B or C'),
        ],
      ),
    );
  }

  Widget _buildGeneralNoticeDetails() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF007AFF).withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF007AFF).withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.info_rounded,
                size: 20,
                color: const Color(0xFF007AFF),
              ),
              const SizedBox(width: 8),
              const Text(
                'Additional Information',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF007AFF),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildDetailRow('Contact Number:', '+880-1234-567890'),
          _buildDetailRow('Email:', 'support@diu-busbuddy.com'),
          _buildDetailRow('Office Hours:', '9:00 AM - 5:00 PM'),
          _buildDetailRow('Emergency Support:', '24/7 Available'),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.6),
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF000000),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getNoticeTypeColor(NoticeType type) {
    switch (type) {
      case NoticeType.busAssignment:
        return const Color(0xFF34C759);
      case NoticeType.scheduleChange:
        return const Color(0xFFFF9500);
      case NoticeType.routeSuspension:
        return const Color(0xFFFF3B30);
      case NoticeType.general:
        return const Color(0xFF007AFF);
    }
  }

  IconData _getNoticeTypeIcon(NoticeType type) {
    switch (type) {
      case NoticeType.busAssignment:
        return Icons.directions_bus_rounded;
      case NoticeType.scheduleChange:
        return Icons.schedule_rounded;
      case NoticeType.routeSuspension:
        return Icons.warning_rounded;
      case NoticeType.general:
        return Icons.info_rounded;
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}

// Notice data model
class Notice {
  final String id;
  final String title;
  final String message;
  final NoticeType type;
  final DateTime timestamp;
  final String routeAffected;
  final bool isRead;

  Notice({
    required this.id,
    required this.title,
    required this.message,
    required this.type,
    required this.timestamp,
    required this.routeAffected,
    required this.isRead,
  });
}

enum NoticeType { busAssignment, scheduleChange, routeSuspension, general }
