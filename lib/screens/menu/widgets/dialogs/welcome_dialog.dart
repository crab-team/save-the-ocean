import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_the_ocean/controllers/users/user_controller.dart';
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
        TextButton(
          onPressed: () => _registerUser(context),
          child: const Text("Start"),
        ),
      ],
      child: Column(
        children: [
          Text("Please enter a username to start playing", style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: 12),
          Text("if you already have one, you can use it to continue your game.",
              style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 24),
          Form(
            key: formKey,
            child: TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: "Enter the username"),
              style: Theme.of(context).textTheme.displaySmall!,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter a username";
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  void _registerUser(BuildContext context) {
    if (formKey.currentState!.validate()) {
      Provider.of<UserController>(context, listen: false).create(usernameController.text);
    }
  }
}
