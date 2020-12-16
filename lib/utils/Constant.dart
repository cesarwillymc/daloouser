import 'dart:ui';

import 'package:daloouser/data/model/DataServiceCarritoModel.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

import 'FunctionsUitls.dart';

const String SignInViewRoute = "LoginView";
const String SignUpViewRoute = "SignUp";
const String MainScreenViewRoute = "MainScreenViewRoute";
const String SplashScreenViewRoute = "SplashScreen";
const String PreviewProductViewRoute = "PreviewProductViewRoute";
const String PreviewServiceViewRoute = "PreviewServiceViewRoute";
const String PreviewCategoriaPageViewRoute = "PreviewCategoriaPageViewRoute";

const String BASE_URL_API = "http://64.52.85.15:4000/api/";

const String BASE_URL_AMAZON_IMG =
    "https://summit-puno.s3.us-east-2.amazonaws.com/";

//Box DB
const String recentSearchBOXHIVE = "recentSearchBOXHIVE";
const String usuarioBOXHIVE = "usuarioBOXHIVE";
const String carritoBOXHIVE = "carritoBOXHIVE";
const String dataServiceBOXHIVE = "dataServiceBOXHIVE";
const String priceCarritoBOXHIVE = "priceCarritoBOXHIVE";

//Colors
final Color primaryColor = Color(convertColorHex("#004E98"));

String getDirectionUrl(LatLng inicio, LatLng fin) {
  String str_origin = "origin=" +
      inicio.latitude.toString() +
      "," +
      inicio.longitude.toString();
  // punto de destino
  String str_dest =
      "destination=" + fin.latitude.toString() + "," + fin.longitude.toString();
  // Sensor de modo drive
  String sensor = "sensor=false";
  String mode = "mode=driving";
  // Sensor
  String parameters = "$str_origin&$str_dest&$sensor&$mode";
  // Formato de salida
  String output = "json";
  // url &key=AIzaSyBXQBe1pHpqQkclaoMEuAnZ6QVFbC860Yo
  // https://maps.googleapis.com/maps/api/directions/json?origin=-15.837974456285096,-70.02117622643709&destination=-15.837974456285096,-70.02117622643709&sensor=false&mode=driving&key=AIzaSyD7kwgqDzGW8voiXP7gAbxaKnGY_Fr4Cng
  return "maps/api/directions/$output?$parameters";
}

//Obetener Los puntos
String puntosList(String acceso) {
  var dataService = Hive.box<DataServiceCarritoModel>(dataServiceBOXHIVE);
  List<DataServiceCarritoModel> lista = dataService.values.toList();
  lista.removeAt(0);
  acceso += "&waypoints=";
  for (int i = 0; i < lista.length; i++) {
    acceso += "${lista[i].latitude},${lista[i].longitude}";
    if (i < lista.length - 1) acceso += "|";
  }
  acceso += "&key=AIzaSyATz3u8hZqJTY6ibagqBNKaSpsgdMnwjtA";
  return acceso;
}

bool esNoche() {
  final now = new DateTime.now();
  int hora = int.parse(DateFormat('H').format(now));
  return hora >= 20 || hora <= 5;
}

double fuctionPrice(int distance, int duration, int size) {
  var costo = 3.0;
  if (esNoche()) {
    costo = 4.0;
  }
  return ((0.15 * (duration * 0.016666667)) +
      (distance * 0.00055) +
      costo +
      ((size - 1) * 1.5));
}
