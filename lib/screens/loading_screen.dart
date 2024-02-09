import 'package:flutter/material.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/game.dart';

class LoadingScreen extends StatelessWidget {
  final SaveTheOceanGame game;

  const LoadingScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
