import 'package:template/data/model/address/address_response.dart';

import '../../../helper/izi_validate.dart';

class AddressRequest extends AddressResponse {
  AddressRequest({bool? isDefault}):super(isDefault: isDefault);
  AddressRequest.fromJson(Map<String, dynamic> json) : super.fromJson(json);

  ///
  /// To JSON
  ///
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    if (!IZIValidate.nullOrEmpty(user?.id)) data['user'] = user?.id;
    return data;
  }
}
