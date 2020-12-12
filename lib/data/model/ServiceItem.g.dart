// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ServiceItem.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServiceItemAdapter extends TypeAdapter<ServiceItem> {
  @override
  ServiceItem read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ServiceItem(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
      fields[4] as String,
      fields[5] as String,
      fields[6] as bool,
      fields[7] as bool,
      fields[8] as String,
      fields[9] as String,
      fields[10] as String,
      fields[11] as String,
      fields[12] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ServiceItem obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.category)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj._id)
      ..writeByte(3)
      ..write(obj.img)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.address)
      ..writeByte(6)
      ..write(obj.isOpen)
      ..writeByte(7)
      ..write(obj.isProduct)
      ..writeByte(8)
      ..write(obj.ratingNumber)
      ..writeByte(9)
      ..write(obj.categoryId)
      ..writeByte(10)
      ..write(obj.categoriaId)
      ..writeByte(11)
      ..write(obj.namedRest)
      ..writeByte(12)
      ..write(obj.idNumber);
  }
  int get typeId => 3;
}
