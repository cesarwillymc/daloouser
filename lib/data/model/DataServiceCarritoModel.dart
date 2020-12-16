
import 'package:hive/hive.dart';

part 'DataServiceCarritoModel.g.dart';
@HiveType(typeId: 5)
class DataServiceCarritoModel {
  @HiveField(0)
  String id;
  @HiveField(1)
  double latitude;
  @HiveField(2)
  double longitude;
  @HiveField(3)
  String nombreService;
  DataServiceCarritoModel(this.id,this.longitude,this.latitude,this.nombreService);
}