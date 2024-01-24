import 'package:flutter/material.dart';
import 'package:save_the_ocean/core/page_status.dart';
import 'package:save_the_ocean/domain/use_cases/ranking/get_ranking.dart';
import 'package:save_the_ocean/domain/user.dart';
import 'package:save_the_ocean/screens/menu/controllers/ranking_state.dart';

class RankingController extends ChangeNotifier {
  final GetRanking getRanking;

  RankingController({required this.getRanking});

  RankingState get currentState => _currentState;

  RankingState _currentState = RankingState();

  Future<void> fetch() async {
    _currentState = _currentState.copyWith(status: PageStatus.loading);

    final List<User> users = await getRanking.call();

    _currentState = _currentState.copyWith(status: PageStatus.data, users: users);

    notifyListeners();
  }
}
