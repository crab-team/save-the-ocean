import 'package:firebase_core/firebase_core.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/breakpoint.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/controllers/audio/audio_controller.dart';
import 'package:save_the_ocean/controllers/ranking/ranking_controller.dart';
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
import 'package:save_the_ocean/domain/use_cases/users/is_first_time.dart';
import 'package:save_the_ocean/domain/use_cases/users/save_first_time.dart';
import 'package:save_the_ocean/domain/use_cases/users/update_user.dart';
import 'package:save_the_ocean/utils/firebase_options.dart';
import 'package:save_the_ocean/utils/preload_rive.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Flame.device.fullScreen();
  await Flame.device.setLandscape();
  FlameAudio.bgm.initialize();

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

  const MyGame({
    super.key,
    required this.usersRepository,
    required this.rankingRepository,
  });

  @override
  Widget build(BuildContext context) {
    GetUser getUser = GetUser(usersRepository);
    CreateUser createUser = CreateUser(usersRepository);
    UpdateUserScore updateUserScore = UpdateUserScore(usersRepository);
    GetUserByUsername getUserByUsername = GetUserByUsername(usersRepository);
    IsFirstTime isFirstTime = IsFirstTime(usersRepository);
    SaveFirstTime saveFirstTime = SaveFirstTime(usersRepository);
    GetRanking getRanking = GetRanking(rankingRepository);

    return AppLifecycleObserver(
      child: MultiProvider(
        providers: [
          Provider(create: (context) => RiveAnimationProvider()),
          ChangeNotifierProvider(create: (context) => AudioController()),
          ChangeNotifierProvider(
            create: (context) => UserController(
              getUserUseCase: getUser,
              getUserByUsername: getUserByUsername,
              createUserUseCase: createUser,
              updateUserScoreUseCase: updateUserScore,
              isFirstTimeUseCase: isFirstTime,
              saveFirstTimeUseCase: saveFirstTime,
            ),
          ),
          ChangeNotifierProxyProvider<UserController, ButtonUserStartController>(
            create: (context) => ButtonUserStartController(userController: null),
            update: (context, userController, buttonUserStartController) =>
                ButtonUserStartController(userController: userController),
          ),
          ChangeNotifierProvider(create: (context) => RankingController(getRanking: getRanking)),
        ],
        child: _buildResponsiveMaterial(
          context,
          Builder(builder: (context) {
            return MaterialApp.router(
              theme: theme,
              title: TextConstants.appName,
              routeInformationProvider: router.routeInformationProvider,
              routeInformationParser: router.routeInformationParser,
              routerDelegate: router.routerDelegate,
            );
          }),
        ),
      ),
    );
  }

  Widget _buildResponsiveMaterial(BuildContext context, Widget widget) {
    return ResponsiveBreakpoints.builder(
      child: widget,
      breakpoints: [
        const Breakpoint(start: 0, end: 450, name: MOBILE),
        const Breakpoint(start: 451, end: 800, name: TABLET),
        const Breakpoint(start: 801, end: 1920, name: DESKTOP),
        const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
      ],
      breakpointsLandscape: [
        const Breakpoint(start: 0, end: 450, name: MOBILE),
        const Breakpoint(start: 451, end: 800, name: TABLET),
        const Breakpoint(start: 801, end: 1920, name: DESKTOP),
        const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
      ],
    );
  }
}
