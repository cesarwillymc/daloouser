import 'package:hive/hive.dart';

part 'CarritoPriceModel.g.dart';

@HiveType(typeId: 7)
class CarritoPriceModel {
  @HiveField(0)
  double Precio;
  @HiveField(1)
  String url;
  CarritoPriceModel(this.Precio,this.url);

}