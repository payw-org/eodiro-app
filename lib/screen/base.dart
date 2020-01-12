import 'package:eodiro/package/eodiro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Stack(
        children: <Widget>[
          StatusBar(
            statusBarHeight: statusBarHeight,
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: MultiProvider(
              providers: [
                ChangeNotifierProvider<TabBloc>.value(
                  value: TabBloc(),
                )
              ],
              child: EodiroTabBar(),
            ),
          )
        ],
      ),
    );
  }
}
