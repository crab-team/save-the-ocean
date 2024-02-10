import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_the_ocean/controllers/users/user_controller.dart';
import 'package:save_the_ocean/controllers/users/user_state.dart';

class UsernameText extends StatelessWidget {
  const UsernameText({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserController>(
      builder: (context, controller, child) {
        if (controller.currentState.status == UserStatus.loading) {
          return const CircularProgressIndicator();
        }

        return Text("Welcome ${controller.currentUser?.username ?? 'No user'}",
            style: Theme.of(context).textTheme.displaySmall);
      },
    );
  }
}
