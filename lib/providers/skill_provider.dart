import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/skill_post.dart';
import '../models/match.dart';
import 'package:uuid/uuid.dart';

class SkillProvider with ChangeNotifier {
  List<SkillPost> _skillPosts = [];
  List<Match> _matches = [];
  String? _currentUserId;

  List<SkillPost> get skillPosts => _skillPosts;
  List<Match> get matches => _matches;

  SkillProvider() {
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    _currentUserId = prefs.getString('currentUserId');
    
    // Load skill posts
    final postsJson = prefs.getString('skillPosts');
    if (postsJson != null) {
      final List<dynamic> postsList = json.decode(postsJson);
      _skillPosts = postsList.map((json) => SkillPost.fromJson(json)).toList();
    } else {
      // Initialize with demo posts
      _skillPosts = [
        SkillPost(
          userId: 'demo_user_001',
          userName: 'Demo User',
          skillOffered: 'JavaScript',
          skillWanted: 'Python',
          availability: 'Weekends',
        ),
        SkillPost(
          userId: 'user_002',
          userName: 'Sarah Chen',
          skillOffered: 'Python',
          skillWanted: 'JavaScript',
          availability: 'Evenings',
        ),
        SkillPost(
          userId: 'user_003',
          userName: 'Mike Johnson',
          skillOffered: 'Photography',
          skillWanted: 'Cooking',
          availability: 'Flexible',
        ),
      ];
      await _saveSkillPosts();
    }
    
    // Load matches
    final matchesJson = prefs.getString('matches');
    if (matchesJson != null) {
      final List<dynamic> matchesList = json.decode(matchesJson);
      _matches = matchesList.map((json) => Match.fromJson(json)).toList();
    }
    
    notifyListeners();
  }

  Future<void> _saveSkillPosts() async {
    final prefs = await SharedPreferences.getInstance();
    final postsJson = json.encode(_skillPosts.map((post) => post.toJson()).toList());
    await prefs.setString('skillPosts', postsJson);
  }

  Future<void> _saveMatches() async {
    final prefs = await SharedPreferences.getInstance();
    final matchesJson = json.encode(_matches.map((match) => match.toJson()).toList());
    await prefs.setString('matches', matchesJson);
  }

  Future<void> addSkillPost({
    required String skillOffered,
    required String skillWanted,
    String? availability,
    required String userName,
  }) async {
    if (_currentUserId != null) {
      final post = SkillPost(
        userId: _currentUserId!,
        userName: userName,
        skillOffered: skillOffered,
        skillWanted: skillWanted,
        availability: availability,
      );
      
      _skillPosts.add(post);
      await _saveSkillPosts();
      await _findMatches();
      notifyListeners();
    }
  }

  Future<void> deleteSkillPost(String postId) async {
    _skillPosts.removeWhere((post) => post.id == postId);
    await _saveSkillPosts();
    await _findMatches();
    notifyListeners();
  }

  Future<void> _findMatches() async {
    _matches.clear();
    
    for (int i = 0; i < _skillPosts.length; i++) {
      for (int j = i + 1; j < _skillPosts.length; j++) {
        final post1 = _skillPosts[i];
        final post2 = _skillPosts[j];
        
        // Check if posts are from different users
        if (post1.userId != post2.userId) {
          // Check if there's a match
          if (post1.skillOffered == post2.skillWanted && 
              post2.skillOffered == post1.skillWanted) {
            
            final match = Match(
              id: const Uuid().v4(),
              user1Id: post1.userId,
              user1Name: post1.userName,
              user1SkillOffered: post1.skillOffered,
              user1SkillWanted: post1.skillWanted,
              user2Id: post2.userId,
              user2Name: post2.userName,
              user2SkillOffered: post2.skillOffered,
              user2SkillWanted: post2.skillWanted,
              matchedAt: DateTime.now(),
            );
            
            _matches.add(match);
          }
        }
      }
    }
    
    await _saveMatches();
  }

  List<SkillPost> getPostsByUser(String userId) {
    return _skillPosts.where((post) => post.userId == userId).toList();
  }

  List<SkillPost> filterPosts({
    String? skillOffered,
    String? skillWanted,
  }) {
    return _skillPosts.where((post) {
      bool matches = true;
      
      if (skillOffered != null && skillOffered.isNotEmpty) {
        matches = matches && post.skillOffered.toLowerCase().contains(skillOffered.toLowerCase());
      }
      
      if (skillWanted != null && skillWanted.isNotEmpty) {
        matches = matches && post.skillWanted.toLowerCase().contains(skillWanted.toLowerCase());
      }
      
      return matches;
    }).toList();
  }

  List<Match> getMatchesForUser(String userId) {
    return _matches.where((match) => 
      match.user1Id == userId || match.user2Id == userId
    ).toList();
  }

  bool isPostMatched(SkillPost post) {
    return _matches.any((match) => 
      (match.user1Id == post.userId && match.user1SkillOffered == post.skillOffered) ||
      (match.user2Id == post.userId && match.user2SkillOffered == post.skillOffered)
    );
  }
} 