import 'package:eodiro/package/eodiro.dart';
import 'package:flutter/widgets.dart';

class _InitStyle extends TextStyle {
  const _InitStyle({
    FontWeight fontWeight = FontWeight.w400,
    double fontSize,
    Color color = EodiroColors.black,
    TextDecoration decoration = TextDecoration.none,
  }) : super(
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: color,
          decoration: decoration,
        );
}

class EodiroTextStyles {
  static const TextStyle screenTitle = _InitStyle(
    fontSize: 40,
    fontWeight: FontWeight.w700,
    color: EodiroColors.eodiroBerry,
  );

  static const TextStyle defaultStyle = _InitStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
  );
}

class EodiroText extends Text {
  EodiroText(
    String data, {
    TextStyle style = EodiroTextStyles.defaultStyle,
  }) : super(
          data,
          style: style,
        );
}
