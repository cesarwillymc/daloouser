import 'dart:math';

import 'package:url_launcher/url_launcher.dart';

int convertColorHex(String color){
  return int.parse(color.replaceAll('#', '0xff'));
}
int random(min, max){
  var rn = new Random();
  return min + rn.nextInt(max - min);
}
double randomDouble(min, max){
  var rn = new Random();
  return min + rn.nextDouble() +  rn.nextInt(max - min);
}
Map<String, dynamic> loginFacebookJson(String access, String firebase) {
  Map<String, dynamic> data = new Map<String, dynamic>();

  data['access_token'] = access;
  data['fcm_token'] = firebase;
  return data;
}
Map<String, dynamic> directionUserJson(String direccion, String referencia,double latitude,double longitud) {
  Map<String, dynamic> data = new Map<String, dynamic>();

  data['adress'] = direccion.toString();
  data['latitude'] = latitude.toString();
  data['longitude'] = longitud.toString();
  data['altitude'] = "3857";
  data['reference'] = referencia.isEmpty?"Sin referencia":referencia;
  return data;
}
Map<String, dynamic> calificacionJson(double calificacion) {
  Map<String, dynamic> data = new Map<String, dynamic>();
  data['calificacion'] = calificacion.toString();
  return data;
}
Map<String, dynamic> validateCodeJson(String phone,String code) {
  Map<String, dynamic> data = new Map<String, dynamic>();
  data['telefono'] = phone.toString();
  data['code'] = code.toString();
  return data;
}
Map<String, dynamic> sendCodeJson(String phone) {
  Map<String, dynamic> data = new Map<String, dynamic>();
  data['telefono'] = phone.toString();
  return data;
}

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

bool isFeechedHour(int timepast,int hour){
  int diferencia = DateTime.now().millisecond - timepast;
  var seconds = diferencia / 1000;
  var minutes = seconds / 60;
  var hours = minutes / 60;
  var days = hours / 24;
  return  hours >= hour;
}