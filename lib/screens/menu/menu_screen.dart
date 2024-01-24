import 'package:flutter/material.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/core/router.dart';
import 'package:save_the_ocean/screens/menu/widgets/ranking.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(TextConstants.appName),
      ),
      body: Row(
        children: [
          _menu(),
          const Expanded(
            flex: 1,
            child: Ranking(),
          ),
        ],
      ),
    );
  }

  Widget _menu() {
    return Expanded(
      flex: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => AppRouter.goToGame(),
            child: const Text('Play'),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () => AppRouter.goToSettings(),
            child: const Text('Settings'),
          ),
        ],
      ),
    );
  }
}
