import 'package:eodiro/theme/eodiro_colors.dart';
import 'package:flutter/widgets.dart';

class StatusBar extends StatelessWidget {
  final double statusBarHeight;

  StatusBar({this.statusBarHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: statusBarHeight,
      decoration: BoxDecoration(
        color: EodiroColors.white,
      ),
    );
  }
}
