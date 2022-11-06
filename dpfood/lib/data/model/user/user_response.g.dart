// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserResponseAdapter extends TypeAdapter<UserResponse> {
  @override
  final int typeId = 2;

  @override
  UserResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserResponse(
      rankPoint: fields[0] as int?,
      bankAccountName: fields[1] as String?,
      bankAccountNumber: fields[2] as int?,
      branchName: fields[3] as String?,
      bankName: fields[4] as String?,
      defaultAccount: fields[5] as int?,
      isGetOpen: fields[6] as bool?,
      isVerified: fields[7] as bool?,
      isGetNotification: fields[8] as bool?,
      address: fields[9] as String?,
      typeUser: fields[10] as String?,
      fullName: fields[11] as String?,
      banner: fields[12] as String?,
      avatar: fields[13] as String?,
      enableFCM: fields[14] as bool?,
      deviceID: fields[15] as String?,
      typeRegister: fields[16] as String?,
      phone: fields[17] as String?,
      role: fields[18] as String?,
      createdAt: fields[19] as String?,
      updatedAt: fields[20] as String?,
      id: fields[21] as String?,
      username: fields[22] as String?,
      dateOfBirth: fields[23] as int?,
      idProvince: fields[24] as String?,
      idDistrict: fields[25] as String?,
      idVillage: fields[26] as String?,
      statitisReviews: fields[28] as StatitisReviewResponse?,
      numberOfSale: fields[29] as int?,
      latLong: fields[27] as Location?,
    );
  }

  @override
  void write(BinaryWriter writer, UserResponse obj) {
    writer
      ..writeByte(30)
      ..writeByte(0)
      ..write(obj.rankPoint)
      ..writeByte(1)
      ..write(obj.bankAccountName)
      ..writeByte(2)
      ..write(obj.bankAccountNumber)
      ..writeByte(3)
      ..write(obj.branchName)
      ..writeByte(4)
      ..write(obj.bankName)
      ..writeByte(5)
      ..write(obj.defaultAccount)
      ..writeByte(6)
      ..write(obj.isGetOpen)
      ..writeByte(7)
      ..write(obj.isVerified)
      ..writeByte(8)
      ..write(obj.isGetNotification)
      ..writeByte(9)
      ..write(obj.address)
      ..writeByte(10)
      ..write(obj.typeUser)
      ..writeByte(11)
      ..write(obj.fullName)
      ..writeByte(12)
      ..write(obj.banner)
      ..writeByte(13)
      ..write(obj.avatar)
      ..writeByte(14)
      ..write(obj.enableFCM)
      ..writeByte(15)
      ..write(obj.deviceID)
      ..writeByte(16)
      ..write(obj.typeRegister)
      ..writeByte(17)
      ..write(obj.phone)
      ..writeByte(18)
      ..write(obj.role)
      ..writeByte(19)
      ..write(obj.createdAt)
      ..writeByte(20)
      ..write(obj.updatedAt)
      ..writeByte(21)
      ..write(obj.id)
      ..writeByte(22)
      ..write(obj.username)
      ..writeByte(23)
      ..write(obj.dateOfBirth)
      ..writeByte(24)
      ..write(obj.idProvince)
      ..writeByte(25)
      ..write(obj.idDistrict)
      ..writeByte(26)
      ..write(obj.idVillage)
      ..writeByte(27)
      ..write(obj.latLong)
      ..writeByte(28)
      ..write(obj.statitisReviews)
      ..writeByte(29)
      ..write(obj.numberOfSale);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
