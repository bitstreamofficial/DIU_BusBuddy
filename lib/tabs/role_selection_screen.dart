import 'package:flutter/material.dart';
import '../students/student_auth/ui/student_login_screen.dart';
import '../admins/admin_auth/admin_login_screen.dart';
import '../utils/responsive_utils.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.horizontalPadding),
          child:
              context.isLandscape
                  ? _buildLandscapeLayout(context)
                  : _buildPortraitLayout(context),
        ),
      ),
    );
  }

  Widget _buildPortraitLayout(BuildContext context) {
    final logoSize = ResponsiveUtils.getLogoSize(context);
    final appTitleSize = context.responsiveFont(34.0);
    final subtitleSize = context.responsiveFont(17.0);
    final welcomeSize = context.responsiveFont(28.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: context.heightPercent(10)), // 10% of screen height
        // App Icon and Title Section
        Column(
          children: [
            // App logo
            Container(
              width: logoSize,
              height: logoSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(logoSize * 0.22),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF007AFF).withOpacity(0.25),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(logoSize * 0.22),
                child: Image.asset(
                  'assets/logo.png',
                  width: logoSize,
                  height: logoSize,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: context.heightPercent(3)),

            // App name
            Text(
              'DIU Bus Buddy',
              style: TextStyle(
                fontSize: appTitleSize,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF000000),
                letterSpacing: -0.5,
              ),
            ),
            SizedBox(height: context.heightPercent(1)),

            // Subtitle
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.widthPercent(5),
              ),
              child: Text(
                'Your Campus Transportation Companion',
                style: TextStyle(
                  fontSize: subtitleSize,
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withOpacity(0.6),
                  letterSpacing: -0.2,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),

        SizedBox(height: context.heightPercent(10)),

        // Welcome text
        Text(
          'Welcome',
          style: TextStyle(
            fontSize: welcomeSize,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF000000),
            letterSpacing: -0.3,
          ),
        ),
        SizedBox(height: context.heightPercent(1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.widthPercent(5)),
          child: Text(
            'Choose your role to get started',
            style: TextStyle(
              fontSize: subtitleSize,
              fontWeight: FontWeight.w400,
              color: Colors.black.withOpacity(0.6),
              letterSpacing: -0.2,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        SizedBox(height: context.heightPercent(8)),

        // Role selection buttons
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Student button
              _buildRoleButton(
                context: context,
                title: 'Student',
                subtitle: 'Access schedules and track buses',
                icon: Icons.school_outlined,
                onTap: () => _navigateToStudentLogin(context),
                isPrimary: true,
              ),

              SizedBox(height: context.heightPercent(2)),

              // Admin button
              _buildRoleButton(
                context: context,
                title: 'Admin',
                subtitle: 'Manage and monitor schedules',
                icon: Icons.admin_panel_settings_outlined,
                onTap: () => _navigateToAdminLogin(context),
                isPrimary: false,
              ),
            ],
          ),
        ),

        SizedBox(height: context.heightPercent(5)),

        // Footer
        Text(
          '© 2025 Daffodil International University',
          style: TextStyle(
            fontSize: context.isTablet ? 15.0 : 13.0,
            fontWeight: FontWeight.w400,
            color: Colors.black.withOpacity(0.4),
            letterSpacing: -0.1,
          ),
        ),
        SizedBox(height: context.heightPercent(4)),
      ],
    );
  }

  Widget _buildLandscapeLayout(BuildContext context) {
    final logoSize = ResponsiveUtils.getLogoSize(context);
    final appTitleSize = context.responsiveFont(28.0);
    final subtitleSize = context.responsiveFont(15.0);
    final welcomeSize = context.responsiveFont(24.0);

    return Row(
      children: [
        // Left side - Logo and title
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // App logo
              Container(
                width: logoSize,
                height: logoSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(logoSize * 0.22),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF007AFF).withOpacity(0.25),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(logoSize * 0.22),
                  child: Image.asset(
                    'assets/logo.png',
                    width: logoSize,
                    height: logoSize,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: context.heightPercent(3)),

              // App name
              Text(
                'DIU Bus Buddy',
                style: TextStyle(
                  fontSize: appTitleSize,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF000000),
                  letterSpacing: -0.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: context.heightPercent(1.5)),

              // Subtitle
              Text(
                'Your Campus Transportation\nCompanion',
                style: TextStyle(
                  fontSize: subtitleSize,
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withOpacity(0.6),
                  letterSpacing: -0.2,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

        // Right side - Welcome and buttons
        Expanded(
          flex: 1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Welcome text
              Text(
                'Welcome',
                style: TextStyle(
                  fontSize: welcomeSize,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF000000),
                  letterSpacing: -0.3,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: context.heightPercent(1)),
              Text(
                'Choose your role to get started',
                style: TextStyle(
                  fontSize: subtitleSize,
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withOpacity(0.6),
                  letterSpacing: -0.2,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: context.heightPercent(5)),

              // Role selection buttons
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.widthPercent(5),
                ),
                child: Column(
                  children: [
                    // Student button
                    _buildRoleButton(
                      context: context,
                      title: 'Student',
                      subtitle: 'Access schedules and track buses',
                      icon: Icons.school_outlined,
                      onTap: () => _navigateToStudentLogin(context),
                      isPrimary: true,
                    ),

                    SizedBox(height: context.heightPercent(2)),

                    // Admin button
                    _buildRoleButton(
                      context: context,
                      title: 'Admin',
                      subtitle: 'Manage and monitor schedules',
                      icon: Icons.admin_panel_settings_outlined,
                      onTap: () => _navigateToAdminLogin(context),
                      isPrimary: false,
                    ),
                  ],
                ),
              ),

              SizedBox(height: context.heightPercent(5)),

              // Footer
              Text(
                '© 2025 Daffodil International University',
                style: TextStyle(
                  fontSize: context.isTablet ? 15.0 : 13.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black.withOpacity(0.4),
                  letterSpacing: -0.1,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRoleButton({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
    required bool isPrimary,
  }) {
    // Responsive values using our utility class
    final buttonHeight = ResponsiveUtils.getButtonHeight(
      context,
      baseHeight: 88.0,
    );
    final iconSize = context.responsiveIcon(56.0);
    final iconContainerRadius = context.responsiveRadius(14.0);
    final titleFontSize = context.responsiveFont(20.0);
    final subtitleFontSize = context.responsiveFont(15.0);
    final padding = ResponsiveUtils.getButtonPadding(context);

    return Container(
      width: double.infinity,
      height: buttonHeight,
      decoration: BoxDecoration(
        color: isPrimary ? const Color(0xFF007AFF) : Colors.white,
        borderRadius: BorderRadius.circular(context.responsiveRadius(16.0)),
        border:
            isPrimary
                ? null
                : Border.all(color: Colors.black.withOpacity(0.1), width: 1),
        boxShadow: [
          BoxShadow(
            color:
                isPrimary
                    ? const Color(0xFF007AFF).withOpacity(0.2)
                    : Colors.black.withOpacity(0.04),
            blurRadius: isPrimary ? 16 : 8,
            offset: Offset(0, isPrimary ? 4 : 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(context.responsiveRadius(16.0)),
          child: Padding(
            padding: padding,
            child: Row(
              children: [
                // Icon container
                Container(
                  width: iconSize,
                  height: iconSize,
                  decoration: BoxDecoration(
                    color:
                        isPrimary
                            ? Colors.white.withOpacity(0.2)
                            : const Color(0xFF007AFF).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(iconContainerRadius),
                  ),
                  child: Icon(
                    icon,
                    size: iconSize * 0.5,
                    color: isPrimary ? Colors.white : const Color(0xFF007AFF),
                  ),
                ),

                SizedBox(width: context.widthPercent(4)),

                // Text content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: titleFontSize,
                          fontWeight: FontWeight.w600,
                          color:
                              isPrimary
                                  ? Colors.white
                                  : const Color(0xFF000000),
                          letterSpacing: -0.2,
                        ),
                      ),
                      SizedBox(height: context.heightPercent(0.3)),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: subtitleFontSize,
                          fontWeight: FontWeight.w400,
                          color:
                              isPrimary
                                  ? Colors.white.withOpacity(0.8)
                                  : Colors.black.withOpacity(0.6),
                          letterSpacing: -0.1,
                        ),
                      ),
                    ],
                  ),
                ),

                // Arrow icon
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: context.isTablet ? 18 : 16,
                  color:
                      isPrimary
                          ? Colors.white.withOpacity(0.8)
                          : Colors.black.withOpacity(0.4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToStudentLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const StudentLoginScreen()),
    );
  }

  void _navigateToAdminLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AdminLoginScreen()),
    );
  }
}
