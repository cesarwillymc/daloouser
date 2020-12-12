class ServiceModel {
  String id;
  String name;
  String address;
  double latitude;
  double longitude;
  double altitude;
  String category;
  String description;
  String horario;
  bool activeAccount;
  bool isOpen;
  String imagen;

  String serviceId;
  String categoriaId;

  String ratingNumber;


  ServiceModel(
      {
        this.id,
        this.name,
        this.address,
        this.latitude,
        this.longitude,
        this.altitude,
        this.category,
        this.description,
        this.horario,
        this.activeAccount,
        this.isOpen,
        this.imagen,
        this.serviceId,
        this.categoriaId,
        this.ratingNumber,});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    altitude = json['altitude'];
    category = json['category'];
    description = json['description'];
    horario = json['horario'];
    activeAccount = json['activeAccount'] as bool;
    isOpen = json['isOpen'] as bool;
    imagen = json['imagen'];
    serviceId = json['serviceId'];
    categoriaId = json['categoriaId'];
  }
  ServiceModel.fromJson2(Map<String, dynamic> json) {
    id = json['id'];
    imagen = json['img'];
    name = json['name'];
    isOpen = json['isOpen'];
    address = json['address'];
    ratingNumber = json['ratingNumber'];
    categoriaId = json['categoryId'];
    category = json['category'];
  }
  //GetInfo
  ServiceModel.fromJson3(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    latitude = double.parse(json['latitude'].toString());
    longitude = double.parse(json['longitude'].toString());
    category = json['category'];
    description = json['description'];
    horario = json['horario'];
    activeAccount = json['activeAccount'] as bool;
    isOpen = json['isOpen'] as bool;
    imagen = json['imagen'] ;
    serviceId = json['serviceId'];
    categoriaId = json['categoriaId'];
    ratingNumber = double.parse(json['rating'].toString()).toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['altitude'] = this.altitude;
    data['category'] = this.category;
    data['description'] = this.description;
    data['horario'] = this.horario;
    data['activeAccount'] = this.activeAccount;
    data['isOpen'] = this.isOpen;
    data['imagen'] = this.imagen;
    data['serviceId'] = this.serviceId;
    data['categoriaId'] = this.categoriaId;
    return data;
  }
}