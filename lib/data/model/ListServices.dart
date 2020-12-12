
import 'package:daloouser/data/model/ServiceModel.dart';


class ListServices {
  List<ServiceModel> data;
  int total;

  ListServices({this.data, this.total});

  ListServices.fromJson(Map<String, dynamic> json)  {
    if (json['data'] != null) {
      data = new List<ServiceModel>();
      json['data'].forEach((v) {
        data.add(new ServiceModel.fromJson2(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {

      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }
}