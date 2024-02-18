import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_the_ocean/controllers/audio/audio_controller.dart';
import 'package:save_the_ocean/shared/widgets/auto_scale_text.dart';

class AllowAudioWebButton extends StatelessWidget {
  const AllowAudioWebButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioController>(builder: (context, controller, _) {
      return Visibility(
        visible: !controller.isAllowed,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () => allowAudio(context),
            child: const AutoScaleText.small("Allow audio")),
      );
    });
  }

  void allowAudio(BuildContext context) {
    Provider.of<AudioController>(context, listen: false).isAllowed = true;
    Provider.of<AudioController>(context, listen: false).play();
  }
}
