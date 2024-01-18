import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:save_the_ocean/game.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GameWidget(game: SaveTheOceanGame());
  }
}
