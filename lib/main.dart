import 'package:flutter/material.dart';
import 'package:eodiro/screen/base.dart';

void main() => runApp(EodiroApp());

class EodiroApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'eodiro',
      theme: ThemeData(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
      ),
      home: Base(
        title: 'eodiro',
      ),
    );
  }
}
