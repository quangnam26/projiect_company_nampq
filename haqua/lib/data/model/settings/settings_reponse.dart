import '../../../helper/izi_date.dart';
import '../../../helper/izi_validate.dart';

class SettingResponse {
  String? id;
  String? feeAppPercent;
  String? policyContent;
  String? shareContent;
  String? quizPassPercent;
  String? vnPay;
  String? moMo;
  String? phone;
  String? bankAccountName;
  String? bankAccountNumber;
  String? branchName;
  String? bankName;
  DateTime? createdAt;
  DateTime? updatedAt;
  SettingResponse({
    this.id,
    this.feeAppPercent,
    this.policyContent,
    this.shareContent,
    this.quizPassPercent,
    this.vnPay,
    this.moMo,
    this.phone,
    this.bankAccountName,
    this.bankAccountNumber,
    this.branchName,
    this.bankName,
    this.createdAt,
    this.updatedAt,
  });

  ///
  /// From JSON
  ///
  SettingResponse.fromJson(Map<String, dynamic> json) {
    id = !IZIValidate.nullOrEmpty(json['_id']) ? json['_id'].toString() : null;
    feeAppPercent = !IZIValidate.nullOrEmpty(json['feeAppPercent']) ? json['feeAppPercent'].toString() : null;
    policyContent = !IZIValidate.nullOrEmpty(json['policyContent']) ? json['policyContent'].toString() : null;
    shareContent = !IZIValidate.nullOrEmpty(json['shareContent']) ? json['shareContent'].toString() : null;
    quizPassPercent = !IZIValidate.nullOrEmpty(json['quizPassPercent']) ? json['quizPassPercent'].toString() : null;
    vnPay = !IZIValidate.nullOrEmpty(json['vnPay']) ? json['_ivnPayd'].toString() : null;
    moMo = !IZIValidate.nullOrEmpty(json['momo']) ? json['momo'].toString() : null;
    phone = !IZIValidate.nullOrEmpty(json['phone']) ? json['phone'].toString() : null;
    bankAccountName = !IZIValidate.nullOrEmpty(json['bankAccountName']) ? json['bankAccountName'].toString() : null;
    bankAccountNumber = !IZIValidate.nullOrEmpty(json['bankAccountNumber']) ? json['bankAccountNumber'].toString() : null;
    branchName = !IZIValidate.nullOrEmpty(json['branchName']) ? json['branchName'].toString() : null;
    bankName = !IZIValidate.nullOrEmpty(json['bankName']) ? json['bankName'].toString() : null;
    createdAt = !IZIValidate.nullOrEmpty(json['createdAt']) ? IZIDate.parse(json['createdAt'].toString()) : null;
    updatedAt = !IZIValidate.nullOrEmpty(json['updatedAt']) ? IZIDate.parse(json['updatedAt'].toString()) : null;
  }
}
