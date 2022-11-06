
import '../../../helper/izi_number.dart';
import '../../../helper/izi_validate.dart';

class TransactionRequest {
  String? id;
  String? idUser;
  String? methoadTransaction;
  String? statusTransaction;
  String? typeTransaction;
  String? title;
  int? money;
  String? transactionImage;
  String? content;
  String? createdAt;
  String? updatedAt;
  TransactionRequest({
    this.id,
    this.idUser,
    this.methoadTransaction,
    this.statusTransaction,
    this.typeTransaction,
    this.title,
    this.money,
    this.transactionImage,
    this.content,
    this.createdAt,
    this.updatedAt,
  });

  TransactionRequest.fromJson(Map<String, dynamic> json) {
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

    transactionImage = (json['transactionImage'] == null)
        ? null
        : json['transactionImage'].toString();
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
    if (!IZIValidate.nullOrEmpty(transactionImage))data['transactionImage'] = transactionImage;
    if (!IZIValidate.nullOrEmpty(content)) data['content'] = content;
    if (!IZIValidate.nullOrEmpty(createdAt)) data['createdAt'] = createdAt;
    if (!IZIValidate.nullOrEmpty(updatedAt)) data['updatedAt'] = updatedAt;
    return data;
  }

  // TransactionRequest.fromJson(Map<String, dynamic> json) : super.fromJson(json);

  // ///
  // /// To JSON
  // ///
  // @override
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = super.toJson();
  //   return data;
  // }
}
