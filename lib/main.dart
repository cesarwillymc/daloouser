import 'package:daloouser/Locator.dart';
import 'package:daloouser/data/model/CarritoModel.dart';
import 'package:daloouser/data/model/CarritoPriceModel.dart';
import 'package:daloouser/data/model/DataServiceCarritoModel.dart';
import 'package:daloouser/data/model/MapeoDepartamento.dart';
import 'package:daloouser/data/model/UsuarioModel.dart';
import 'package:daloouser/src/Router.dart';
import 'package:daloouser/src/pages/TiendasPage.dart';
import 'package:daloouser/src/pages/introduction/IntroducctionPage.dart';
import 'package:daloouser/src/screen/MainScreen.dart';
import 'package:daloouser/utils/Constant.dart';
import 'package:daloouser/utils/manager/DialogManager.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:shared_preferences/shared_preferences.dart';
import 'data/model/CategoryModel.dart';
import 'data/model/ListaProductosCategoria.dart';
import 'data/model/ServiceItem.dart';
import 'data/network/DialogService.dart';
import 'data/network/NavigationService.dart';

List<Box> boxList = [];
SharedPreferences shared;

Future<List<Box>> _openBox() async {
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

  Hive.registerAdapter(MapeoDepartamentoAdapter());
  Hive.registerAdapter(ServiceItemAdapter());
  Hive.registerAdapter(CategoryModelAdapter());
  Hive.registerAdapter(CarritoModelAdapter());
  Hive.registerAdapter(ListaProductosCategoriaAdapter());
  Hive.registerAdapter(UsuarioModelAdapter());
  Hive.registerAdapter(DataServiceCarritoModelAdapter());
  Hive.registerAdapter(CarritoPriceModelAdapter());

  var boxcarritoPriceModel=await Hive.openBox<CarritoPriceModel>(priceCarritoBOXHIVE);
  var boxServiceItem=await Hive.openBox<ServiceItem>(recentSearchBOXHIVE);
  var boxCarritoModel=await Hive.openBox<CarritoModel>(carritoBOXHIVE);
  var boxUsuarioModel=await Hive.openBox<UsuarioModel>(usuarioBOXHIVE);
  var boxDataServiceCarritoModel=await Hive.openBox<DataServiceCarritoModel>(dataServiceBOXHIVE);
  var boxDataMapeoModel=await Hive.openBox<MapeoDepartamento>(polylineBOXHIVE);
  boxList.add(boxcarritoPriceModel);
  boxList.add(boxServiceItem);
  boxList.add(boxCarritoModel);
  boxList.add(boxUsuarioModel);
  boxList.add(boxDataServiceCarritoModel);
  boxList.add(boxDataMapeoModel);
  shared=await SharedPreferences.getInstance();
  return boxList;
}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _openBox();
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
    var isIntroRead =shared.getBool(sharedPrefIntro)??false;
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
      home: isIntroRead?MainScreen(TiendasPage()):IntroducctionPage(),
      onGenerateRoute: generateRoute,
    );
  }
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}


