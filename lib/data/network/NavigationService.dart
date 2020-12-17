import 'package:flutter/cupertino.dart';

class NavigationService {
  GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  void pop() {
    return _navigationKey.currentState.pop();
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState
        .pushNamed(routeName, arguments: arguments);
  }
  Future<dynamic> navigateToClearStack(String routeName, {dynamic arguments}) {
    return  _navigationKey.currentState.pushNamedAndRemoveUntil(routeName, (r) => false, arguments: arguments);

  }
}