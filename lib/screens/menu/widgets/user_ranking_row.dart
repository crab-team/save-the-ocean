import 'package:flutter/material.dart';
import 'package:save_the_ocean/domain/entities/user.dart';
import 'package:save_the_ocean/utils/score.dart';

class UserRankingRow extends StatelessWidget {
  final User user;
  const UserRankingRow({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            user.username,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          const Spacer(),
          Text(
            ScoreUtils.getTimeFormat(user.score.toDouble()),
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
