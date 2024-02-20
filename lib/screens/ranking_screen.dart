import 'package:flutter/material.dart';
import 'package:save_the_ocean/core/router.dart';
import 'package:save_the_ocean/screens/ranking/ranking.dart';
import 'package:save_the_ocean/shared/widgets/auto_scale_text.dart';
import 'package:save_the_ocean/shared/widgets/background_menu.dart';
import 'package:save_the_ocean/shared/widgets/screen_container.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundMenu(),
          Center(
            child: ScreenContainer(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Ranking(),
                  const SizedBox(height: 12),
                  TextButton(onPressed: () => AppRouter.back(), child: const AutoScaleText.body("Back")),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
