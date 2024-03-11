import 'package:flutter/material.dart';

class Logger {
  static log(String message) {
    String dateTime = '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';
    debugPrint('$dateTime > $message');
  }

  static warning(String message) {
    String dateTime = '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';
    debugPrint('WARNING: $dateTime > $message');
  }

  static error(String message) {
    String dateTime = '${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}';
    debugPrint('ERROR: $dateTime > $message');
  }
}
