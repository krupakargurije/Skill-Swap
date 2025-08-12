import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  User? _currentUser;
  List<User> _allUsers = [];

  User? get currentUser => _currentUser;
  List<User> get allUsers => _allUsers;

  UserProvider() {
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString('users');
    
    if (usersJson != null) {
      final List<dynamic> usersList = json.decode(usersJson);
      _allUsers = usersList.map((json) => User.fromJson(json)).toList();
    } else {
      // Initialize with demo user
      _currentUser = User(
        id: 'demo_user_001',
        name: 'Demo User',
        email: 'demo@skillswap.com',
        location: 'San Francisco, CA',
        bio: 'Passionate about learning and sharing skills!',
        skillsOffered: ['JavaScript', 'Cooking', 'Guitar'],
        skillsWanted: ['Python', 'Photography', 'Spanish'],
      );
      _allUsers = [_currentUser!];
      await _saveUsers();
    }
    
    // Set current user if logged in
    final currentUserId = prefs.getString('currentUserId');
    if (currentUserId != null) {
      _currentUser = _allUsers.firstWhere(
        (user) => user.id == currentUserId,
        orElse: () => _currentUser!,
      );
    }
    
    notifyListeners();
  }

  Future<void> _saveUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = json.encode(_allUsers.map((user) => user.toJson()).toList());
    await prefs.setString('users', usersJson);
  }

  Future<void> updateUserProfile({
    String? name,
    String? location,
    String? bio,
    List<String>? skillsOffered,
    List<String>? skillsWanted,
  }) async {
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(
        name: name,
        location: location,
        bio: bio,
        skillsOffered: skillsOffered,
        skillsWanted: skillsWanted,
      );
      
      // Update in all users list
      final index = _allUsers.indexWhere((user) => user.id == _currentUser!.id);
      if (index != -1) {
        _allUsers[index] = _currentUser!;
      }
      
      await _saveUsers();
      notifyListeners();
    }
  }

  User? getUserById(String userId) {
    try {
      return _allUsers.firstWhere((user) => user.id == userId);
    } catch (e) {
      return null;
    }
  }
} 