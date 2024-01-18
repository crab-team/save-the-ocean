import 'package:flutter/material.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/core/router.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(TextConstants.appName),
      ),
      body: Container(
        color: Colors.blueGrey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => AppRouter.goToGame(),
                child: const Text('Play'),
              ),
              ElevatedButton(
                onPressed: () => AppRouter.goToSettings(),
                child: const Text('Settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
