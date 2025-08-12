import 'package:uuid/uuid.dart';

class SkillPost {
  final String id;
  final String userId;
  final String userName;
  final String skillOffered;
  final String skillWanted;
  final String? availability;
  final DateTime createdAt;

  SkillPost({
    String? id,
    required this.userId,
    required this.userName,
    required this.skillOffered,
    required this.skillWanted,
    this.availability,
    DateTime? createdAt,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'skillOffered': skillOffered,
      'skillWanted': skillWanted,
      'availability': availability,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory SkillPost.fromJson(Map<String, dynamic> json) {
    return SkillPost(
      id: json['id'],
      userId: json['userId'],
      userName: json['userName'],
      skillOffered: json['skillOffered'],
      skillWanted: json['skillWanted'],
      availability: json['availability'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  SkillPost copyWith({
    String? id,
    String? userId,
    String? userName,
    String? skillOffered,
    String? skillWanted,
    String? availability,
    DateTime? createdAt,
  }) {
    return SkillPost(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      skillOffered: skillOffered ?? this.skillOffered,
      skillWanted: skillWanted ?? this.skillWanted,
      availability: availability ?? this.availability,
      createdAt: createdAt ?? this.createdAt,
    );
  }
} 