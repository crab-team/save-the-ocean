import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/controllers/users/user_controller.dart';
import 'package:save_the_ocean/controllers/users/user_state.dart';
import 'package:save_the_ocean/core/router.dart';
import 'package:save_the_ocean/shared/dialogs/welcome_dialog.dart';
import 'package:save_the_ocean/screens/menu/widgets/username_text.dart';
import 'package:save_the_ocean/shared/widgets/auto_scale_text.dart';
import 'package:save_the_ocean/shared/widgets/background_menu.dart';
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
                const Logo(),
                Image.asset("assets/images/${ImageAssets.menuBottomLine}"),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => _goToScreen(),
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
            Expanded(child: _buildVersion(context)),
          ],
        ),
      ],
    );
  }

  Widget _buildMtcLogo(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/${ImageAssets.mtcLogoWhite}',
        width: 120,
        height: 120,
      ),
    );
  }

  Widget _buildVersion(BuildContext context) {
    return const Center(
      child: AutoScaleText.small('Version 1.0.0'),
    );
  }

  void _goToScreen() {
    AppRouter.goToIntroduction();
  }
}
