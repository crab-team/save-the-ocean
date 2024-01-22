import 'package:intl/intl.dart';

extension ScoreX on int {
  String toScore() {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(this);
    String format = time.hour > 0 ? 'HH:mm:ss:SS' : 'mm:ss:SS';
    return DateFormat(format).format(time);
  }
}
