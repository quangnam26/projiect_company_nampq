import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_validate.dart';

import '../../../helper/izi_number.dart';
import '../subspecialize/subspecialize_response.dart';

class CertificateResponse {
  String? id;
  SubSpecializeResponse? idSubSpecialize;
  String? title;
  String? content;
  String? thumbnail;
  String? banner;
  double? level;
  int? timeOut;
  double? percent;
  DateTime? createdAt;
  DateTime? updatedAt;
  CertificateResponse({
    this.idSubSpecialize,
    this.title,
    this.content,
    this.thumbnail,
    this.banner,
    this.level,
    this.timeOut,
    this.percent,
    this.createdAt,
    this.updatedAt,
  });

  ///
  /// From JSON
  ///
  CertificateResponse.fromJson(Map<String, dynamic> json) {
    id = !IZIValidate.nullOrEmpty(json['_id']) ? json['_id'].toString() : null;
    if (json['idSubSpecialize'] != null && json['idSubSpecialize'].toString().length != 24) {
      idSubSpecialize = SubSpecializeResponse.fromJson(json['idSubSpecialize'] as Map<String, dynamic>);
    }
    title = !IZIValidate.nullOrEmpty(json['title']) ? json['title'].toString() : null;
    content = !IZIValidate.nullOrEmpty(json['content']) ? json['content'].toString() : null;
    thumbnail = !IZIValidate.nullOrEmpty(json['thumbnail']) ? json['thumbnail'].toString() : null;
    banner = !IZIValidate.nullOrEmpty(json['banner']) ? json['banner'].toString() : null;
    level = !IZIValidate.nullOrEmpty(json['level']) ? double.tryParse(json['level'].toString()) : 0.0;
    timeOut = !IZIValidate.nullOrEmpty(json['timeout']) ? int.tryParse(json['timeout'].toString()) : 0;
    percent = !IZIValidate.nullOrEmpty(json['percent']) ? IZINumber.parseDouble(json['percent'].toString()) : 0.0;
    createdAt = !IZIValidate.nullOrEmpty(json['createdAt']) ? IZIDate.parse(json['createdAt'].toString()) : null;
    updatedAt = !IZIValidate.nullOrEmpty(json['updatedAt']) ? IZIDate.parse(json['updatedAt'].toString()) : null;
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (!IZIValidate.nullOrEmpty(id)) data['_id'] = id;
    if (!IZIValidate.nullOrEmpty(idSubSpecialize)) data['idSubSpecialize'] = idSubSpecialize;
    if (!IZIValidate.nullOrEmpty(title)) data['title'] = title;
    if (!IZIValidate.nullOrEmpty(content)) data['content'] = content;
    if (!IZIValidate.nullOrEmpty(thumbnail)) data['thumbnail'] = thumbnail;
    if (!IZIValidate.nullOrEmpty(banner)) data['banner'] = banner;
    if (!IZIValidate.nullOrEmpty(level)) data['level'] = level;
    if (!IZIValidate.nullOrEmpty(timeOut)) data['timeout'] = timeOut;
    if (!IZIValidate.nullOrEmpty(percent)) data['percent'] = percent;
    if (!IZIValidate.nullOrEmpty(updatedAt)) data['createdAt'] = createdAt;
    if (!IZIValidate.nullOrEmpty(updatedAt)) data['updatedAt'] = updatedAt;

    return data;
  }
}
