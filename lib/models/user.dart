class User {
  final String id;
  final String name;
  final String email;
  final String avatar;
  final String role;
  final DateTime joinDate;
  final bool isVerified;
  final String? password; // Optional for backward compatibility

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
    required this.role,
    required this.joinDate,
    required this.isVerified,
    this.password, // Optional password for simple testing
  });

  // Convert User to Map for storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar': avatar,
      'role': role,
      'joinDate': joinDate.toIso8601String(),
      'isVerified': isVerified,
      'password': password, // Include password for simple testing
    };
  }

  // Create User from Map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      avatar: map['avatar'] ?? 'assets/images/homescreen.png',
      role: map['role'] ?? '',
      joinDate: DateTime.tryParse(map['joinDate'] ?? '') ?? DateTime.now(),
      isVerified: map['isVerified'] ?? false,
      password: map['password'], // Include password for simple testing
    );
  }

  // Create a copy with updated fields
  User copyWith({
    String? id,
    String? name,
    String? email,
    String? avatar,
    String? role,
    DateTime? joinDate,
    bool? isVerified,
    String? password,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      role: role ?? this.role,
      joinDate: joinDate ?? this.joinDate,
      isVerified: isVerified ?? this.isVerified,
      password: password ?? this.password,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User &&
        other.id == id &&
        other.email == email;
  }

  @override
  int get hashCode => id.hashCode ^ email.hashCode;

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, role: $role)';
  }
}

// Legacy support - keeping for backward compatibility
List<User> registeredUsers = [];
