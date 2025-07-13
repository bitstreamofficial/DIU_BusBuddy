import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String _isLoggedInKey = 'isLoggedIn';
  static const String _userIdKey = 'userId';
  static const String _userName = 'userName';
  static const String _userEmailKey = 'userEmail';
  static const String _studentIdKey = 'studentId';

  static SharedPreferencesService? _instance;
  static SharedPreferences? _preferences;

  static Future<SharedPreferencesService> getInstance() async {
  _instance ??= SharedPreferencesService._();
  _preferences ??= await SharedPreferences.getInstance();
  return _instance!;
}


  SharedPreferencesService._();

  // Save login state
  Future<bool> saveLoginState({
    required String userId,
    required String email,
    String? studentId,
    String? name,
  }) async {
    try {
      await _preferences!.setBool(_isLoggedInKey, true);
      await _preferences!.setString(_userName, name ?? '');
      await _preferences!.setString(_userIdKey, userId);
      await _preferences!.setString(_userEmailKey, email);
      if (studentId != null) {
        await _preferences!.setString(_studentIdKey, studentId);
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  // Get login state
  bool isLoggedIn() {
    return _preferences!.getBool(_isLoggedInKey) ?? false;
  }

  // Get user ID
  String? getUserId() {
    return _preferences!.getString(_userIdKey);
  }
  // Get user name
  String? getUserName() {
    return _preferences!.getString(_userName);
  }

  // Get user email
  String? getUserEmail() {
    return _preferences!.getString(_userEmailKey);
  }

  // Get student ID
  String? getStudentId() {
    return _preferences!.getString(_studentIdKey);
  }

  // Clear login state (logout)
  Future<bool> clearLoginState() async {
    try {
      await _preferences!.remove(_isLoggedInKey);
      await _preferences!.remove(_userIdKey);
      await _preferences!.remove(_userName);
      await _preferences!.remove(_userEmailKey);
      await _preferences!.remove(_studentIdKey);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Clear all preferences
  Future<bool> clearAllPreferences() async {
    try {
      await _preferences!.clear();
      return true;
    } catch (e) {
      return false;
    }
  }
}