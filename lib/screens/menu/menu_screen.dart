import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/controllers/users/user_controller.dart';
import 'package:save_the_ocean/controllers/users/user_state.dart';
import 'package:save_the_ocean/core/router.dart';
import 'package:save_the_ocean/screens/menu/widgets/dialogs/welcome_dialog.dart';
import 'package:save_the_ocean/screens/menu/widgets/username_text.dart';
import 'package:save_the_ocean/shared/widgets/auto_scale_text.dart';
import 'package:save_the_ocean/shared/widgets/background_menu.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async => await Provider.of<UserController>(context, listen: false).fetch());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundMenu(),
          const Positioned(
            top: 10,
            left: 10,
            child: UsernameText(),
          ),
          Consumer<UserController>(
            builder: (context, controller, child) {
              if (controller.currentState.status == UserStatus.noUsernameLocally) {
                return const WelcomeDialog();
              }
              return _buildMenu(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenu(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width * 0.5;

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(flex: 1),
        SizedBox(
          width: screenWidth,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    const AutoScaleText.title("Save the ocean"),
                    AutoScaleText.title("Save the ocean", color: Theme.of(context).colorScheme.primary),
                  ],
                ),
                Image.asset("assets/images/${ImageAssets.menuBottomLine}"),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => AppRouter.goToGame(),
                  child: const AutoScaleText.body('PLAY'),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => AppRouter.goToRanking(),
                  child: const AutoScaleText.body('RANKING'),
                ),
                const SizedBox(height: 24),
                Image.asset("assets/images/${ImageAssets.menuLine}"),
              ],
            ),
          ),
        ),
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
    );
  }

  Widget _buildMarquee(BuildContext context) {
    return const Card(
      color: Colors.transparent,
      child: Padding(padding: EdgeInsets.all(8.0), child: AutoScaleText.body("Link sobre contaminación marina")),
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
