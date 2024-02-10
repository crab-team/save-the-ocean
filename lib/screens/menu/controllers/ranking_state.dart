import 'package:save_the_ocean/core/page_status.dart';
import 'package:save_the_ocean/domain/entities/user.dart';

class RankingState {
  final PageStatus status;
  final List<User> users;

  RankingState({
    this.status = PageStatus.loading,
    this.users = const [],
  });

  RankingState copyWith({
    PageStatus? status,
    List<User>? users,
  }) {
    return RankingState(
      status: status ?? this.status,
      users: users ?? this.users,
    );
  }
}
