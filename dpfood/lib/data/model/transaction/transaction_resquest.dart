// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';

class TransactionRequest {
  String? id;
  String? idUser;
  String? methodTransaction;
  String? statusTransaction;
  String? typeTransaction;
  String? title;
  int? money;
  String? transactionImage;
  String? content;
  TransactionRequest({
    this.id,
    this.idUser,
    this.methodTransaction,
    this.statusTransaction,
    this.typeTransaction,
    this.title,
    this.money,
    this.transactionImage,
    this.content,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (!IZIValidate.nullOrEmpty(id)) '_id': id,
      if (!IZIValidate.nullOrEmpty(idUser)) 'idUser': idUser,
      if (!IZIValidate.nullOrEmpty(methodTransaction))
        'methodTransaction': methodTransaction,
      if (!IZIValidate.nullOrEmpty(statusTransaction))
        'statusTransaction': statusTransaction,
      if (!IZIValidate.nullOrEmpty(typeTransaction))
        'typeTransaction': typeTransaction,
      if (!IZIValidate.nullOrEmpty(title)) 'title': title,
      if (!IZIValidate.nullOrEmpty(money)) 'money': money,
      if (!IZIValidate.nullOrEmpty(transactionImage))
        'transactionImage': transactionImage,
      if (!IZIValidate.nullOrEmpty(content)) 'content': content,
    };
  }

  factory TransactionRequest.fromMap(Map<String, dynamic> map) {
    return TransactionRequest(
      id: map['_id'] != null ? map['_id'] as String : null,
      idUser: map['idUser'] != null ? map['idUser'] as String : null,
      methodTransaction: map['methodTransaction'] != null
          ? map['methodTransaction'] as String
          : null,
      statusTransaction: map['statusTransaction'] != null
          ? map['statusTransaction'] as String
          : null,
      typeTransaction: map['typeTransaction'] != null
          ? map['typeTransaction'] as String
          : null,
      title: map['title'] != null ? map['title'] as String : null,
      money: map['money'] != null ? IZINumber.parseInt(map['money']) : null,
      transactionImage: map['transactionImage'] != null
          ? map['transactionImage'] as String
          : null,
      content: map['content'] != null ? map['content'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionRequest.fromJson(String source) =>
      TransactionRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
