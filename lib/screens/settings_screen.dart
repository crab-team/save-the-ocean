import 'package:flutter/material.dart';
import 'package:save_the_ocean/core/router.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Container(
        color: Colors.blueGrey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => AppRouter.back(),
                child: const Text('Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
