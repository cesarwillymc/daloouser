class ComentariosStartModel {
  int iId;
  int count;

  ComentariosStartModel({this.iId, this.count});

  ComentariosStartModel.fromJson(Map<String, dynamic> json) {
    iId = int.parse(json['_id'].toString());
    count = int.parse(json['count'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.iId;
    data['count'] = this.count;
    return data;
  }
}