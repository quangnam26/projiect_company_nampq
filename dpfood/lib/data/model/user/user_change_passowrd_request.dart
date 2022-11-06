import 'dart:convert';

import '../../../helper/izi_validate.dart';

class UserChangePasswordRequest {
  String? idUser;
  String? oldPassword;
  String? newPassword;

  UserChangePasswordRequest({
    this.idUser,
    this.oldPassword,
    this.newPassword,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (!IZIValidate.nullOrEmpty(idUser)) 'idUser': idUser,
      if (!IZIValidate.nullOrEmpty(oldPassword)) 'oldPassword': oldPassword,
      if (!IZIValidate.nullOrEmpty(newPassword)) 'newPassword': newPassword,
    };
  }

  factory UserChangePasswordRequest.fromMap(Map<String, dynamic> map) {
    return UserChangePasswordRequest(
      idUser: map['idUser'] != null ? map['idUser'] as String : null,
      oldPassword:
          map['oldPassword'] != null ? map['oldPassword'] as String : null,
      newPassword:
          map['newPassword'] != null ? map['newPassword'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserChangePasswordRequest.fromJson(String source) =>
      UserChangePasswordRequest.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
