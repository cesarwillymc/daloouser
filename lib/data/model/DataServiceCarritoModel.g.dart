// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DataServiceCarritoModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DataServiceCarritoModelAdapter
    extends TypeAdapter<DataServiceCarritoModel> {
  @override
  final int typeId = 5;

  @override
  DataServiceCarritoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataServiceCarritoModel(
      fields[0] as String,
      fields[2] as double,
      fields[1] as double,
      fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DataServiceCarritoModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.latitude)
      ..writeByte(2)
      ..write(obj.longitude)
      ..writeByte(3)
      ..write(obj.nombreService);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataServiceCarritoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
