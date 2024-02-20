import 'package:flutter/material.dart';
import 'package:save_the_ocean/shared/widgets/auto_scale_text.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return const AutoScaleText.body("Loading...");
  }
}
