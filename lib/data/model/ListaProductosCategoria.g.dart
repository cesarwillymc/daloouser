// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ListaProductosCategoria.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ListaProductosCategoriaAdapter
    extends TypeAdapter<ListaProductosCategoria> {
  @override
  final int typeId = 2;

  @override
  ListaProductosCategoria read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListaProductosCategoria(
      fields[0] as ServiceModel,
      (fields[1] as List)?.cast<ProductoData>(),
    );
  }

  @override
  void write(BinaryWriter writer, ListaProductosCategoria obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.service)
      ..writeByte(1)
      ..write(obj.items);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListaProductosCategoriaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
