import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_the_ocean/domain/user.dart';
import 'package:save_the_ocean/screens/menu/controllers/ranking_controller.dart';
import 'package:save_the_ocean/screens/menu/widgets/user_ranking_row.dart';

class RankingCard extends StatelessWidget {
  final List<User> users;

  const RankingCard({super.key, required this.users});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                'Ranking (Recycle time)',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              IconButton(onPressed: () => _refreshRanking(context), icon: const Icon(Icons.refresh)),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ...users.map((user) => UserRankingRow(user: user)).toList(),
      ],
    );
  }

  void _refreshRanking(BuildContext context) {
    Provider.of<RankingController>(context, listen: false).fetch();
  }
}
