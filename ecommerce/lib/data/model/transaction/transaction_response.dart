
import '../../../helper/izi_number.dart';
import '../../../helper/izi_validate.dart';

class TransactionResponse {
  String? id;
  String? idUser;
  String? methoadTransaction;
  String? statusTransaction;
  String? typeTransaction;
  String? title;
  int? money;
  String? tracsactionImage;
  String? content;
  String? createdAt;
  String? updatedAt;
  TransactionResponse({
    this.id,
    this.idUser,
    this.methoadTransaction,
    this.statusTransaction,
    this.typeTransaction,
    this.title,
    this.money,
    this.tracsactionImage,
    this.content,
    this.createdAt,
    this.updatedAt,
  });

  TransactionResponse.fromJson(Map<String, dynamic> json) {
    id = (json['_id'] == null) ? null : json['_id'] as String;
    idUser = (json['createdAt'] == null) ? null : json['createdAt'].toString();
    methoadTransaction = (json['methoadTransaction'] == null)
        ? null
        : json['methoadTransaction'].toString();
    typeTransaction = (json['typeTransaction'] == null)
        ? null
        : json['typeTransaction'].toString();
    statusTransaction = (json['statusTransaction'] == null)
        ? null
        : json['statusTransaction'].toString();
    title = (json['title'] == null) ? null : json['title'].toString();
    money = IZIValidate.nullOrEmpty(json['money'])
        ? null
        : IZINumber.parseInt(json['money']);

    tracsactionImage = (json['tracsactionImage'] == null)
        ? null
        : json['tracsactionImage'].toString();
    content = (json['content'] == null) ? null : json['content'].toString();
    createdAt =
        (json['createdAt'] == null) ? null : json['createdAt'].toString();
    updatedAt = (json['updatedAt'] == null)
        ? null
        : json['creaupdatedAttedAt'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (!IZIValidate.nullOrEmpty(id)) data['_id'] = id;
    if (!IZIValidate.nullOrEmpty(idUser)) data['idUser'] = idUser;
    if (!IZIValidate.nullOrEmpty(methoadTransaction)) {
      data['methoadTransaction'] = methoadTransaction;
    }
    if (!IZIValidate.nullOrEmpty(statusTransaction)) {
      data['statusTransaction'] = statusTransaction;
    }
    if (!IZIValidate.nullOrEmpty(typeTransaction)) {
      data['typeTransaction'] = typeTransaction;
    }
    if (!IZIValidate.nullOrEmpty(title)) data['title'] = title;
    if (!IZIValidate.nullOrEmpty(money)) data['money'] = money;
    if (!IZIValidate.nullOrEmpty(tracsactionImage)) {
      data['tracsactionImage'] = tracsactionImage;
    }
    if (!IZIValidate.nullOrEmpty(content)) data['content'] = content;
    if (!IZIValidate.nullOrEmpty(createdAt)) data['createdAt'] = createdAt;
    if (!IZIValidate.nullOrEmpty(updatedAt)) data['updatedAt'] = updatedAt;
    return data;
  }
}
