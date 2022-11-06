import 'package:template/data/model/transaction/transaction_response.dart';

class TransactionRequest extends TransactionResponse {
  TransactionRequest();
  TransactionRequest.fromJson(Map<String, dynamic> json) : super.fromJson(json);
}
