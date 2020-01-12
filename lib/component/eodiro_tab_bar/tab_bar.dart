import 'package:eodiro/package/eodiro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'tab_bar_item.dart';

class EodiroTabBar extends StatefulWidget {
  @override
  _EodiroTabBarState createState() => _EodiroTabBarState();
}

class _EodiroTabBarState extends State<EodiroTabBar> {
  @override
  Widget build(BuildContext context) {
    final double paddingBottom = MediaQuery.of(context).padding.bottom;

    return Container(
      height: 50 + paddingBottom,
      color: EodiroColors.baseWhiteBlue,
      width: MediaQuery.of(context).size.width,
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          EodiroTabBarItem(
            index: 0,
            label: '빈 강의실',
            icon: Icons.beach_access,
          ),
          EodiroTabBarItem(
            index: 1,
            label: '강의검색',
            icon: Icons.school,
          ),
          EodiroTabBarItem(
            index: 2,
            label: '학식',
            icon: Icons.fastfood,
          ),
          EodiroTabBarItem(
            index: 3,
            label: '광장',
            icon: Icons.bubble_chart,
          ),
        ],
      ),
    );
  }
}
