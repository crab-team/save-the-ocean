import 'dart:ui';

import 'package:flame_rive/flame_rive.dart';
import 'package:flutter/material.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/core/router.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/${ImageAssets.backgroundMenu}',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Image.asset(
            'assets/images/${ImageAssets.foregroundTopWall}',
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          Positioned(
            left: -10,
            bottom: 0,
            width: 140,
            child: Image.asset(
              'assets/images/${ImageAssets.foregroundLeftWall}',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            right: -5,
            bottom: 0,
            width: 140,
            child: Image.asset('assets/images/${ImageAssets.foregroundRightWall}'),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 120,
            child: Image.asset(
              'assets/images/${ImageAssets.foregroundBottom}',
            ),
          ),
          const RiveAnimation.asset(
            AnimationAssets.riv,
            artboard: ArtboardNames.lighting,
          ),
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(color: Colors.black.withOpacity(0.3)),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 1),
              _buildMenu(context),
              const Spacer(flex: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: _buildMtcLogo(context)),
                  Expanded(child: _buildMarquee(context)),
                  Expanded(child: _buildVersion(context)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenu(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Text(
                "Save the ocean",
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(color: Theme.of(context).colorScheme.background, fontSize: 51),
              ),
              Text(
                "Save the ocean",
                style: Theme.of(context).textTheme.displayLarge!.copyWith(color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
          Image.asset("images/${ImageAssets.menuBottomLine}", width: 500),
          const SizedBox(height: 24),
          TextButton(
            onPressed: () => AppRouter.goToGame(),
            child: Text(
              'PLAY',
              style: Theme.of(context).textTheme.displayMedium!,
            ),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () => AppRouter.goToSettings(),
            child: Text(
              'RANKING',
              style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white),
            ),
          ),
          const SizedBox(height: 24),
          Image.asset("images/${ImageAssets.menuLine}", width: 500),
        ],
      ),
    );
  }

  Widget _buildMarquee(BuildContext context) {
    return Card(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "El plástico es la fracción más grande, más dañina y más persistente de los desechos marinos",
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildMtcLogo(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/${ImageAssets.mtcLogoWhite}',
        width: 100,
        height: 100,
      ),
    );
  }

  Widget _buildVersion(BuildContext context) {
    return Center(
      child: Text(
        'Version 1.0.0',
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
