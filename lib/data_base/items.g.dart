// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemsAdapter extends TypeAdapter<Items> {
  @override
  final int typeId = 0;

  @override
  Items read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Items()
      ..itemName = fields[1] as String?
      ..itmeAmount = fields[2] as String?
      ..itemQuantity = fields[3] as String?
      ..itemId = fields[4] as String?;
  }

  @override
  void write(BinaryWriter writer, Items obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.itemName)
      ..writeByte(2)
      ..write(obj.itmeAmount)
      ..writeByte(3)
      ..write(obj.itemQuantity)
      ..writeByte(4)
      ..write(obj.itemId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
