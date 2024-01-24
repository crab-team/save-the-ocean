import 'package:flutter/material.dart';
import 'package:save_the_ocean/domain/user.dart';
import 'package:save_the_ocean/utils/score.dart';

class UserRankingRow extends StatelessWidget {
  final User user;
  const UserRankingRow({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            user.username,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          const Spacer(),
          Text(
            user.score.formattedScore(),
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
