import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_the_ocean/screens/menu/controllers/ranking_controller.dart';

class SyncButton extends StatelessWidget {
  const SyncButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: () => _refreshRanking(context), child: const Text("Sync"));
  }

  void _refreshRanking(BuildContext context) {
    Provider.of<RankingController>(context, listen: false).fetch();
  }
}
