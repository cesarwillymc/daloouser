import 'package:hive/hive.dart';

part 'Prices.g.dart';

@HiveType(typeId: 12)
class Prices{
  @HiveField(0)
  String id;
  @HiveField(1)
  double price;
  @HiveField(2)
  String name;
  @HiveField(3)
  String desc;
  @HiveField(4)
  String id2;

  Prices(this.id, this.price, this.name, this.desc, this.id2);

  Prices.fromJson(Map<String, dynamic> json){
    id= json["_id"].toString();
    price= double.parse(json["price"].toString());
    name= json["name"].toString();
    desc= json["desc"].toString();
  }
}