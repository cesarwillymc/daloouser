import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
part 'MapeoDepartamento.g.dart';
@HiveType(typeId: 6)
class MapeoDepartamento {
  @HiveField(0)
  String sId;
  @HiveField(1)
  String departamento;
  @HiveField(2)
  String provincia;
  @HiveField(3)
  String mapa;

  MapeoDepartamento(this.sId, this.departamento, this.provincia, this.mapa);

  MapeoDepartamento.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    departamento = json['departamento'];
    provincia = json['provincia'];
    mapa= json['mapa'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['departamento'] = this.departamento;
    data['provincia'] = this.provincia;
    data['mapa']=this.mapa;
    return data;
  }
  // new List<LatLng>();
//
//       json['mapa'].forEach((v) {
//         mapa.add(LatLng(double.parse(v["latitude"].toString()), double.parse(v["longitude"].toString())));
//       });
}