import 'package:save_the_ocean/components/robot/rive_robot.dart';
import 'package:save_the_ocean/components/robot/robot.dart';

class RobotFactory {
  static Future<Robot> create() async {
    final riveRobot = await RiveRobotFactory.create();
    return Robot(riveRobot: riveRobot);
  }
}
