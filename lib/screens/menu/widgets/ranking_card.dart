import 'package:flutter/material.dart';
import 'package:save_the_ocean/domain/user.dart';
import 'package:save_the_ocean/screens/menu/widgets/user_ranking_row.dart';

class RankingCard extends StatelessWidget {
  final List<User> users;

  const RankingCard({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 16),
        const Text(
          'Ranking (Recycle time)',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        ...users.map((user) => UserRankingRow(user: user)).toList(),
      ],
    );
  }
}
