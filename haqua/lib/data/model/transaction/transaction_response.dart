import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';

class TransactionResponse {
  String? id;
  String? idUser;
  String? methodTransaction;
  String? statusTransaction;
  String? typeTransaction;
  String? title;
  String? content;
  int? money;
  String? transactionImage;
  DateTime? createdAt;
  DateTime? updatedAt;
  TransactionResponse({
    this.id,
    this.idUser,
    this.methodTransaction,
    this.statusTransaction,
    this.typeTransaction,
    this.title,
    this.money,
    this.content,
    this.transactionImage,
    this.createdAt,
    this.updatedAt,
  });

  ///
  /// From JSON
  ///
  TransactionResponse.fromJson(Map<String, dynamic> json) {
    id = !IZIValidate.nullOrEmpty(json['_id']) ? json['_id'].toString() : null;
    idUser = !IZIValidate.nullOrEmpty(json['idUser']) ? json['idUser'].toString() : null;
    methodTransaction = !IZIValidate.nullOrEmpty(json['methodTransaction']) ? json['methodTransaction'].toString() : null;
    statusTransaction = !IZIValidate.nullOrEmpty(json['statusTransaction']) ? json['statusTransaction'].toString() : null;
    typeTransaction = !IZIValidate.nullOrEmpty(json['typeTransaction']) ? json['typeTransaction'].toString() : null;
    content = !IZIValidate.nullOrEmpty(json['content']) ? json['content'].toString() : null;
    title = !IZIValidate.nullOrEmpty(json['title']) ? json['title'].toString() : null;
    money = !IZIValidate.nullOrEmpty(json['money']) ? IZINumber.parseInt(json['money'].toString()) : null;
    transactionImage = !IZIValidate.nullOrEmpty(json['transactionImage']) ? json['transactionImage'].toString() : null;
    createdAt = !IZIValidate.nullOrEmpty(json['createdAt']) ? IZIDate.parse(json['createdAt'].toString()) : null;
    updatedAt = !IZIValidate.nullOrEmpty(json['updatedAt']) ? IZIDate.parse(json['updatedAt'].toString()) : null;
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (!IZIValidate.nullOrEmpty(id)) data['_id'] = title;
    if (!IZIValidate.nullOrEmpty(idUser)) data['idUser'] = idUser;
    if (!IZIValidate.nullOrEmpty(methodTransaction)) data['methodTransaction'] = methodTransaction;
    if (!IZIValidate.nullOrEmpty(statusTransaction)) data['statusTransaction'] = statusTransaction;
    if (!IZIValidate.nullOrEmpty(typeTransaction)) data['typeTransaction'] = typeTransaction;
    if (!IZIValidate.nullOrEmpty(title)) data['title'] = title;
    if (!IZIValidate.nullOrEmpty(content)) data['content'] = content;
    if (!IZIValidate.nullOrEmpty(money)) data['money'] = money;
    if (!IZIValidate.nullOrEmpty(transactionImage)) {
      data['transactionImage'] = transactionImage;
    }
    if (!IZIValidate.nullOrEmpty(updatedAt)) data['createdAt'] = createdAt;
    if (!IZIValidate.nullOrEmpty(updatedAt)) data['updatedat'] = updatedAt;
    return data;
  }

  @override
  String toString() {
    return 'TransactionResponse(id: $id, idUser: $idUser, methodTransaction: $methodTransaction, statusTransaction: $statusTransaction, typeTransaction: $typeTransaction, title: $title, content: $content, money: $money, transactionImage: $transactionImage, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
