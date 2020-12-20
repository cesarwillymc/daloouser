import 'package:daloouser/src/pages/LoginAuthPage.dart';
import 'package:daloouser/src/pages/PreviewCategoriasPage.dart';
import 'package:daloouser/src/pages/PreviewProductoPage.dart';
import 'package:daloouser/src/pages/PreviewServicePage.dart';
import 'package:daloouser/src/pages/SphashScreen.dart';
import 'package:daloouser/src/pages/history/HistoryPreviewPage.dart';
import 'package:daloouser/src/pages/login/SendMessagePage.dart';
import 'package:daloouser/src/pages/login/VerifyMessagePage.dart';
import 'package:daloouser/src/pages/profile/ProfilePage.dart';
import 'package:daloouser/src/pages/ubication/UbicacionRiderPage.dart';
import 'package:daloouser/src/pages/ubication/UbicationPage.dart';
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
        viewToShow: PreviewCategoriasPage(
            (settings.arguments as List<String>)[0],
            (settings.arguments as List<String>)[1],
            (settings.arguments as List<String>)[2]),
      );
    case SignInViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: LoginAuthPage(),
      );
    case ProfilePageViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ProfilePage(),
      );
    case ubicacionViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: UbicationPage(),
      );
    case ubicacionTimeRealViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: UbicationRiderPage(settings.arguments),
      );
    case HistoryPreviewPageViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: HistoryPreviewPage(settings.arguments),
      );
    case SendMessagePageViewRote:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: SendMessagePage(),
      );
    case VerifyMessagePageViewRote:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: VerifyMessagePage(settings.arguments),
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
