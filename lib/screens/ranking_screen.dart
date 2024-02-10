import 'package:flutter/material.dart';
import 'package:save_the_ocean/core/router.dart';
import 'package:save_the_ocean/screens/menu/widgets/ranking.dart';
import 'package:save_the_ocean/screens/menu/widgets/sync_button.dart';
import 'package:save_the_ocean/shared/widgets/background_menu.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundMenu(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Ranking(),
                const SizedBox(height: 24),
                _buildActions(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextButton(onPressed: () => AppRouter.back(), child: const Text("Back")),
        const SizedBox(width: 100),
        const SyncButton(),
      ],
    );
  }
}
