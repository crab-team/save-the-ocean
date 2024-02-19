import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_the_ocean/controllers/users/user_controller.dart';
import 'package:save_the_ocean/shared/widgets/auto_scale_text.dart';

class UsernameText extends StatelessWidget {
  const UsernameText({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(
      builder: (context, controller, child) {
        if (controller.currentState == UserControllerState.loading) {
          return const CircularProgressIndicator();
        }

        return AutoScaleText.small("Welcome ${controller.currentUser?.username ?? 'No user'}");
      },
    );
  }
}
