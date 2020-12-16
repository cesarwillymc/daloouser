
import 'package:hive/hive.dart';
part 'CarritoModel.g.dart';
@HiveType(typeId: 0)
class CarritoModel{
  @HiveField(0)
  String  idServicio;
  @HiveField(1)
  String  id_Product;
  @HiveField(2)
  String  id_Precio;
  @HiveField(3)
  String  nameService;
  @HiveField(4)
  int  cantidad;
  @HiveField(5)
  String  name;
  @HiveField(6)
  String  subName;
  @HiveField(7)
  String  imgUrl;
  @HiveField(8)
  double  precioTotal;
  @HiveField(9)
  double  precioUnitari;

  CarritoModel(this.idServicio, this.id_Product, this.id_Precio, this.nameService, this.cantidad, this.name, this.subName, this.imgUrl, this.precioTotal, this.precioUnitari);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();

    data['idServicio'] = this.idServicio;
    data['id_Product'] = this.id_Product;
    data['id_Precio'] = this.id_Precio;
    data['nameService'] = this.nameService;
    data['cantidad'] = this.cantidad;
    data['name'] = this.name;
    data['subName'] = this.subName;
    data['imgUrl'] = this.imgUrl;
    data['precioTotal'] = this.precioTotal;
    data['precioUnitari'] = this.precioUnitari;
    return data;
  }
}