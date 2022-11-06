import 'package:template/data/model/experience/experience_response.dart';
import 'package:template/data/model/province/province_response.dart';
import 'package:template/data/model/statistic_review/statistic_review_response.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';

class UserResponse {
  String? id;
  String? phone;
  String? password;
  String? otpCode;
  String? typeRegister;
  String? tokenLogin;
  String? accessToken;
  String? refreshToken;
  String? deviceId;
  String? avatar;
  String? fullName;
  DateTime? born;
  String? gender;
  String? address;
  ProvinceResponse? idProvince;
  String? nation;
  String? job;
  List<ExperienceResponse>? experiences;
  List<dynamic>? capacity;
  List<dynamic>? myAlbum;
  int? defaultAccount;
  String? bankName;
  String? branchName;
  String? bankAccountNumber;
  String? bankAccountName;
  bool? enableFCM;
  List<String>? certificates;
  StatisticReviewResponse? statisticReview;
  bool? deleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  UserResponse({
    this.id,
    this.phone,
    this.password,
    this.otpCode,
    this.typeRegister,
    this.tokenLogin,
    this.accessToken,
    this.refreshToken,
    this.deviceId,
    this.avatar,
    this.fullName,
    this.born,
    this.gender,
    this.address,
    this.nation,
    this.job,
    this.experiences,
    this.capacity,
    this.myAlbum,
    this.defaultAccount,
    this.bankName,
    this.branchName,
    this.bankAccountNumber,
    this.bankAccountName,
    this.enableFCM,
    this.certificates,
    this.statisticReview,
    this.deleted,
    this.createdAt,
    this.updatedAt,
  });

