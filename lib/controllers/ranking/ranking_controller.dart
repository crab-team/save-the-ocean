import 'package:flutter/material.dart';
import 'package:save_the_ocean/controllers/ranking/ranking_state.dart';
import 'package:save_the_ocean/core/page_status.dart';
import 'package:save_the_ocean/domain/use_cases/ranking/get_ranking.dart';
import 'package:save_the_ocean/domain/entities/user.dart';

class RankingController extends ChangeNotifier {
  final GetRanking getRanking;

  RankingController({required this.getRanking});

  RankingState get currentState => _currentState;

  RankingState _currentState = RankingState();

  Future<void> fetch() async {
    loading();
    final List<User> users = await getRanking.call();
    data(users);
  }

  void loading() {
    _currentState = _currentState.copyWith(status: PageStatus.loading);
    notifyListeners();
  }

  void error() {
    _currentState = _currentState.copyWith(status: PageStatus.error);
    notifyListeners();
  }

  void data(List<User> users) {
    _currentState = _currentState.copyWith(status: PageStatus.data, users: users);
    notifyListeners();
  }
}
