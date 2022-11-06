// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shop_reactions.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShopReactionsAdapter extends TypeAdapter<ShopReactions> {
  @override
  final int typeId = 4;

  @override
  ShopReactions read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShopReactions(
      delicious: fields[0] as int?,
      wellPacked: fields[1] as int?,
      veryWorthTheMoney: fields[2] as int?,
      satisfied: fields[3] as int?,
      quickService: fields[4] as int?,
      sad: fields[5] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ShopReactions obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.delicious)
      ..writeByte(1)
      ..write(obj.wellPacked)
      ..writeByte(2)
      ..write(obj.veryWorthTheMoney)
      ..writeByte(3)
      ..write(obj.satisfied)
      ..writeByte(4)
      ..write(obj.quickService)
      ..writeByte(5)
      ..write(obj.sad);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShopReactionsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
