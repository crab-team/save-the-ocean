import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_the_ocean/core/page_status.dart';
import 'package:save_the_ocean/screens/menu/controllers/ranking_controller.dart';
import 'package:save_the_ocean/screens/menu/controllers/ranking_state.dart';

class SyncButton extends StatelessWidget {
  const SyncButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RankingController>(builder: (context, controller, _) {
      RankingState currentState = controller.currentState;
      switch (currentState.status) {
        case PageStatus.loading:
          return const CircularProgressIndicator();
        case PageStatus.error:
          return TextButton(onPressed: () => _refreshRanking(context), child: const Text("Sync"));
        case PageStatus.data:
          return TextButton(onPressed: () => _refreshRanking(context), child: const Text("Sync"));
      }
    });
  }

  void _refreshRanking(BuildContext context) {
    Provider.of<RankingController>(context, listen: false).fetch();
  }
}
