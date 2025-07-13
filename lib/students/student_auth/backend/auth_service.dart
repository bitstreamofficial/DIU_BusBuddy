import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Get user stream
  Stream<User?> get userStream => _auth.authStateChanges();

  // Check if user is signed in
  bool get isSignedIn => _auth.currentUser != null;

  // Sign up with email and password
  Future<AuthResult> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String studentId,
    required String name,
  }) async {
    try {
      // Create user with email and password
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        // Store additional user data in Firestore
        await _createUserDocument(user, studentId, name);
        
        // Send email verification
        await user.sendEmailVerification();
        
        return AuthResult.success(
          user: user,
          message: 'Account created successfully! Please check your email for verification.',
        );
      } else {
        return AuthResult.failure(message: 'Failed to create account');
      }
    } on FirebaseAuthException catch (e) {
      return AuthResult.failure(message: _getAuthErrorMessage(e));
    } catch (e) {
      debugPrint('SignUp Error: $e');
      return AuthResult.failure(message: 'An unexpected error occurred');
    }
  }

  // Sign in with email and password
  Future<AuthResult> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        // Check if email is verified
        if (!user.emailVerified) {
          return AuthResult.failure(
            message: 'Please verify your email before signing in',
          );
        }

        return AuthResult.success(
          user: user,
          message: 'Signed in successfully!',
        );
      } else {
        return AuthResult.failure(message: 'Failed to sign in');
      }
    } on FirebaseAuthException catch (e) {
      return AuthResult.failure(message: _getAuthErrorMessage(e));
    } catch (e) {
      debugPrint('SignIn Error: $e');
      return AuthResult.failure(message: 'An unexpected error occurred');
    }
  }

  // Sign out
  Future<AuthResult> signOut() async {
    try {
      await _auth.signOut();
      return AuthResult.success(message: 'Signed out successfully');
    } catch (e) {
      debugPrint('SignOut Error: $e');
      return AuthResult.failure(message: 'Failed to sign out');
    }
  }

  // Send password reset email
  Future<AuthResult> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return AuthResult.success(
        message: 'Password reset email sent. Please check your inbox.',
      );
    } on FirebaseAuthException catch (e) {
      return AuthResult.failure(message: _getAuthErrorMessage(e));
    } catch (e) {
      debugPrint('Password Reset Error: $e');
      return AuthResult.failure(message: 'Failed to send password reset email');
    }
  }

  // Resend email verification
  Future<AuthResult> resendEmailVerification() async {
    try {
      User? user = _auth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        return AuthResult.success(
          message: 'Verification email sent. Please check your inbox.',
        );
      } else {
        return AuthResult.failure(message: 'No user found or email already verified');
      }
    } catch (e) {
      debugPrint('Resend Verification Error: $e');
      return AuthResult.failure(message: 'Failed to send verification email');
    }
  }

  // Get user data from Firestore
  Future<Map<String, dynamic>?> getUserData() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot doc = await _firestore
            .collection('users')
            .doc(user.uid)
            .get();
        
        if (doc.exists) {
          return doc.data() as Map<String, dynamic>;
        }
      }
      return null;
    } catch (e) {
      debugPrint('Get User Data Error: $e');
      return null;
    }
  }

  // Update user data in Firestore
  Future<AuthResult> updateUserData(Map<String, dynamic> data) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore
            .collection('users')
            .doc(user.uid)
            .update(data);
        
        return AuthResult.success(message: 'Profile updated successfully');
      } else {
        return AuthResult.failure(message: 'No user found');
      }
    } catch (e) {
      debugPrint('Update User Data Error: $e');
      return AuthResult.failure(message: 'Failed to update profile');
    }
  }

  // Update password
  Future<AuthResult> updatePassword(String newPassword) async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.updatePassword(newPassword);
        return AuthResult.success(message: 'Password updated successfully');
      } else {
        return AuthResult.failure(message: 'No user found');
      }
    } on FirebaseAuthException catch (e) {
      return AuthResult.failure(message: _getAuthErrorMessage(e));
    } catch (e) {
      debugPrint('Update Password Error: $e');
      return AuthResult.failure(message: 'Failed to update password');
    }
  }

  // Delete user account
  Future<AuthResult> deleteAccount() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        // Delete user document from Firestore
        await _firestore.collection('users').doc(user.uid).delete();
        
        // Delete user account
        await user.delete();
        
        return AuthResult.success(message: 'Account deleted successfully');
      } else {
        return AuthResult.failure(message: 'No user found');
      }
    } on FirebaseAuthException catch (e) {
      return AuthResult.failure(message: _getAuthErrorMessage(e));
    } catch (e) {
      debugPrint('Delete Account Error: $e');
      return AuthResult.failure(message: 'Failed to delete account');
    }
  }

  // Create user document in Firestore
  Future<void> _createUserDocument(User user, String studentId,String name) async {
    try {
      await _firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'name': name,
        'email': user.email,
        'studentId': studentId,
        'createdAt': FieldValue.serverTimestamp(),
        'lastSignIn': FieldValue.serverTimestamp(),
        'isActive': true,
        'emailVerified': user.emailVerified,
      });
    } catch (e) {
      debugPrint('Create User Document Error: $e');
      rethrow;
    }
  }

  // Get auth error message
  String _getAuthErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email address';
      case 'wrong-password':
        return 'Wrong password provided';
      case 'email-already-in-use':
        return 'An account already exists with this email';
      case 'invalid-email':
        return 'Invalid email address';
      case 'weak-password':
        return 'Password is too weak';
      case 'user-disabled':
        return 'This user account has been disabled';
      case 'too-many-requests':
        return 'Too many failed attempts. Please try again later';
      case 'operation-not-allowed':
        return 'Sign in method not allowed';
      case 'requires-recent-login':
        return 'Please sign in again to continue';
      case 'invalid-credential':
        return 'Invalid credentials provided';
      default:
        return e.message ?? 'An authentication error occurred';
    }
  }
}

// Auth result class
class AuthResult {
  final bool isSuccess;
  final String message;
  final User? user;

  AuthResult._({
    required this.isSuccess,
    required this.message,
    this.user,
  });

  factory AuthResult.success({
    String? message,
    User? user,
  }) {
    return AuthResult._(
      isSuccess: true,
      message: message ?? 'Success',
      user: user,
    );
  }

  factory AuthResult.failure({
    required String message,
  }) {
    return AuthResult._(
      isSuccess: false,
      message: message,
    );
  }
}

// User data model
class UserData {
  final String uid;
  final String name;
  final String email;
  final String studentId;
  final DateTime createdAt;
  final DateTime lastSignIn;
  final bool isActive;
  final bool emailVerified;

  UserData({
    required this.uid,
    required this.name,
    required this.email,
    required this.studentId,
    required this.createdAt,
    required this.lastSignIn,
    required this.isActive,
    required this.emailVerified,
  });

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      studentId: map['studentId'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      lastSignIn: (map['lastSignIn'] as Timestamp).toDate(),
      isActive: map['isActive'] ?? false,
      emailVerified: map['emailVerified'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'studentId': studentId,
      'createdAt': Timestamp.fromDate(createdAt),
      'lastSignIn': Timestamp.fromDate(lastSignIn),
      'isActive': isActive,
      'emailVerified': emailVerified,
    };
  }
}