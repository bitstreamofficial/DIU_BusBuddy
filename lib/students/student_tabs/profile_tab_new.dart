import 'dart:math';
import 'package:diu_busbuddy/students/student_auth/backend/auth_service.dart';
import 'package:diu_busbuddy/students/student_auth/backend/shared_preferences_service.dart';
import 'package:diu_busbuddy/students/student_auth/ui/student_login_screen.dart';
import 'package:diu_busbuddy/tabs/role_selection_screen.dart';
import 'package:flutter/material.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Header
            Row(
              children: [
                const Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF000000),
                    letterSpacing: -0.3,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    _showLogoutDialog(context);
                  },
                  icon: Icon(
                    Icons.logout_rounded,
                    size: 24,
                    color: Colors.red.withOpacity(0.8),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Transport Pass - Enhanced Design
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF007AFF).withOpacity(0.3),
                    blurRadius: 25,
                    offset: const Offset(0, 10),
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Background with gradient and geometric patterns
                  Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF007AFF),
                          Color(0xFF5AC8FA),
                          Color(0xFF00D4FF),
                        ],
                        stops: [0.0, 0.6, 1.0],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),

                  // Geometric pattern overlay
                  Positioned.fill(
                    child: CustomPaint(painter: GeometricPatternPainter()),
                  ),

                  // Content
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Header Row
                        Row(
                          children: [
                            // DIU Logo with enhanced design
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'DIU',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    color: const Color(0xFF007AFF),
                                    letterSpacing: 1,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'TRANSPORT PASS',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'SUMMER 2025',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white.withOpacity(0.9),
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Status Badge
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF34C759),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xFF34C759,
                                    ).withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: const Text(
                                'ACTIVE',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // Main Content Row
                        Row(
                          children: [
                            // Student Photo with enhanced frame
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.4),
                                  width: 3,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: const Image(
                                  image: AssetImage('assets/profile.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            const SizedBox(width: 20),

                            // Student Information
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Shakib Howlader',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      letterSpacing: -0.3,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black26,
                                          offset: Offset(0, 2),
                                          blurRadius: 4,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  const Text(
                                    'B.Sc in CSE',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'ID: 221-15-6029',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white.withOpacity(0.95),
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // QR Code with enhanced design
                            Container(
                              width: 60,
                              height: 60,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.qr_code_rounded,
                                size: 44,
                                color: const Color(0xFF007AFF),
                              ),
                            ),
                          ],
                        ),

                        const Spacer(),

                        // Footer Information
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'VALID UNTIL',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white.withOpacity(0.8),
                                    letterSpacing: 1,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'DEC 31, 2025',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              '+880 1834513095',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.white.withOpacity(0.9),
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // BusPoints Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF34C759),
                    Color(0xFF30D158),
                    Color(0xFF32D74B),
                  ],
                  stops: [0.0, 0.5, 1.0],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF34C759).withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Header Row
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.account_balance_wallet_rounded,
                          size: 24,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'BusPoints Balance',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: -0.2,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'In-app currency for bus fare',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.white.withOpacity(0.9),
                                letterSpacing: -0.1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Balance Display
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Current Balance
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Current Balance',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white.withOpacity(0.8),
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons.monetization_on_rounded,
                                size: 28,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                '1,250',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'BP',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white.withOpacity(0.9),
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Last Used
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Last Used',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.white.withOpacity(0.8),
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            '2 days ago',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              letterSpacing: -0.1,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              const Text(
                                '-25 BP',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  letterSpacing: -0.1,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                Icons.trending_down_rounded,
                                size: 16,
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_circle_outline_rounded,
                                size: 18,
                                color: const Color(0xFF34C759),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Add Points',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF34C759),
                                  letterSpacing: -0.1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.4),
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.history_rounded,
                                size: 18,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'History',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  letterSpacing: -0.1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Quick Stats
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildQuickStat(
                          label: 'This Month',
                          value: '15 trips',
                          icon: Icons.directions_bus_rounded,
                        ),
                        Container(
                          width: 1,
                          height: 30,
                          color: Colors.white.withOpacity(0.3),
                        ),
                        _buildQuickStat(
                          label: 'Total Spent',
                          value: '375 BP',
                          icon: Icons.payment_rounded,
                        ),
                        Container(
                          width: 1,
                          height: 30,
                          color: Colors.white.withOpacity(0.3),
                        ),
                        _buildQuickStat(
                          label: 'Avg/Trip',
                          value: '25 BP',
                          icon: Icons.trending_up_rounded,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Registered Route
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.black.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.route_outlined,
                        size: 24,
                        color: Colors.black.withOpacity(0.7),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Registered Route',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF000000),
                          letterSpacing: -0.2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Route Map
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F9FA),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.black.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Route header
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF007AFF).withOpacity(0.1),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF007AFF),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  'Route A',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'Dhanmondi → DIU Campus',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF000000),
                                  letterSpacing: -0.1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Route stops
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildRouteStop(
                                stopName: 'Dhanmondi 27',
                                isStart: true,
                                isEnd: false,
                              ),
                              const SizedBox(height: 8),
                              _buildRouteStop(
                                stopName: 'Mirpur 1',
                                isStart: false,
                                isEnd: false,
                              ),
                              const SizedBox(height: 8),
                              _buildRouteStop(
                                stopName: 'Kalabagan',
                                isStart: false,
                                isEnd: false,
                              ),
                              const SizedBox(height: 8),
                              _buildRouteStop(
                                stopName: 'Green Road',
                                isStart: false,
                                isEnd: false,
                              ),
                              const SizedBox(height: 8),
                              _buildRouteStop(
                                stopName: 'DIU Campus',
                                isStart: false,
                                isEnd: true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Route stats
                  Row(
                    children: [
                      Expanded(
                        child: _buildRouteStat(
                          icon: Icons.access_time_rounded,
                          label: 'Duration',
                          value: '25 min',
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildRouteStat(
                          icon: Icons.location_on_outlined,
                          label: 'Distance',
                          value: '8.5 km',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Route Map Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Colors.black.withOpacity(0.1),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.map_outlined,
                        size: 24,
                        color: Colors.black.withOpacity(0.7),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'Route Map',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF000000),
                          letterSpacing: -0.2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Interactive Map Placeholder
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F9FA),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.black.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    child: Stack(
                      children: [
                        // Map background pattern
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CustomPaint(painter: MapPatternPainter()),
                          ),
                        ),
                        // Map content
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(
                                    0xFF007AFF,
                                  ).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: const Color(
                                      0xFF007AFF,
                                    ).withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: const Text(
                                  'Interactive Map Coming Soon',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF007AFF),
                                    letterSpacing: -0.1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Route markers
                        Positioned(
                          top: 30,
                          left: 40,
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: const Color(0xFF007AFF),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 30,
                          right: 40,
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: const Color(0xFF007AFF),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Map action buttons
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF007AFF).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFF007AFF).withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.my_location_rounded,
                                size: 16,
                                color: const Color(0xFF007AFF),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Live Track',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF007AFF),
                                  letterSpacing: -0.1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF8F9FA),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.black.withOpacity(0.1),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.directions_rounded,
                                size: 16,
                                color: Colors.black.withOpacity(0.6),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Directions',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black.withOpacity(0.7),
                                  letterSpacing: -0.1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildRouteStop({
    required String stopName,
    required bool isStart,
    required bool isEnd,
  }) {
    return Row(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color:
                    isStart || isEnd
                        ? const Color(0xFF007AFF)
                        : Colors.black.withOpacity(0.3),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            if (!isEnd)
              Container(
                width: 2,
                height: 16,
                color: Colors.black.withOpacity(0.2),
              ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            stopName,
            style: TextStyle(
              fontSize: 13,
              fontWeight: isStart || isEnd ? FontWeight.w600 : FontWeight.w400,
              color:
                  isStart || isEnd
                      ? const Color(0xFF007AFF)
                      : Colors.black.withOpacity(0.7),
              letterSpacing: -0.1,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildRouteStat({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, size: 20, color: Colors.black.withOpacity(0.6)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF000000),
              letterSpacing: -0.1,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: Colors.black.withOpacity(0.5),
              letterSpacing: -0.1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStat({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Column(
      children: [
        Icon(icon, size: 16, color: Colors.white.withOpacity(0.9)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Colors.white,
            letterSpacing: -0.1,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: Colors.white.withOpacity(0.8),
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }

  //logout
  void _showLogoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Row(
          children: [
            Icon(Icons.logout_rounded, color: Colors.red, size: 24),
            SizedBox(width: 12),
            Text(
              'Logout',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Color(0xFF000000),
              ),
            ),
          ],
        ),
        content: const Text(
          'Are you sure you want to logout from your account?',
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF666666),
            height: 1.4,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF007AFF),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _performLogout(context);
            },
            child: const Text(
              'Logout',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.red,
              ),
            ),
          ),
        ],
      );
    },
  );
}

Future<void> _performLogout(BuildContext context) async {
  // Show loading indicator
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );

  try {
    // Get instances of both services
    final authService = AuthService();
    final sharedPrefsService = await SharedPreferencesService.getInstance();

    // Always clear SharedPreferences first
    final prefsClearedSuccessfully = await sharedPrefsService.clearLoginState();
    
    // Then perform Firebase logout
    final authResult = await authService.signOut();
    
    // Close loading dialog
    if (context.mounted) {
      Navigator.of(context).pop();
    }

    // Always navigate to login screen regardless of individual operation results
    // This ensures the user is logged out even if one operation fails
    if (context.mounted) {
      // Show appropriate message
      if (authResult.isSuccess && prefsClearedSuccessfully) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 8),
                Text(authResult.message),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.warning, color: Colors.white),
                const SizedBox(width: 8),
                const Text('Logged out, but some data may not have been cleared'),
              ],
            ),
            backgroundColor: Colors.orange,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
      
      // Navigate to role selection screen (or your login screen)
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const RoleSelectionScreen(), // Replace with your login screen
        ),
        (Route<dynamic> route) => false,
      );
    }
    
  } catch (e) {
    print('Logout error: $e');
    
    // Close loading dialog if still open
    if (context.mounted) {
      Navigator.of(context).pop();
    }

    // Even if there's an error, try to clear local state and navigate away
    try {
      final sharedPrefsService = await SharedPreferencesService.getInstance();
      await sharedPrefsService.clearLoginState();
    } catch (clearError) {
      print('Error clearing preferences during error handling: $clearError');
    }

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error, color: Colors.white),
              const SizedBox(width: 8),
              const Text('Logout completed with errors'),
            ],
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      
      // Navigate to role selection screen even if there was an error
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const StudentLoginScreen(),
        ),
        (Route<dynamic> route) => false,
      );
    }
  }
}
}

