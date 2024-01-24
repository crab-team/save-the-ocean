import 'package:firebase_core/firebase_core.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_the_ocean/audio/audio_controller.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/core/app_lifecycle.dart';
import 'package:save_the_ocean/core/router.dart';
import 'package:save_the_ocean/providers/battery_level_providers.dart';
import 'package:save_the_ocean/data/repository_provider.dart';
import 'package:save_the_ocean/domain/repositories/ranking_repository.dart';
import 'package:save_the_ocean/domain/use_cases/ranking/get_ranking.dart';
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
  
  runApp(const MyGame());
}

class MyGame extends StatelessWidget {
  const MyGame({super.key});

  @override
  Widget build(BuildContext context) {
    RankingRepository rankingRepository = RepositoryProvider.provideRanking();
    GetRanking getRanking = GetRanking(rankingRepository);

    return AppLifecycleObserver(
      child: MultiProvider(
        providers: [
          Provider(create: (context) => SettingsController()),
          Provider(create: (context) => BatteryLevelNotifier()),
          ChangeNotifierProvider(create: (context) => RankingController(getRanking: getRanking)),
          ChangeNotifierProvider(create: (context) => BatteryLevelNotifier()),
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
