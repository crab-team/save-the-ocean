import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/controllers/users/user_controller.dart';
import 'package:save_the_ocean/controllers/users/user_error.dart';
import 'package:save_the_ocean/controllers/users/user_state.dart';
import 'package:save_the_ocean/core/router.dart';
import 'package:save_the_ocean/screens/menu/widgets/dialogs/welcome_dialog.dart';
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
          _buildWelcomeDialog(),
        ],
      ),
    );
  }

  Widget _buildWelcomeDialog() {
    return Consumer<UserController>(builder: (context, controller, child) {
      UserState state = controller.currentState;

      if (state.status == UserStatus.noUsernameLocally) {
        return const WelcomeDialog();
      }

      return const SizedBox();
    });
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
            onPressed: () => AppRouter.goToRanking(),
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
