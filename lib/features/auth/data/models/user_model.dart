/// Data model representing an authenticated user.
///
/// This is an immutable value object used by the authentication layer
/// to hold the current user's profile information.
library;

/// An immutable data class that models a user profile.
///
/// Example usage:
/// ```dart
/// const user = UserModel(
///   name: 'Jane Doe',
///   email: 'jane@example.com',
/// );
/// ```
class UserModel {
  /// Creates a new [UserModel].
  ///
  /// [name] and [email] are required. [avatarPath] is optional and
  /// may point to a local asset or a remote URL.
  const UserModel({
    required this.name,
    required this.email,
    this.avatarPath,
  });

  /// Constructs a [UserModel] from a JSON map.
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] as String,
      email: json['email'] as String,
      avatarPath: json['avatarPath'] as String?,
    );
  }

  /// The user's display name.
  final String name;

  /// The user's email address.
  final String email;

  /// Optional path to the user's avatar image.
  ///
  /// Can be a local asset path or a remote URL.
  final String? avatarPath;

  /// Returns a new [UserModel] with the specified fields replaced.
  UserModel copyWith({
    String? name,
    String? email,
    String? avatarPath,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      avatarPath: avatarPath ?? this.avatarPath,
    );
  }

  /// Serialises this user to a JSON-compatible map.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'avatarPath': avatarPath,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UserModel &&
        other.name == name &&
        other.email == email &&
        other.avatarPath == avatarPath;
  }

  @override
  int get hashCode => Object.hash(name, email, avatarPath);

  @override
  String toString() => 'UserModel(name: $name, email: $email)';
}
