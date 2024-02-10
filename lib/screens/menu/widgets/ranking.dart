import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/core/page_status.dart';
import 'package:save_the_ocean/screens/menu/controllers/ranking_controller.dart';
import 'package:save_the_ocean/screens/menu/controllers/ranking_state.dart';
import 'package:save_the_ocean/screens/menu/widgets/ranking_card.dart';

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
        Text(
          "Ranking",
          style: Theme.of(context)
              .textTheme
              .displayLarge!
              .copyWith(color: Theme.of(context).colorScheme.background, fontSize: 51),
        ),
        Image.asset("images/${ImageAssets.menuBottomLine}", width: 500),
        const SizedBox(height: 24),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          width: 500,
          child: Consumer<RankingController>(
            builder: (context, controller, child) {
              RankingState currentState = controller.currentState;
              return _rankingContent(currentState);
            },
          ),
        ),
        const SizedBox(height: 24),
        Image.asset("images/${ImageAssets.menuLine}", width: 500),
      ],
    );
  }

  Widget _rankingContent(RankingState state) {
    switch (state.status) {
      case PageStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case PageStatus.error:
        return const Center(child: Text('An error has ocurred'));
      case PageStatus.data:
        return RankingCard(users: state.users);
    }
  }
}
