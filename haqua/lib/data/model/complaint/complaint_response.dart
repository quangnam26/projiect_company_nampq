import 'package:template/data/model/user/user_response.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';

class ComplaintResponse {
  UserResponse? idUser;
  String? content;
  int? status;
  DateTime? createdAt;
  ComplaintResponse({
    this.idUser,
    this.content,
    this.status,
    this.createdAt,
  });

  ///
  /// From JSON
  ///
  ComplaintResponse.fromJson(Map<String, dynamic> json) {
    if (json['idUser'] != null && json['idUser'].toString().length != 24) {
      idUser = UserResponse.fromJson(json['idUser'] as Map<String, dynamic>);
    }
    content = !IZIValidate.nullOrEmpty(json['content']) ? json['content'].toString() : null;
    status = !IZIValidate.nullOrEmpty(json['status']) ? IZINumber.parseInt(json['status'].toString()) : null;
    createdAt = !IZIValidate.nullOrEmpty(json['createdAt']) ? IZIDate.parse(json['createdAt'].toString()) : null;
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (!IZIValidate.nullOrEmpty(content)) data['content'] = content;
    if (!IZIValidate.nullOrEmpty(status)) data['status'] = status;
    if (!IZIValidate.nullOrEmpty(createdAt)) data['createdAt'] = createdAt;

    return data;
  }
}
