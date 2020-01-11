import 'package:eodiro/screen/home_screen.dart';
import 'package:eodiro/screen/vacant_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class Base extends StatefulWidget {
  final String title;
  final _screens = [HomeScreen(), VacantScreen()];
  final _screen_titles = ['Dashboard', 'Vacants'];

  Base({this.title});

  @override
  _BaseState createState() => _BaseState();
}

class _BaseState extends State<Base> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Stack(
        children: <Widget>[
          BottomNavigationBar(
            currentIndex: _tabIndex,
            elevation: 0.0,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 12.0,
            selectedItemColor: Colors.deepOrange,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                title: Text('Dashboard'),
                icon: Icon(Icons.apps),
              ),
              BottomNavigationBarItem(
                title: Text('Vacants'),
                icon: Icon(Icons.access_alarms),
              ),
              BottomNavigationBarItem(
                title: Text('Cafeteria'),
                icon: Icon(Icons.fastfood),
              ),
              BottomNavigationBarItem(
                title: Text('Square'),
                icon: Icon(Icons.bubble_chart),
              ),
            ],
            onTap: (index) {
              print(index);
              setState(() {
                _tabIndex = index;
              });
            },
          ),
          Container(
            transform: Matrix4.translationValues(0, -1, 0),
            height: 1.0,
            color: CupertinoColors.extraLightBackgroundGray,
          ),
        ],
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          widget.title,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 25.0,
          ),
        ),
        elevation: 0.0,
        backgroundColor: CupertinoColors.white,
        brightness: Brightness.light,
        bottom: PreferredSize(
          child: Container(
            color: CupertinoColors.extraLightBackgroundGray,
            height: 1.0,
          ),
          preferredSize: Size.fromHeight(0),
        ),
      ),
      body: widget._screens[_tabIndex],
    );
  }
}
