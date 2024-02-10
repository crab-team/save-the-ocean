import 'package:flutter/material.dart';
import 'package:save_the_ocean/domain/entities/user.dart';
import 'package:save_the_ocean/screens/menu/widgets/user_ranking_row.dart';

class RankingCard extends StatelessWidget {
  final List<User> users;

  const RankingCard({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ...users.map((user) => UserRankingRow(user: user)).toList(),
      ],
    );
  }
}
