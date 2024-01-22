import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_the_ocean/core/page_status.dart';
import 'package:save_the_ocean/domain/user.dart';
import 'package:save_the_ocean/screens/menu/controllers/ranking_controller.dart';
import 'package:save_the_ocean/screens/menu/controllers/ranking_state.dart';
import 'package:save_the_ocean/utils/score.dart';

class Ranking extends StatefulWidget {
  const Ranking({super.key});

  @override
  State<StatefulWidget> createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
  @override
  void initState() {
    super.initState();

    Provider.of<RankingController>(context, listen: false).fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RankingController>(
      builder: (context, controller, child) {
        RankingState currentstate = controller.currentState;
        return Card(
          margin: const EdgeInsets.only(top: 16, bottom: 24, right: 24),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: _rankingCardBody(currentstate),
          ),
        );
      },
    );
  }

  Widget _rankingCardBody(RankingState state) {
    switch (state.status) {
      case PageStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case PageStatus.error:
        return const Center(child: Text('An error has ocurred'));
      case PageStatus.data:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Ranking (Recycle time)'),
            const SizedBox(height: 16),
            ...state.users.map((user) => _userScoreRow(user)).toList(),
          ],
        );
    }
  }

  Widget _userScoreRow(User user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(user.username),
          const Spacer(),
          Text(user.score.formattedScore()),
        ],
      ),
    );
  }
}