// Custom painter for map background pattern
class MapPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.black.withOpacity(0.05)
          ..strokeWidth = 0.5
          ..style = PaintingStyle.stroke;

    // Draw grid pattern to simulate map
    final gridSize = 20.0;

    // Vertical lines
    for (double x = 0; x <= size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Horizontal lines
    for (double y = 0; y <= size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    // Draw some random "street" patterns
    final streetPaint =
        Paint()
          ..color = Colors.black.withOpacity(0.08)
          ..strokeWidth = 2.0
          ..style = PaintingStyle.stroke;

    // Horizontal streets
    canvas.drawLine(
      Offset(0, size.height * 0.3),
      Offset(size.width, size.height * 0.3),
      streetPaint,
    );

    canvas.drawLine(
      Offset(0, size.height * 0.7),
      Offset(size.width, size.height * 0.7),
      streetPaint,
    );

    // Vertical streets
    canvas.drawLine(
      Offset(size.width * 0.25, 0),
      Offset(size.width * 0.25, size.height),
      streetPaint,
    );

    canvas.drawLine(
      Offset(size.width * 0.75, 0),
      Offset(size.width * 0.75, size.height),
      streetPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// Custom painter for geometric patterns on transport pass
class GeometricPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final patternPaint =
        Paint()
          ..color = Colors.white.withOpacity(0.1)
          ..strokeWidth = 1.5
          ..style = PaintingStyle.stroke;

    final fillPaint =
        Paint()
          ..color = Colors.white.withOpacity(0.05)
          ..style = PaintingStyle.fill;

    // Create a subtle geometric pattern with circles and lines

    // Large background circles
    final centerX = size.width * 0.8;
    final centerY = size.height * 0.3;

    // Draw concentric circles
    canvas.drawCircle(Offset(centerX, centerY), 80, fillPaint);
    canvas.drawCircle(Offset(centerX, centerY), 80, patternPaint);
    canvas.drawCircle(Offset(centerX, centerY), 60, patternPaint);
    canvas.drawCircle(Offset(centerX, centerY), 40, patternPaint);

    // Add smaller decorative circles
    canvas.drawCircle(
      Offset(size.width * 0.15, size.height * 0.7),
      25,
      patternPaint,
    );

    canvas.drawCircle(
      Offset(size.width * 0.9, size.height * 0.8),
      20,
      patternPaint,
    );

    // Draw intersecting lines for geometric pattern
    final linePaint =
        Paint()
          ..color = Colors.white.withOpacity(0.08)
          ..strokeWidth = 1.0
          ..style = PaintingStyle.stroke;

    // Diagonal lines
    canvas.drawLine(
      Offset(0, size.height * 0.3),
      Offset(size.width * 0.7, 0),
      linePaint,
    );

    canvas.drawLine(
      Offset(size.width * 0.3, size.height),
      Offset(size.width, size.height * 0.4),
      linePaint,
    );

    // Hexagonal pattern in bottom left
    final hexPaint =
        Paint()
          ..color = Colors.white.withOpacity(0.06)
          ..style = PaintingStyle.fill;

    final hexStrokePaint =
        Paint()
          ..color = Colors.white.withOpacity(0.12)
          ..strokeWidth = 1.0
          ..style = PaintingStyle.stroke;

    _drawHexagon(
      canvas,
      Offset(size.width * 0.1, size.height * 0.85),
      15,
      hexPaint,
    );
    _drawHexagon(
      canvas,
      Offset(size.width * 0.1, size.height * 0.85),
      15,
      hexStrokePaint,
    );

    _drawHexagon(
      canvas,
      Offset(size.width * 0.25, size.height * 0.9),
      12,
      hexPaint,
    );
    _drawHexagon(
      canvas,
      Offset(size.width * 0.25, size.height * 0.9),
      12,
      hexStrokePaint,
    );

    // Add some triangular elements
    final trianglePaint =
        Paint()
          ..color = Colors.white.withOpacity(0.08)
          ..style = PaintingStyle.fill;

    _drawTriangle(
      canvas,
      Offset(size.width * 0.85, size.height * 0.15),
      12,
      trianglePaint,
    );
    _drawTriangle(
      canvas,
      Offset(size.width * 0.05, size.height * 0.25),
      8,
      trianglePaint,
    );
  }

  void _drawHexagon(Canvas canvas, Offset center, double radius, Paint paint) {
    final path = Path();
    for (int i = 0; i < 6; i++) {
      final angle = (i * 60) * (3.14159 / 180);
      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  void _drawTriangle(Canvas canvas, Offset center, double size, Paint paint) {
    final path = Path();
    path.moveTo(center.dx, center.dy - size);
    path.lineTo(center.dx - size, center.dy + size);
    path.lineTo(center.dx + size, center.dy + size);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
