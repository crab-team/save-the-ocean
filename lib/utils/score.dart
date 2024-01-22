import 'package:intl/intl.dart';

extension ScoreX on int {
  String formattedScore() {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(this);
    return DateFormat('HH:mm:ss:SS').format(time);
  }
}
