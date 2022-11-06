// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VoucherResponseAdapter extends TypeAdapter<VoucherResponse> {
  @override
  final int typeId = 22;

  @override
  VoucherResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VoucherResponse(
      id: fields[0] as String?,
      idCategory: fields[1] as CategoryResponse?,
      idUserShop: fields[2] as UserResponse?,
      minOrderPrice: fields[3] as double?,
      discountMoney: fields[4] as double?,
      fromDate: fields[5] as int?,
      toDate: fields[6] as int?,
      isEnable: fields[7] as bool?,
      name: fields[8] as String?,
      code: fields[9] as String?,
      image: fields[10] as String?,
      voucherOfUser: (fields[12] as List?)?.cast<String>(),
      voucherType: fields[13] as int?,
      userUsed: (fields[14] as List?)?.cast<String>(),
    )..limit = fields[11] as int?;
  }

  @override
  void write(BinaryWriter writer, VoucherResponse obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.idCategory)
      ..writeByte(2)
      ..write(obj.idUserShop)
      ..writeByte(3)
      ..write(obj.minOrderPrice)
      ..writeByte(4)
      ..write(obj.discountMoney)
      ..writeByte(5)
      ..write(obj.fromDate)
      ..writeByte(6)
      ..write(obj.toDate)
      ..writeByte(7)
      ..write(obj.isEnable)
      ..writeByte(8)
      ..write(obj.name)
      ..writeByte(9)
      ..write(obj.code)
      ..writeByte(10)
      ..write(obj.image)
      ..writeByte(11)
      ..write(obj.limit)
      ..writeByte(12)
      ..write(obj.voucherOfUser)
      ..writeByte(13)
      ..write(obj.voucherType)
      ..writeByte(14)
      ..write(obj.userUsed);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VoucherResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
