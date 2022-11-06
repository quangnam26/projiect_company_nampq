// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shipper_reactions.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShipperReactionsAdapter extends TypeAdapter<ShipperReactions> {
  @override
  final int typeId = 5;

  @override
  ShipperReactions read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShipperReactions(
      satisfied: fields[0] as int?,
      notSatisfied: fields[1] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ShipperReactions obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.satisfied)
      ..writeByte(1)
      ..write(obj.notSatisfied);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShipperReactionsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
