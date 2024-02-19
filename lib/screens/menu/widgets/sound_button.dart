import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_the_ocean/constants/assets.dart';
import 'package:save_the_ocean/controllers/audio/audio_controller.dart';

class SoundButton extends StatefulWidget {
  const SoundButton({super.key});

  @override
  State<SoundButton> createState() => _SoundButtonState();
}

class _SoundButtonState extends State<SoundButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      child: InkWell(
        child: FlameAudio.bgm.isPlaying
            ? Image.asset("assets/images/${ImageAssets.soundOff}")
            : Image.asset("assets/images/${ImageAssets.soundOn}"),
        onTap: () async {
          if (FlameAudio.bgm.isPlaying) {
            context.read<AudioController>().isAllowed = false;
            await FlameAudio.bgm.stop();
          } else {
            context.read<AudioController>().isAllowed = true;
            await FlameAudio.bgm.play(AudioAssets.music, volume: 0.2);
          }
          setState(() {});
        },
      ),
    );
  }
}
