// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PromocionesModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PromocionesModelAdapter extends TypeAdapter<PromocionesModel> {
  @override
  PromocionesModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PromocionesModel(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[5] as String,
      fields[6] as String,
      fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PromocionesModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.nameProduct)
      ..writeByte(1)
      ..write(obj.img)
      ..writeByte(2)
      ..write(obj.price)
      ..writeByte(3)
      ..write(obj.rating)
      ..writeByte(4)
      ..write(obj.timePrepare)
      ..writeByte(5)
      ..write(obj.nameService)
      ..writeByte(6)
      ..write(obj.serviceId)
      ..writeByte(7)
      ..write(obj.productId);
  }

  @override
  int get typeId => 1;
}
