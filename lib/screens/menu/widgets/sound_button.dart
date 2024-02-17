import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_the_ocean/controllers/audio/audio_controller.dart';

class SoundButton extends StatelessWidget {
  const SoundButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioController>(
      builder: (context, controller, child) {
        if (controller.isMuted) {
          return IconButton(
            icon: const Icon(Icons.volume_off),
            onPressed: () => controller.toggleMute(),
          );
        }

        return IconButton(
          icon: const Icon(Icons.volume_up),
          onPressed: () => controller.toggleMute(),
        );
      },
    );
  }
}
