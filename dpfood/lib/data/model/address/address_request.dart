// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:template/data/model/address/address_reponse.dart';

class AddressRequest extends AddressResponse {
  AddressRequest();
  AddressRequest.fromJson(Map<String, dynamic> json) : super.fromJson(json);

  ///
  /// To JSON
  ///
  @override
  Map<String, dynamic> toJson() {
    print("Con nè");
    final Map<String, dynamic> data = super.toJson();
    return data;
  }
}
