import 'package:flutter/material.dart';

class VacantScreen extends StatefulWidget {
  @override
  _VacantScreenState createState() => _VacantScreenState();
}

class _VacantScreenState extends State<VacantScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Text('Vacant'),
      ],
    );
  }
}
