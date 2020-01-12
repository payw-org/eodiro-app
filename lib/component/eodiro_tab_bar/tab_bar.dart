import 'package:eodiro/component/eodiro_tab_bar/tab_bloc.dart';
import 'package:eodiro/component/eodiro_tab_bar/tab_item.dart';
import 'package:eodiro/theme/eodiro_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class EodiroTabBar extends StatefulWidget {
  @override
  _EodiroTabBarState createState() => _EodiroTabBarState();
}

class _EodiroTabBarState extends State<EodiroTabBar> {
  @override
  Widget build(BuildContext context) {
    final TabBloc tabBloc = Provider.of<TabBloc>(context);
    print(tabBloc.tabIndex);

    return Container(
      color: EodiroColors.baseWhiteBlue,
      width: MediaQuery.of(context).size.width,
      child: Flex(
        direction: Axis.horizontal,
        children: <Widget>[
          EodiroTabItem(
            isSelected: tabBloc.tabIndex == 0 ? true : false,
            label: 'Tab 1',
            icon: Icons.access_alarm,
            onTap: () {
              tabBloc.tabIndex = 0;
            },
          ),
          EodiroTabItem(
            isSelected: tabBloc.tabIndex == 1 ? true : false,
            label: 'Tab 2',
            icon: Icons.access_alarm,
            onTap: () {
              tabBloc.tabIndex = 1;
            },
          ),
        ],
      ),
    );
  }
}
