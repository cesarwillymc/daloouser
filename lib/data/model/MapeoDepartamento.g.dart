// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MapeoDepartamento.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MapeoDepartamentoAdapter extends TypeAdapter<MapeoDepartamento> {
  @override
  final int typeId = 6;

  @override
  MapeoDepartamento read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MapeoDepartamento(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MapeoDepartamento obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.sId)
      ..writeByte(1)
      ..write(obj.departamento)
      ..writeByte(2)
      ..write(obj.provincia)
      ..writeByte(3)
      ..write(obj.mapa);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MapeoDepartamentoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
