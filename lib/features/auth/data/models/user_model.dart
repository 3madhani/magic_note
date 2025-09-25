import '../../domian/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required super.id,
    required super.email,
    required super.name,
    required super.createdAt,
    required super.lastLoginAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      createdAt: DateTime.parse(json['createdAt']),
      lastLoginAt: DateTime.parse(json['lastLoginAt']),
    );
  }

  @override
  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    DateTime? createdAt,
    DateTime? lastLoginAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'createdAt': createdAt.toIso8601String(),
      'lastLoginAt': lastLoginAt.toIso8601String(),
    };
  }

  factory UserModel.fromEntity(User user) {
    return UserModel(
      id: user.id,
      email: user.email,
      name: user.name,
      createdAt: user.createdAt,
      lastLoginAt: user.lastLoginAt,
    );
  }

  User toEntity() {
    return User(
      id: id,
      email: email,
      name: name,
      createdAt: createdAt,
      lastLoginAt: lastLoginAt,
    );
  }

  static UserModel createDemo() {
    final now = DateTime.now();
    return UserModel(
      id: 'demo_user',
      email: 'demo@magicnotes.com',
      name: 'Demo User',
      createdAt: now,
      lastLoginAt: now,
    );
  }
}
