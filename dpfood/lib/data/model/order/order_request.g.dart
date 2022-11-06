// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_request.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OrderRequestAdapter extends TypeAdapter<OrderRequest> {
  @override
  final int typeId = 0;

  @override
  OrderRequest read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OrderRequest(
      // id: fields[0] as String?,
      // idUser: fields[1] as String?,
      // idUserShipper: fields[2] as String?,
      // idUserShop: fields[3] as UserResponse?,
      // idProducts: (fields[4] as List?)?.cast<OrderProduct>(),
      // idVoucher: fields[5] as String?,
      // finalPrice: fields[6] as double?,
      // shipPrice: fields[7] as double?,
      // promotionPrice: fields[8] as double?,
      // totalPrice: fields[9] as double?,
      // typePayment: fields[10] as String?,
      // statusPayment: fields[11] as String?,
      // status: fields[12] as String?,
      // codeOrder: fields[13] as String?,
      // latLong: fields[14] as Location?,
      // createdAt: fields[15] as String?,
      // updatedAt: fields[16] as String?,
      // description: fields[17] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, OrderRequest obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.idUser)
      ..writeByte(2)
      ..write(obj.idUserShipper)
      ..writeByte(3)
      ..write(obj.idUserShop)
      ..writeByte(4)
      ..write(obj.idProducts)
      ..writeByte(5)
      ..write(obj.idVoucher)
      ..writeByte(6)
      ..write(obj.finalPrice)
      ..writeByte(7)
      ..write(obj.shipPrice)
      ..writeByte(8)
      ..write(obj.promotionPrice)
      ..writeByte(9)
      ..write(obj.totalPrice)
      ..writeByte(10)
      ..write(obj.typePayment)
      ..writeByte(11)
      ..write(obj.statusPayment)
      ..writeByte(12)
      ..write(obj.status)
      ..writeByte(13)
      ..write(obj.codeOrder)
      ..writeByte(14)
      ..write(obj.latLong)
      ..writeByte(15)
      ..write(obj.createdAt)
      ..writeByte(16)
      ..write(obj.updatedAt)
      ..writeByte(17)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderRequestAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
