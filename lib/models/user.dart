class User {
  final String id;
  final String name;
  final String email;
  final String location;
  final String bio;
  final List<String> skillsOffered;
  final List<String> skillsWanted;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.location,
    required this.bio,
    required this.skillsOffered,
    required this.skillsWanted,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'location': location,
      'bio': bio,
      'skillsOffered': skillsOffered,
      'skillsWanted': skillsWanted,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      location: json['location'],
      bio: json['bio'],
      skillsOffered: List<String>.from(json['skillsOffered']),
      skillsWanted: List<String>.from(json['skillsWanted']),
    );
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? location,
    String? bio,
    List<String>? skillsOffered,
    List<String>? skillsWanted,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      location: location ?? this.location,
      bio: bio ?? this.bio,
      skillsOffered: skillsOffered ?? this.skillsOffered,
      skillsWanted: skillsWanted ?? this.skillsWanted,
    );
  }
} 