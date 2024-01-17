// import 'package:flame/components.dart';
// import 'package:flame/input.dart';
// import 'package:flame/palette.dart';
// import 'package:flutter/painting.dart';
// import 'package:save_the_ocean/components/robot/robot_claw.dart';

// class RightButton extends HudButtonComponent {
//   final RobotClaw robotClaw;
//   RightButton({
//     required this.robotClaw,
//   }) : super(
//           button: RectangleComponent(
//             size: Vector2(120, 60),
//             paint: BasicPalette.black.paint(),
//             children: [
//               TextComponent(text: 'Right'),
//             ],
//           ),
//           buttonDown: RectangleComponent(
//             size: Vector2(120, 60),
//             paint: BasicPalette.darkGray.paint(),
//           ),
//           margin: const EdgeInsets.only(left: 200, bottom: 32),
//           onPressed: () {
//             robotClaw.moveRight();
//           },
//         );
// }
