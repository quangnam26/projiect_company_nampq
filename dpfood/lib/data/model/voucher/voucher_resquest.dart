// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:template/data/model/voucher/voucher_response.dart';
import 'package:template/helper/izi_validate.dart';

class VoucherRequest extends VoucherResponse {
  String? idUser;
  VoucherRequest({
    this.idUser,
  });
  VoucherRequest.fromJson(Map<String, dynamic> json) : super.fromJson(json);

  ///
  /// To JSON
  ///
  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = super.toJson();
    if (!IZIValidate.nullOrEmpty(idUser)) data['idUser'] = idUser;
    if (!IZIValidate.nullOrEmpty(idCategory)) data['idCategory'] = idCategory!.id;
    if (!IZIValidate.nullOrEmpty(idUserShop)) data['idUserShop'] = idUserShop!.id;
    return data;
  }
}
