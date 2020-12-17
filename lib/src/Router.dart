import 'package:daloouser/src/pages/LoginAuthPage.dart';
import 'package:daloouser/src/pages/PreviewCategoriasPage.dart';
import 'package:daloouser/src/pages/PreviewProductoPage.dart';
import 'package:daloouser/src/pages/PreviewServicePage.dart';
import 'package:daloouser/src/pages/SphashScreen.dart';
import 'package:daloouser/src/screen/MainScreen.dart';
import 'package:daloouser/utils/Constant.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashScreenViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: SphashScreen(),
      );
    case MainScreenViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: MainScreen(settings.arguments),
      );
    case PreviewProductViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: PreviewProductoPage(settings.arguments),
      );
    case PreviewServiceViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: PreviewServicePage((settings.arguments as List<String>)[0],
            (settings.arguments as List<String>)[1]),
      );
    case PreviewCategoriaPageViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: PreviewCategoriasPage((settings.arguments as List<String>)[0],
            (settings.arguments as List<String>)[1],(settings.arguments as List<String>)[2]),
      );
    case SignInViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: LoginAuthPage(),
      );
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}

PageRoute _getPageRoute({String routeName, Widget viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow);
}
