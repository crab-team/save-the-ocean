class User {
  final String username;
  final int score;

  const User({required this.username, required this.score});

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      username: map['username'],
      score: map['score'],
    );
  }
}
