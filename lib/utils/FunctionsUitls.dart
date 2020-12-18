import 'dart:math';

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