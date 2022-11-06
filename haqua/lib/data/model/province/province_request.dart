import 'package:template/data/model/province/province_response.dart';

class ProvinceRequest extends ProvinceResponse {
  ProvinceRequest();
  ProvinceRequest.fromJson(Map<String, dynamic> json) : super.fromJson(json);

  // @override
  // Map<String, dynamic> toJson() {
  //   final data = super.toJson();
  //   data['idKey'] = "New";
  //   return data;
  // }
}
