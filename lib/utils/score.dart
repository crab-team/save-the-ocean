import 'package:intl/intl.dart';

extension ScoreX on int {
  String formattedScore() {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(this);
    return DateFormat('HH:mm:ss:SS').format(time);
  }
}

class ScoreUtils {
  static String getTimeFormatByDt(double dt) {
    String minutes = getMinutes(dt);
    String seconds = getSeconds(dt);
    String milliseconds = getMilliseconds(dt);

    return '$minutes:$seconds:$milliseconds';
  }

  static String getMinutes(double dt) {
    return (dt / 60).floor().toString().padLeft(2, '0');
  }

  static String getSeconds(double dt) {
    return (dt % 60).floor().toString().padLeft(2, '0');
  }

  static String getMilliseconds(double dt) {
    return ((dt * 1000) % 1000).floor().toString().padLeft(3, '0');
  }
}