  ///
  /// From JSON
  ///
  UserResponse.fromJson(Map<String, dynamic> json) {
    id = !IZIValidate.nullOrEmpty(json['_id']) ? json['_id'].toString() : null;
    phone = !IZIValidate.nullOrEmpty(json['phone']) ? json['phone'].toString() : null;
    password = !IZIValidate.nullOrEmpty(json['password']) ? json['password'].toString() : null;
    otpCode = !IZIValidate.nullOrEmpty(json['otpCode']) ? json['otpCode'].toString() : null;
    typeRegister = !IZIValidate.nullOrEmpty(json['typeRegister']) ? json['typeRegister'].toString() : null;
    tokenLogin = !IZIValidate.nullOrEmpty(json['tokenLogin']) ? json['tokenLogin'].toString() : null;
    refreshToken = !IZIValidate.nullOrEmpty(json['refreshToken']) ? json['refreshToken'].toString() : null;
    deviceId = !IZIValidate.nullOrEmpty(json['deviceID']) ? json['deviceID'].toString() : null;
    avatar = !IZIValidate.nullOrEmpty(json['avatar']) ? json['avatar'].toString() : null;
    fullName = !IZIValidate.nullOrEmpty(json['fullName']) ? json['fullName'].toString() : null;
    born = !IZIValidate.nullOrEmpty(json['born']) ? DateTime.fromMicrosecondsSinceEpoch(IZINumber.parseInt(json['born'].toString())) : null;
    gender = !IZIValidate.nullOrEmpty(json['gender']) ? json['gender'].toString() : null;
    address = !IZIValidate.nullOrEmpty(json['address']) ? json['address'].toString() : null;

    nation = !IZIValidate.nullOrEmpty(json['nation']) ? json['nation'].toString() : null;
    job = !IZIValidate.nullOrEmpty(json['job']) ? json['job'].toString() : null;
    if (json['experiences'] != null && json['experiences'].toString().length != 24) {
      experiences = (json['experiences'] as List<dynamic>).map((e) => ExperienceResponse.fromJson(e as Map<String, dynamic>)).toList();
    } else {
      experiences = null;
    }
    capacity = !IZIValidate.nullOrEmpty(json['capacity']) ? json['capacity'] as List<dynamic> : null;
    myAlbum = !IZIValidate.nullOrEmpty(json['myAlbum']) ? json['myAlbum'] as List<dynamic> : null;
    defaultAccount = !IZIValidate.nullOrEmpty(json['defaultAccount']) ? IZINumber.parseInt(json['defaultAccount'].toString()) : 0;
    bankName = !IZIValidate.nullOrEmpty(json['bankName']) ? json['bankName'].toString() : null;
    branchName = !IZIValidate.nullOrEmpty(json['branchName']) ? json['branchName'].toString() : null;
    bankAccountNumber = !IZIValidate.nullOrEmpty(json['bankAccountNumber']) ? json['bankAccountNumber'].toString() : null;
    bankAccountName = !IZIValidate.nullOrEmpty(json['bankAccountName']) ? json['bankAccountName'].toString() : null;
    if (!IZIValidate.nullOrEmpty(json['enableFCM'])) {
      enableFCM = json['enableFCM'] as bool;
    } else {
      enableFCM = true;
    }
    if (json['statiticReview'] != null && json['statiticReview'].toString().length != 24) {
      statisticReview = StatisticReviewResponse.fromJson(json['statiticReview'] as Map<String, dynamic>);
    }
    if (json['idProvince'] != null && json['idProvince'].toString().length != 24) {
      idProvince = ProvinceResponse.fromJson(json['idProvince'] as Map<String, dynamic>);
    }
    certificates = !IZIValidate.nullOrEmpty(json['certificates']) ? json['certificates'] as List<String> : null;

    if (!IZIValidate.nullOrEmpty(json['deleted'])) {
      deleted = json['deleted'] as bool;
    } else {
      deleted = false;
    }
    createdAt = !IZIValidate.nullOrEmpty(json['createdAt']) ? IZIDate.parse(json['createdAt'].toString()).toLocal() : null;
    updatedAt = !IZIValidate.nullOrEmpty(json['updatedAt']) ? IZIDate.parse(json['updatedAt'].toString()).toLocal() : null;
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (!IZIValidate.nullOrEmpty(id)) data['_id'] = id;
    if (!IZIValidate.nullOrEmpty(phone)) data['phone'] = phone;
    if (!IZIValidate.nullOrEmpty(password)) data['password'] = password;
    if (!IZIValidate.nullOrEmpty(otpCode)) data['otpCode'] = otpCode;
    if (!IZIValidate.nullOrEmpty(typeRegister)) {
      data['typeRegister'] = typeRegister;
    }
    if (!IZIValidate.nullOrEmpty(tokenLogin)) data['tokenLogin'] = tokenLogin;
    if (!IZIValidate.nullOrEmpty(refreshToken)) {
      data['refreshToken'] = refreshToken;
    }
    if (!IZIValidate.nullOrEmpty(deviceId)) data['deviceID'] = deviceId;
    if (!IZIValidate.nullOrEmpty(avatar)) data['avatar'] = avatar;
    if (!IZIValidate.nullOrEmpty(fullName)) data['fullName'] = fullName;
    if (!IZIValidate.nullOrEmpty(born)) data['born'] = born;
    if (!IZIValidate.nullOrEmpty(gender)) data['gender'] = gender;
    if (!IZIValidate.nullOrEmpty(address)) data['address'] = address;
    if (!IZIValidate.nullOrEmpty(idProvince)) data['idProvince'] = idProvince;
    if (!IZIValidate.nullOrEmpty(nation)) data['nation'] = nation;
    if (!IZIValidate.nullOrEmpty(job)) data['job'] = job;
    data['experiences'] = experiences;
    data['capacity'] = capacity;
    data['myAlbum'] = myAlbum;
    if (!IZIValidate.nullOrEmpty(defaultAccount)) data['defaultAccount'] = defaultAccount;
    if (!IZIValidate.nullOrEmpty(bankName)) data['bankName'] = bankName;
    if (!IZIValidate.nullOrEmpty(branchName)) data['branchName'] = branchName;
    if (!IZIValidate.nullOrEmpty(bankAccountNumber)) data['bankAccountNumber'] = bankAccountNumber;
    if (!IZIValidate.nullOrEmpty(bankAccountName)) data['bankAccountName'] = bankAccountName;
    if (!IZIValidate.nullOrEmpty(enableFCM)) data['enableFCM'] = enableFCM;
    if (!IZIValidate.nullOrEmpty(certificates)) data['certificates'] = certificates;
    if (!IZIValidate.nullOrEmpty(statisticReview)) data['statiticReview'] = statisticReview;
    if (!IZIValidate.nullOrEmpty(deleted)) data['deleted'] = deleted;
    if (!IZIValidate.nullOrEmpty(createdAt)) data['createdAt'] = createdAt;
    if (!IZIValidate.nullOrEmpty(updatedAt)) data['updatedAt'] = updatedAt;

    return data;
  }

  @override
  String toString() {
    return 'UserResponse(id: $id, phone: $phone, password: $password, otpCode: $otpCode, typeRegister: $typeRegister, tokenLogin: $tokenLogin, accessToken: $accessToken, refreshToken: $refreshToken, deviceId: $deviceId, avatar: $avatar, fullName: $fullName, born: $born, gender: $gender, address: $address, idProvince: $idProvince, nation: $nation, job: $job, experiences: $experiences, capacity: $capacity, myAlbum: $myAlbum, defaultAccount: $defaultAccount, bankName: $bankName, branchName: $branchName, bankAccountNumber: $bankAccountNumber, bankAccountName: $bankAccountName, enableFCM: $enableFCM, certificates: $certificates, statisticReview: $statisticReview, deleted: $deleted, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
