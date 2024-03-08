import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/controllers/users/user_controller.dart';
import 'package:save_the_ocean/core/router.dart';
import 'package:save_the_ocean/core/theme.dart';
import 'package:save_the_ocean/screens/menu/widgets/sound_button.dart';
import 'package:save_the_ocean/screens/menu/widgets/username_text.dart';
import 'package:save_the_ocean/shared/dialogs/welcome/welcome_dialog.dart';
import 'package:save_the_ocean/shared/widgets/auto_scale_text.dart';
import 'package:save_the_ocean/shared/widgets/background_menu.dart';
import 'package:save_the_ocean/shared/widgets/loading.dart';
import 'package:save_the_ocean/shared/widgets/logo.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      await context.read<UserController>().checkFirstTime();
      await context.read<UserController>().fetch();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundMenu(),
          Consumer<UserController>(
            builder: (context, controller, child) {
              if (controller.currentState == UserControllerState.loading) {
                return const Center(child: Loading());
              }

              if (controller.currentState == UserControllerState.success) {
                return _buildMenu(context);
              }

              return const WelcomeDialog();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenu(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width * 0.4;

    return Padding(
      padding: kPaddingApp,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              UsernameText(),
              SoundButton(),
            ],
          ),
          SizedBox(
            width: screenWidth,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Logo(),
                  Image.asset("assets/images/${ImageAssets.menuBottomLine}"),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => _goToScreen(context),
                    child: const AutoScaleText.body('PLAY'),
                  ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: _buildMtcLogo(context)),
              Expanded(child: _buildVersion(context)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMtcLogo(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/${ImageAssets.mtcLogoWhite}',
        width: MediaQuery.of(context).size.width * 0.15,
      ),
    );
  }

  Widget _buildVersion(BuildContext context) {
    return const Center(
      child: AutoScaleText.small('Version 1.0.0'),
    );
  }

  void _goToScreen(BuildContext context) {
    context.read<UserController>().isFirstTime ? AppRouter.goToIntroduction() : AppRouter.goToGame();
  }
}
