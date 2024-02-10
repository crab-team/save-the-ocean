import 'package:firebase_core/firebase_core.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_the_ocean/audio/audio_controller.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/controllers/users/button_user_start_controller.dart';
import 'package:save_the_ocean/controllers/users/user_controller.dart';
import 'package:save_the_ocean/core/app_lifecycle.dart';
import 'package:save_the_ocean/core/router.dart';
import 'package:save_the_ocean/core/theme.dart';
import 'package:save_the_ocean/data/repository_provider.dart';
import 'package:save_the_ocean/domain/repositories/ranking_repository.dart';
import 'package:save_the_ocean/domain/repositories/users_repository.dart';
import 'package:save_the_ocean/domain/use_cases/ranking/get_ranking.dart';
import 'package:save_the_ocean/domain/use_cases/users/create_user.dart';
import 'package:save_the_ocean/domain/use_cases/users/get_user.dart';
import 'package:save_the_ocean/domain/use_cases/users/get_user_by_username.dart';
import 'package:save_the_ocean/domain/use_cases/users/update_user.dart';
import 'package:save_the_ocean/firebase_options.dart';
import 'package:save_the_ocean/screens/menu/controllers/ranking_controller.dart';
import 'package:save_the_ocean/settings/settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Flame.device.fullScreen();
  await Flame.device.setLandscape();
  UsersRepository usersRepository = await RepositoryProvider.provideUsers();
  RankingRepository rankingRepository = RepositoryProvider.provideRanking();

  runApp(MyGame(
    usersRepository: usersRepository,
    rankingRepository: rankingRepository,
  ));
}

class MyGame extends StatelessWidget {
  final UsersRepository usersRepository;
  final RankingRepository rankingRepository;

  const MyGame({super.key, required this.usersRepository, required this.rankingRepository});

  @override
  Widget build(BuildContext context) {
    GetUser getUser = GetUser(usersRepository);
    CreateUser createUser = CreateUser(usersRepository);
    UpdateUserScore updateUserScore = UpdateUserScore(usersRepository);
    GetUserByUsername getUserByUsername = GetUserByUsername(usersRepository);
    GetRanking getRanking = GetRanking(rankingRepository);

    return AppLifecycleObserver(
      child: MultiProvider(
        providers: [
          Provider(create: (context) => SettingsController()),
          ChangeNotifierProvider(
            create: (context) => UserController(
              getUser: getUser,
              getUserByUsername: getUserByUsername,
              createUser: createUser,
              updateUserScore: updateUserScore,
            ),
          ),
          ChangeNotifierProxyProvider<UserController, ButtonUserStartController>(
            create: (context) => ButtonUserStartController(userController: null),
            update: (context, userController, buttonUserStartController) =>
                ButtonUserStartController(userController: userController),
          ),
          ChangeNotifierProvider(create: (context) => RankingController(getRanking: getRanking)),
          // Set up audio.
          ProxyProvider2<SettingsController, AppLifecycleStateNotifier, AudioController>(
            // Ensures that music starts immediately.
            lazy: false,
            create: (context) => AudioController(),
            update: (context, settings, lifecycleNotifier, audio) {
              audio!.attachDependencies(lifecycleNotifier, settings);
              return audio;
            },
            dispose: (context, audio) => audio.dispose(),
          ),
        ],
        child: Builder(builder: (context) {
          return MaterialApp.router(
            theme: theme,
            title: TextConstants.appName,
            routeInformationProvider: router.routeInformationProvider,
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
          );
        }),
      ),
    );
  }
}
