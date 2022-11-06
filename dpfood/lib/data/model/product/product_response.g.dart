// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductResponseAdapter extends TypeAdapter<ProductResponse> {
  @override
  final int typeId = 7;

  @override
  ProductResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductResponse(
      isActive: fields[16] as bool?,
      description: fields[15] as String?,
      nameSearch: fields[17] as String?,
      name: fields[4] as String?,
      image: fields[5] as String?,
      thumbnail: fields[6] as String?,
      idUser: fields[7] as UserResponse?,
      idCategory: fields[8] as CategoryResponse?,
      idGroup: fields[9] as GroupProductResponse?,
      optionsSize: (fields[10] as List?)?.cast<OptionsSize>(),
      optionsTopping: (fields[11] as List?)?.cast<OptionsTopping>(),
      distanceMatrix: fields[12] as Distance?,
      numberReviews: fields[13] as int?,
      numberOfBuy: fields[14] as int?,
    )
      ..id = fields[0] as String?
      ..price = fields[1] as double?
      ..createdAt = fields[2] as String?
      ..updatedAt = fields[3] as String?;
  }

  @override
  void write(BinaryWriter writer, ProductResponse obj) {
    writer
      ..writeByte(18)
      ..writeByte(16)
      ..write(obj.isActive)
      ..writeByte(15)
      ..write(obj.description)
      ..writeByte(17)
      ..write(obj.nameSearch)
      ..writeByte(4)
      ..write(obj.name)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.thumbnail)
      ..writeByte(7)
      ..write(obj.idUser)
      ..writeByte(8)
      ..write(obj.idCategory)
      ..writeByte(9)
      ..write(obj.idGroup)
      ..writeByte(10)
      ..write(obj.optionsSize)
      ..writeByte(11)
      ..write(obj.optionsTopping)
      ..writeByte(12)
      ..write(obj.distanceMatrix)
      ..writeByte(13)
      ..write(obj.numberReviews)
      ..writeByte(14)
      ..write(obj.numberOfBuy)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.createdAt)
      ..writeByte(3)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
