import 'package:flutter/material.dart';

class ScreenContainer extends StatelessWidget {
  final Widget child;
  const ScreenContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width * 0.5;
    return SizedBox(
      width: screenWidth,
      child: child,
    );
  }
}
