// import 'package:flame/components.dart';
// import 'package:flame/input.dart';
// import 'package:flame/palette.dart';
// import 'package:flutter/painting.dart';
// import 'package:save_the_ocean/components/robot/robot_claw.dart';

// class LeftButton extends HudButtonComponent {
//   final RobotClaw robotClaw;

//   LeftButton({
//     required this.robotClaw,
//   }) : super(
//           button: RectangleComponent(
//             size: Vector2(120, 60),
//             paint: BasicPalette.black.paint(),
//             children: [
//               TextComponent(text: 'Left'),
//             ],
//           ),
//           buttonDown: RectangleComponent(
//             size: Vector2(120, 60),
//             paint: BasicPalette.darkGray.paint(),
//           ),
//           margin: const EdgeInsets.only(left: 48, bottom: 32),
//           onPressed: () {
//             robotClaw.moveLeft();
//           },
//         );
// }
