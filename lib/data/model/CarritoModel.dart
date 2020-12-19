
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

    data['idServicio'] = this.idServicio.toString();
    data['id_Product'] = this.id_Product.toString();
    data['id_Precio'] = this.id_Precio.toString();
    data['nameService'] = this.nameService.toString();
    data['cantidad'] = this.cantidad.toString();
    data['name'] = this.name.toString();
    data['subName'] = this.subName.toString();
    data['imgUrl'] = this.imgUrl.toString();
    data['precioTotal'] = this.precioTotal.toString();
    data['precioUnitari'] = this.precioUnitari.toString();
    return data;
  }
}