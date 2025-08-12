import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  String? _currentUserId;

  bool get isLoggedIn => _isLoggedIn;
  String? get currentUserId => _currentUserId;

  AuthProvider() {
    _loadAuthState();
  }

  Future<void> _loadAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    _currentUserId = prefs.getString('currentUserId');
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    // Demo login - only allow specific credentials
    if (email == 'demo@skillswap.com' && password == 'password') {
      _isLoggedIn = true;
      _currentUserId = 'demo_user_001';
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('currentUserId', _currentUserId!);
      
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    _isLoggedIn = false;
    _currentUserId = null;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('currentUserId');
    
    notifyListeners();
  }
} 