import 'package:daloouser/Locator.dart';
import 'package:daloouser/src/Router.dart';
import 'package:daloouser/src/pages/SphashScreen.dart';
import 'package:daloouser/src/pages/TiendasPage.dart';
import 'package:daloouser/src/screen/MainScreen.dart';
import 'package:daloouser/utils/Constant.dart';
import 'package:daloouser/utils/manager/DialogManager.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'data/model/CategoryModel.dart';
import 'data/model/ListaProductosCategoria.dart';
import 'data/model/PromocionesModel.dart';
import 'data/model/ServiceItem.dart';
import 'data/network/DialogService.dart';
import 'data/network/NavigationService.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(ServiceItemAdapter());
  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(PromocionesModelAdapter());
  Hive.registerAdapter(ListaProductosCategoriaAdapter());
  await Hive.openBox<ServiceItem>(recentSearchBOXHIVE);
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Food Delivery",
      debugShowCheckedModeBanner: false,
      builder: (context, child) =>
          Navigator(
            key: locator<DialogService>().dialogNavigationKey,
            onGenerateRoute: (settings) =>
                MaterialPageRoute(
                    builder: (context) => DialogManager(child: child)),
          ),
      navigatorKey: locator<NavigationService>().navigationKey,

      theme: ThemeData(
          primaryColor: Colors.red,
          accentColor: Colors.yellow,
          fontFamily: 'Gilroy'
      ),
      home: MainScreen(TiendasPage()),
      onGenerateRoute: generateRoute,
    );
  }
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}


