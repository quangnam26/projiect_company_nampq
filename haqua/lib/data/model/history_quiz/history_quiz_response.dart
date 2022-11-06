import '../../../helper/izi_date.dart';
import '../../../helper/izi_number.dart';
import '../../../helper/izi_validate.dart';
import '../certificate/certificate_response.dart';
import '../user/user_response.dart';

class HistoryQuizResponse {
  String? id;
  int? numberTest;
  double? percent;
  int? totalPoint;
  int? point;
  UserResponse? idUser;
  CertificateResponse? idCertificate;
  String? idUserRequest;
  String? idCertificateRequest;
  DateTime? createdAt;
  DateTime? updatedAt;

  HistoryQuizResponse({
    this.id,
    this.numberTest,
    this.percent,
    this.totalPoint,
    this.point,
    this.idUser,
    this.idCertificate,
    this.idUserRequest,
    this.idCertificateRequest,
    this.createdAt,
    this.updatedAt,
  });

  ///
  /// From JSON
  ///
  HistoryQuizResponse.fromJson(Map<String, dynamic> json) {
    id = !IZIValidate.nullOrEmpty(json['_id']) ? json['_id'].toString() : null;
    numberTest = !IZIValidate.nullOrEmpty(json['numberTest']) ? IZINumber.parseInt(json['numberTest'].toString()) : 0;
    percent = !IZIValidate.nullOrEmpty(json['percent']) ? IZINumber.parseDouble(json['percent'].toString()) : 0.0;
    totalPoint = !IZIValidate.nullOrEmpty(json['totalPoint']) ? IZINumber.parseInt(json['totalPoint'].toString()) : 0;
    point = !IZIValidate.nullOrEmpty(json['point']) ? IZINumber.parseInt(json['point'].toString()) : 0;
    if (json['idUser'] != null && json['idUser'].toString().length != 24) {
      idUser = UserResponse.fromJson(json['idUser'] as Map<String, dynamic>);
    }
    if (json['idCertificate'] != null && json['idCertificate'].toString().length != 24) {
      idCertificate = CertificateResponse.fromJson(json['idCertificate'] as Map<String, dynamic>);
    }
    createdAt = !IZIValidate.nullOrEmpty(json['createdAt']) ? IZIDate.parse(json['createdAt'].toString()) : null;
    updatedAt = !IZIValidate.nullOrEmpty(json['updatedAt']) ? IZIDate.parse(json['updatedAt'].toString()) : null;
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (!IZIValidate.nullOrEmpty(id)) data['_id'] = id;
    if (!IZIValidate.nullOrEmpty(numberTest)) data['numberTest'] = numberTest;
    if (!IZIValidate.nullOrEmpty(idUserRequest)) data['idUser'] = idUserRequest;
    if (!IZIValidate.nullOrEmpty(idCertificateRequest)) data['idCertificate'] = idCertificateRequest;
    if (!IZIValidate.nullOrEmpty(percent)) data['percent'] = percent;
    if (!IZIValidate.nullOrEmpty(totalPoint)) data['totalPoint'] = totalPoint;
    if (!IZIValidate.nullOrEmpty(point)) data['point'] = point;
    if (!IZIValidate.nullOrEmpty(idUser)) data['idUser'] = idUser;
    if (!IZIValidate.nullOrEmpty(idCertificate)) data['idCertificate'] = idCertificate;
    if (!IZIValidate.nullOrEmpty(createdAt)) data['createdAt'] = createdAt;
    if (!IZIValidate.nullOrEmpty(updatedAt)) data['updatedAt'] = updatedAt;

    return data;
  }

  @override
  String toString() {
    return 'HistoryQuizResponse(id: $id, numberTest: $numberTest, percent: $percent, totalPoint: $totalPoint, point: $point, idUser: $idUser, idCertificate: $idCertificate, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
