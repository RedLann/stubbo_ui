class User {
  final String username;
  final String digest;

//<editor-fold desc="Data Methods">

  const User({
    required this.username,
    required this.digest,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          runtimeType == other.runtimeType &&
          username == other.username &&
          digest == other.digest);

  @override
  int get hashCode => username.hashCode ^ digest.hashCode;

  @override
  String toString() {
    return 'User{' + ' username: $username,' + ' digest: $digest,' + '}';
  }

  User copyWith({
    String? username,
    String? digest,
  }) {
    return User(
      username: username ?? this.username,
      digest: digest ?? this.digest,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': this.username,
      'digest': this.digest,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'] as String,
      digest: map['digest'] as String,
    );
  }

//</editor-fold>
}
