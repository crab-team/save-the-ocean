import 'package:flutter/material.dart';
import 'package:save_the_ocean/domain/entities/user.dart';
import 'package:save_the_ocean/shared/widgets/auto_scale_text.dart';
import 'package:save_the_ocean/utils/score.dart';

class UserRankingRow extends StatelessWidget {
  final int position;
  final User user;
  const UserRankingRow({super.key, required this.user, required this.position});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AutoScaleText.small("$position."),
          const SizedBox(width: 8),
          AutoScaleText.small(user.username),
          const Spacer(),
          AutoScaleText.small(ScoreUtils.getTimeFormat(user.score.toDouble())),
        ],
      ),
    );
  }
}
