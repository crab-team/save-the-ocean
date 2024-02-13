import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_the_ocean/controllers/users/button_user_start_controller.dart';
import 'package:save_the_ocean/shared/widgets/auto_scale_text.dart';
import 'package:save_the_ocean/shared/widgets/dialog.dart';

class WelcomeDialog extends StatefulWidget {
  const WelcomeDialog({super.key});

  @override
  State<WelcomeDialog> createState() => _WelcomeDialogState();
}

class _WelcomeDialogState extends State<WelcomeDialog> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: "Welcome",
      actions: [
        Consumer<ButtonUserStartController>(builder: (context, controller, _) {
          if (controller.status == ButtonUserStartStatus.loading) {
            return const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            );
          }

          return TextButton(
            onPressed: () => _registerUser(context),
            child: const AutoScaleText.body("Start"),
          );
        }),
      ],
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        child: Column(
          children: [
            const AutoScaleText.body("Please enter a username to start playing"),
            const SizedBox(height: 12),
            const AutoScaleText.small("if you already have one, you can use it to continue your game."),
            const SizedBox(height: 24),
            Form(
              key: formKey,
              child: TextFormField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: "Enter the username"),
                style: Theme.of(context).textTheme.displayMedium!,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a username";
                  }
                  return null;
                },
                onFieldSubmitted: (_) => _registerUser(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _registerUser(BuildContext context) {
    if (formKey.currentState!.validate()) {
      Provider.of<ButtonUserStartController>(context, listen: false).onPress(usernameController.text);
    }
  }
}
