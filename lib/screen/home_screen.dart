import 'package:eodiro/package/eodiro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  final url = 'https://api.eodiro.com/v2/campuses/seoul/vacant/buildings';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15.0,
        ),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                '빈 강의실',
                style: EodiroTextStyles.screenTitle,
              ),
            ),
            Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      'what',
                      style: EodiroTextStyles.defaultStyle,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
