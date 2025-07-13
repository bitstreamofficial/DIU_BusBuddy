import 'package:diu_busbuddy/tabs/role_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:diu_busbuddy/students/student_auth/ui/student_dashboard_screen.dart';
import 'package:diu_busbuddy/students/student_auth/backend/shared_preferences_service.dart';
import 'package:diu_busbuddy/students/student_auth/backend/auth_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginState();
  }

  Future<void> _checkLoginState() async {
    // Add a small delay for splash effect
    await Future.delayed(const Duration(milliseconds: 1500));
    
    try {
      final prefsService = await SharedPreferencesService.getInstance();
      final authService = AuthService();
      
      // Check both SharedPreferences and Firebase authentication
      final isLoggedInLocally = prefsService.isLoggedIn();
      final isLoggedInFirebase = authService.isSignedIn;
      
      print('Local login state: $isLoggedInLocally');
      print('Firebase login state: $isLoggedInFirebase');
      
      if (mounted) {
        // Both must be true for user to be considered logged in
        if (isLoggedInLocally && isLoggedInFirebase) {
          // Double-check that Firebase user is not null and email is verified
          final currentUser = authService.currentUser;
          if (currentUser != null && currentUser.emailVerified) {
            // User is properly authenticated, navigate to dashboard
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const StudentDashboardScreen(),
              ),
            );
          } else {
            // Firebase user is null or email not verified, clear local state
            await prefsService.clearLoginState();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const RoleSelectionScreen(),
              ),
            );
          }
        } else {
          // Either local or Firebase state is false, ensure both are cleared
          if (isLoggedInLocally && !isLoggedInFirebase) {
            // Clear local state if Firebase is not authenticated
            await prefsService.clearLoginState();
          }
          
          // Navigate to role selection
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const RoleSelectionScreen(),
            ),
          );
        }
      }
    } catch (e) {
      print('Error during login check: $e');
      // If there's an error, clear local state and default to role selection
      try {
        final prefsService = await SharedPreferencesService.getInstance();
        await prefsService.clearLoginState();
      } catch (clearError) {
        print('Error clearing preferences: $clearError');
      }
      
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const RoleSelectionScreen(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1976D2),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Icon
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(
                Icons.directions_bus_rounded,
                size: 50,
                color: Color(0xFF1976D2),
              ),
            ),
            
            const SizedBox(height: 30),
            
            // App Name
            const Text(
              'DIU Bus Buddy',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),
            
            const SizedBox(height: 10),
            
            // Tagline
            Text(
              'Your Smart Bus Companion',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withOpacity(0.9),
                letterSpacing: 0.5,
              ),
            ),
            
            const SizedBox(height: 50),
            
            // Loading indicator
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 3,
            ),
          ],
        ),
      ),
    );
  }
}