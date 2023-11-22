import 'package:flutter/material.dart';

extension MHNavigator on BuildContext {
  NavigatorState get nav {
    return Navigator.of(this);
  }
}
