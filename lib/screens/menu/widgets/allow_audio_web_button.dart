import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_the_ocean/constants/assets.dart';
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

  Future<void> allowAudio(BuildContext context) async {
    Provider.of<AudioController>(context, listen: false).isAllowed = true;
    await FlameAudio.bgm.play(AudioAssets.music, volume: 0.2);
  }
}
