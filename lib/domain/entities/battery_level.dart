class BatteryLevel {
  final double level;
  final double maxLevel;

  BatteryLevel({required this.level, this.maxLevel = 100});

  BatteryLevel increment(double amount) {
    return BatteryLevel(level: level + amount);
  }

  BatteryLevel decrement(double amount) {
    return BatteryLevel(level: level - amount);
  }

  bool isFull() {
    return level == maxLevel;
  }

  bool isEmpty() {
    return level == 0;
  }
}
