import 'package:flutter/material.dart';
import 'package:save_the_ocean/shared/widgets/auto_scale_text.dart';

enum StartButtonState {
  initial,
  loading,
  success,
  failure,
}

class StartButton extends StatefulWidget {
  final void Function() onPressed;

  const StartButton({super.key, required this.onPressed});

  @override
  State<StartButton> createState() => _StartButtonState();
}

class _StartButtonState extends State<StartButton> {
  StartButtonState state = StartButtonState.initial;

  @override
  Widget build(BuildContext context) {
    if (state == StartButtonState.loading) {
      return const Padding(
        padding: EdgeInsets.all(8.0),
        child: CircularProgressIndicator(),
      );
    }

    return TextButton(
      onPressed: () {
        setState(() {
          state = StartButtonState.loading;
        });
        widget.onPressed();
      },
      child: const AutoScaleText.body("Start"),
    );
  }
}
