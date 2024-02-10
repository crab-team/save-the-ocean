class User {
  final String username;
  final double score;

  const User({required this.username, required this.score});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'],
      score: map['score'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'score': score,
    };
  }

  User copyWith({
    String? username,
    double? score,
  }) {
    return User(
      username: username ?? this.username,
      score: score ?? this.score,
    );
  }

  @override
  String toString() => 'User(username: $username, score: $score)';
}
