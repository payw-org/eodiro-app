import 'package:eodiro/package/eodiro.dart';
import 'package:flutter/material.dart';
import 'package:eodiro/screen/base.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() => runApp(EodiroApp());

class EodiroApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Support only portrait mode
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<EodiroTabBarBloc>.value(
          value: EodiroTabBarBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'eodiro',
        theme: ThemeData(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        home: Base(
          title: 'eodiro',
        ),
      ),
    );
  }
}
