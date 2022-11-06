// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TransactionResponse {
  String? id;
  String? methodTransaction;
  String? statusTransaction;
  String? typeTransaction;
  String? title;
  String? money;
  String? transactionImage;
  String? content;
  String? createdAt;
  String? updatedAt;
  TransactionResponse({
    this.id,
    this.methodTransaction,
    this.statusTransaction,
    this.typeTransaction,
    this.title,
    this.money,
    this.transactionImage,
    this.content,
    this.createdAt,
    this.updatedAt,
  });

  TransactionResponse.fromJson(Map<String, dynamic> json) {
    id = (json['_id'] == null) ? null : json['_id'].toString();
    methodTransaction = json['methodTransaction'].toString();
    statusTransaction = json['statusTransaction'].toString();
    typeTransaction = json['typeTransaction'].toString();
    title = json['title'].toString();
    money = json['money'].toString();
    transactionImage = json['transactionImage'].toString();
    content = json['content'].toString();
    createdAt = json['createdAt'].toString();
    updatedAt = json['createdAt'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (id != null) data['id'] = id;

    if (methodTransaction != null)
      data['methodTransaction'] = methodTransaction;

    if (statusTransaction != null)
      data['statusTransaction'] = statusTransaction;

    if (typeTransaction != null) data['typeTransaction'] = typeTransaction;
    if (title != null) data['title'] = title;
    if (money != null) data['money'] = money;
    if (transactionImage != null) data['transactionImage'] = transactionImage;
    if (content != null) data['content'] = content;
    return data;
  }
}
