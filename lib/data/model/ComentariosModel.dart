class ComentariosModel {
  int start;
  String sId;
  String createAt;
  String coment;
  UserId userId;
  String serviceId;

  ComentariosModel(
      {this.start,
        this.sId,
        this.createAt,
        this.coment,
        this.userId,
        this.serviceId});

  ComentariosModel.fromJson(Map<String, dynamic> json) {
    start = int.parse(json['start'].toString());
    sId = json['_id'];
    createAt = json['create_at'];
    coment = json['coment'];
    userId =
    json['userId'] != null ? new UserId.fromJson(json['userId']) : null;
    serviceId = json['serviceId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start'] = this.start;
    data['_id'] = this.sId;
    data['create_at'] = this.createAt;
    data['coment'] = this.coment;
    if (this.userId != null) {
      data['userId'] = this.userId.toJson();
    }
    data['serviceId'] = this.serviceId;
    return data;
  }
}

class UserId {
  String sId;
  String name;
  String lastName;
  String uriImgPerfil;

  UserId({this.sId, this.name, this.lastName, this.uriImgPerfil});

  UserId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    lastName = json['lastName'];
    uriImgPerfil = json['uriImgPerfil'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['lastName'] = this.lastName;
    data['uriImgPerfil'] = this.uriImgPerfil;
    return data;
  }
}