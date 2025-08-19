class Match {
  final String id;
  final String user1Id;
  final String user1Name;
  final String user1SkillOffered;
  final String user1SkillWanted;
  final String user2Id;
  final String user2Name;
  final String user2SkillOffered;
  final String user2SkillWanted;
  final DateTime matchedAt;

  Match({
    required this.id,
    required this.user1Id,
    required this.user1Name,
    required this.user1SkillOffered,
    required this.user1SkillWanted,
    required this.user2Id,
    required this.user2Name,
    required this.user2SkillOffered,
    required this.user2SkillWanted,
    required this.matchedAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user1Id': user1Id,
      'user1Name': user1Name,
      'user1SkillOffered': user1SkillOffered,
      'user1SkillWanted': user1SkillWanted,
      'user2Id': user2Id,
      'user2Name': user2Name,
      'user2SkillOffered': user2SkillOffered,
      'user2SkillWanted': user2SkillWanted,
      'matchedAt': matchedAt.toIso8601String(),
    };
  }

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      id: json['id'],
      user1Id: json['user1Id'],
      user1Name: json['user1Name'],
      user1SkillOffered: json['user1SkillOffered'],
      user1SkillWanted: json['user1SkillWanted'],
      user2Id: json['user2Id'],
      user2Name: json['user2Name'],
      user2SkillOffered: json['user2SkillOffered'],
      user2SkillWanted: json['user2SkillWanted'],
      matchedAt: DateTime.parse(json['matchedAt']),
    );
  }
} 