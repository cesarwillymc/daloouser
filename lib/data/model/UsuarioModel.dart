
import 'package:hive/hive.dart';
part 'UsuarioModel.g.dart';
@HiveType(typeId: 4)
class UsuarioModel {
  @HiveField(0)
  String registerDate;
  @HiveField(1)
  bool accountActivated;
  @HiveField(2)
  bool validateNumber;
  @HiveField(3)
  String uriImgPerfil;
  @HiveField(4)
  String mobilePhone;
  @HiveField(5)
  String name;
  @HiveField(6)
  String lastName;
  @HiveField(7)
  double latitude;
  @HiveField(8)
  double longitude;
  @HiveField(9)
  int altitude;
  @HiveField(10)
  String address;
  @HiveField(11)
  String idUser;

  UsuarioModel(
      {this.registerDate,
        this.accountActivated,
        this.validateNumber,
        this.uriImgPerfil,
        this.mobilePhone,
        this.name,
        this.lastName,
        this.latitude,
        this.longitude,
        this.altitude,
        this.address,
        this.idUser});

  UsuarioModel.fromJson(Map<String, dynamic> json) {
    registerDate = json['registerDate'];
    accountActivated = json['accountActivated'] as  bool;
    validateNumber = json['validateNumber'] as  bool;
    uriImgPerfil = json['uriImgPerfil'];
    mobilePhone = json['mobilePhone'];
    name = json['name'];
    lastName = json['lastName'];
    latitude = double.parse(json['latitude'].toString());
    longitude = double.parse(json['longitude'].toString());
    altitude = int.parse(json['altitude'].toString());
    address = json['address'];
    idUser = json['idUser'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['registerDate'] = this.registerDate;
    data['accountActivated'] = this.accountActivated;
    data['validateNumber'] = this.validateNumber;
    data['uriImgPerfil'] = this.uriImgPerfil;
    data['mobilePhone'] = this.mobilePhone;
    data['name'] = this.name;
    data['lastName'] = this.lastName;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['altitude'] = this.altitude;
    data['address'] = this.address;
    data['idUser'] = this.idUser;
    return data;
  }
}