import 'package:save_the_ocean/components/robot/body/rive_robot_body.dart';
import 'package:save_the_ocean/components/robot/head/rive_robot_head.dart';
import 'package:save_the_ocean/components/robot/head/robot_head.dart';
import 'package:save_the_ocean/components/robot/robot.dart';
import 'package:save_the_ocean/components/robot/body/robot_body.dart';

class RobotFactory {
  static Future<Robot> create() async {
    final riveHead = await RiveRobotHeadFactory.create();
    final riveBody = await RiveRobotBodyFactory.create();

    final head = RobotHead(riveHead: riveHead);
    final body = RobotBody(riveBody: riveBody);

    return Robot(robotHead: head, robotBody: body);
  }
}
