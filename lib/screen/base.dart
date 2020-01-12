import 'package:eodiro/package/eodiro.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Base extends StatefulWidget {
  final String title;
  final _screens = [HomeScreen(), VacantScreen()];
  final _screenTitles = ['Dashboard', 'Vacants'];

  Base({this.title});

  @override
  _BaseState createState() => _BaseState();
}

class _BaseState extends State<Base> {
  @override
  Widget build(BuildContext context) {
    final EodiroTabBarBloc tabBloc = Provider.of<EodiroTabBarBloc>(context);
    final tabIndex = tabBloc.tabIndex;
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      decoration: BoxDecoration(
        color: EodiroColors.white,
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            bottom: EodiroTabBar.tabBarHeight,
            left: 0,
            child: widget._screens[tabIndex],
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: EodiroTabBar(),
          ),
          StatusBar(
            statusBarHeight: statusBarHeight,
          ),
        ],
      ),
    );
  }
}
