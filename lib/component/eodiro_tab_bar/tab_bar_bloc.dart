import 'package:flutter/widgets.dart';

class EodiroTabBarBloc extends ChangeNotifier {
  int _tabIndex = 0;
  double _height;

  int get tabIndex => _tabIndex;
  double get height => _height;

  set tabIndex(int val) {
    _tabIndex = val;
    notifyListeners();
  }

  set height(double val) {
    _height = val;
    notifyListeners();
  }
}
