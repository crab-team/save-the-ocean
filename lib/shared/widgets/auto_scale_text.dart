import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class AutoScaleText extends StatelessWidget {
  final String text;
  final Color color;
  final bool isTitle;
  final bool isSubtitle;
  final bool isBody;
  final bool isSmall;

  const AutoScaleText.title(this.text,
      {super.key,
      this.isTitle = true,
      this.isSubtitle = false,
      this.isBody = false,
      this.isSmall = false,
      this.color = Colors.white});
  const AutoScaleText.subtitle(this.text,
      {super.key,
      this.isTitle = false,
      this.isSubtitle = true,
      this.isBody = false,
      this.isSmall = false,
      this.color = Colors.white});
  const AutoScaleText.body(this.text,
      {super.key,
      this.isTitle = false,
      this.isSubtitle = false,
      this.isBody = true,
      this.isSmall = false,
      this.color = Colors.white});
  const AutoScaleText.small(this.text,
      {super.key,
      this.isTitle = false,
      this.isSubtitle = false,
      this.isBody = false,
      this.isSmall = true,
      this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    double minFontSize = 0;
    double maxFontSize = 0;

    if (isTitle) {
      minFontSize = 12;
      maxFontSize = Theme.of(context).textTheme.displayLarge!.fontSize!;
    } else if (isSubtitle) {
      minFontSize = 10;
      maxFontSize = Theme.of(context).textTheme.displayMedium!.fontSize!;
    } else if (isBody) {
      minFontSize = 8;
      maxFontSize = Theme.of(context).textTheme.displaySmall!.fontSize!;
    } else if (isSmall) {
      minFontSize = 6;
      maxFontSize = Theme.of(context).textTheme.bodyLarge!.fontSize!;
    }

    TextStyle style = isTitle
        ? Theme.of(context).textTheme.displayLarge!.copyWith(color: color)
        : isSubtitle
            ? Theme.of(context).textTheme.displayMedium!.copyWith(color: color)
            : isBody
                ? Theme.of(context).textTheme.displaySmall!.copyWith(color: color)
                : isSmall
                    ? Theme.of(context).textTheme.bodyLarge!.copyWith(color: color)
                    : Theme.of(context).textTheme.displaySmall!.copyWith(color: color);

    return AutoSizeText(
      text,
      style: style,
      textAlign: TextAlign.center,
      minFontSize: minFontSize,
      maxFontSize: maxFontSize,
      textScaleFactor: MediaQuery.of(context).size.width * 0.0016,
      maxLines: 1,
    );
  }
}
