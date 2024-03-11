import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/core/page_status.dart';
import 'package:save_the_ocean/controllers/ranking/ranking_controller.dart';
import 'package:save_the_ocean/controllers/ranking/ranking_state.dart';
import 'package:save_the_ocean/screens/ranking/ranking_card.dart';
import 'package:save_the_ocean/shared/widgets/auto_scale_text.dart';
import 'package:save_the_ocean/shared/widgets/loading.dart';

class Ranking extends StatefulWidget {
  const Ranking({super.key});

  @override
  State<StatefulWidget> createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async => await Provider.of<RankingController>(context, listen: false).fetch());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const AutoScaleText.title("Ranking"),
        Image.asset("assets/images/${ImageAssets.menuBottomLine}"),
        const SizedBox(height: 24),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: Consumer<RankingController>(
            builder: (context, controller, child) {
              RankingState currentState = controller.currentState;
              return _rankingContent(currentState);
            },
          ),
        ),
        const SizedBox(height: 24),
        Image.asset("assets/images/${ImageAssets.menuLine}"),
      ],
    );
  }

  Widget _rankingContent(RankingState state) {
    switch (state.status) {
      case PageStatus.loading:
        return const Center(child: Loading());
      case PageStatus.error:
        return const Center(child: Text('An error has ocurred'));
      case PageStatus.data:
        return RankingCard(users: state.users);
    }
  }
}
