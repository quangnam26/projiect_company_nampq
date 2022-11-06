// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'statitis_reviews_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StatitisReviewResponseAdapter
    extends TypeAdapter<StatitisReviewResponse> {
  @override
  final int typeId = 3;

  @override
  StatitisReviewResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StatitisReviewResponse(
      totalRating: fields[0] as int?,
      countRating: fields[1] as int?,
      shopReactions: fields[2] as ShopReactions?,
      shipperReactions: fields[3] as ShipperReactions?,
    );
  }

  @override
  void write(BinaryWriter writer, StatitisReviewResponse obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.totalRating)
      ..writeByte(1)
      ..write(obj.countRating)
      ..writeByte(2)
      ..write(obj.shopReactions)
      ..writeByte(3)
      ..write(obj.shipperReactions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatitisReviewResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
