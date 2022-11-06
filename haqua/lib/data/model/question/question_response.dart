import 'package:template/data/model/answer/answer_response.dart';
import 'package:template/data/model/complaint/complaint_response.dart';
import 'package:template/data/model/subspecialize/subspecialize_response.dart';
import 'package:template/data/model/user/user_response.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';

class QuestionResponse {
  String? id;
  UserResponse? idUser;
  SubSpecializeResponse? idSubSpecialize;
  String? content;
  List<dynamic>? attachImages;
  List<dynamic>? attachFiles;
  String? hashTag;
  int? moneyFrom;
  int? moneyTo;
  String? priorityLanguage;
  String? priorityGender;
  String? priorityRegion;
  String? priorityExperience;
  String? priorityExpert;
  String? priorityRank;
  int? totalTime;
  int? timeUsed;
  List<String>? historyTimeUsed;
  String? statusPayment;
  String? statusQuestion;
  List<AnswerResponse>? answerList;
  AnswerResponse? answerer;
  int? finalPrice;
  String? comment;
  List<ComplaintResponse>? complains;
  String? denounce;
  List<String>? linkRecords;
  String? statusShare;
  int? mySharePrice;
  int? partnerSharePrice;
  String? denounceBy;
  DateTime? createdAt;
  DateTime? updatedAt;
  QuestionResponse({
    this.id,
    this.idUser,
    this.idSubSpecialize,
    this.content,
    this.attachImages,
    this.attachFiles,
    this.hashTag,
    this.moneyFrom,
    this.moneyTo,
    this.priorityLanguage,
    this.priorityGender,
    this.priorityRegion,
    this.priorityExperience,
    this.priorityExpert,
    this.priorityRank,
    this.totalTime,
    this.timeUsed,
    this.historyTimeUsed,
    this.statusPayment,
    this.statusQuestion,
    this.answerList,
    this.finalPrice,
    this.comment,
    this.complains,
    this.denounce,
    this.linkRecords,
    this.statusShare,
    this.mySharePrice,
    this.partnerSharePrice,
    this.denounceBy,
    this.createdAt,
    this.updatedAt,
  });

  ///
  /// From JSON
  ///

  QuestionResponse.fromJson(Map<String, dynamic> json) {
    id = !IZIValidate.nullOrEmpty(json['_id']) ? json['_id'].toString() : null;
    if (json['idUser'] != null && json['idUser'].toString().length != 24) {
      idUser = UserResponse.fromJson(json['idUser'] as Map<String, dynamic>);
    }
    if (json['idSubSpecialize'] != null && json['idSubSpecialize'].toString().length != 24) {
      idSubSpecialize = SubSpecializeResponse.fromJson(json['idSubSpecialize'] as Map<String, dynamic>);
    }
    content = !IZIValidate.nullOrEmpty(json['content']) ? json['content'].toString() : null;
    attachImages = !IZIValidate.nullOrEmpty(json['attachImages']) ? json['attachImages'] as List<dynamic> : null;
    attachFiles = !IZIValidate.nullOrEmpty(json['attachFiles']) ? json['attachFiles'] as List<dynamic> : null;
    hashTag = !IZIValidate.nullOrEmpty(json['hashTag']) ? json['hashTag'].toString() : null;
    moneyFrom = !IZIValidate.nullOrEmpty(json['moneyFrom']) ? IZINumber.parseInt(json['moneyFrom'].toString()) : null;
    moneyTo = !IZIValidate.nullOrEmpty(json['moneyTo']) ? IZINumber.parseInt(json['moneyTo'].toString()) : null;
    priorityLanguage = !IZIValidate.nullOrEmpty(json['priorityLanguage']) ? json['priorityLanguage'].toString() : null;
    priorityGender = !IZIValidate.nullOrEmpty(json['priorityGender']) ? json['priorityGender'].toString() : null;
    priorityRegion = !IZIValidate.nullOrEmpty(json['priorityRegion']) ? json['priorityRegion'].toString() : null;
    priorityExperience = !IZIValidate.nullOrEmpty(json['priorityExperience']) ? json['priorityExperience'].toString() : null;
    priorityExpert = !IZIValidate.nullOrEmpty(json['priorityExpert']) ? json['priorityExpert'].toString() : null;
    priorityRank = !IZIValidate.nullOrEmpty(json['priorityRank']) ? json['priorityRank'].toString() : null;
    totalTime = !IZIValidate.nullOrEmpty(json['totalTime']) ? IZINumber.parseInt(json['totalTime'].toString()) : null;
    timeUsed = !IZIValidate.nullOrEmpty(json['timeUsed']) ? IZINumber.parseInt(json['timeUsed'].toString()) : null;
    historyTimeUsed = !IZIValidate.nullOrEmpty(json['historyTimeUsed']) ? json['historyTimeUsed'] as List<String> : null;
    statusPayment = !IZIValidate.nullOrEmpty(json['statusPayment']) ? json['statusPayment'].toString() : null;
    statusQuestion = !IZIValidate.nullOrEmpty(json['statusQuestion']) ? json['statusQuestion'].toString() : null;
    if (json['answerList'] != null && json['answerList'].toString().length != 24) {
      answerList = (json['answerList'] as List<dynamic>).map((e) => AnswerResponse.fromJson(e as Map<String, dynamic>)).toList();
    } else {
      answerList = null;
    }
    if (json['answerer'] != null && json['answerer'].toString().length != 24) {
      answerer = AnswerResponse.fromJson(json['answerer'] as Map<String, dynamic>);
    }
    finalPrice = !IZIValidate.nullOrEmpty(json['finalPrice']) ? IZINumber.parseInt(json['finalPrice'].toString()) : null;
    comment = !IZIValidate.nullOrEmpty(json['comment']) ? json['comment'].toString() : null;
    if (json['complains'] != null && json['complains'].toString().length != 24) {
      complains = (json['complains'] as List<dynamic>).map((e) => ComplaintResponse.fromJson(e as Map<String, dynamic>)).toList();
    } else {
      complains = null;
    }
    denounce = !IZIValidate.nullOrEmpty(json['denounce']) ? json['denounce'].toString() : null;
    denounceBy = !IZIValidate.nullOrEmpty(json['denounceBy']) ? json['denounceBy'].toString() : null;
    linkRecords = !IZIValidate.nullOrEmpty(json['linkRecords']) ? json['linkRecords'] as List<String> : null;
    statusShare = !IZIValidate.nullOrEmpty(json['statusShare']) ? json['statusShare'].toString() : null;
    mySharePrice = !IZIValidate.nullOrEmpty(json['mySharePrice']) ? IZINumber.parseInt(json['mySharePrice'].toString()) : null;
    partnerSharePrice = !IZIValidate.nullOrEmpty(json['partnerSharePrice']) ? IZINumber.parseInt(json['partnerSharePrice'].toString()) : null;
    createdAt = !IZIValidate.nullOrEmpty(json['createdAt']) ? IZIDate.parse(json['createdAt'].toString()) : null;
    updatedAt = !IZIValidate.nullOrEmpty(json['updatedAt']) ? IZIDate.parse(json['updatedAt'].toString()) : null;
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (!IZIValidate.nullOrEmpty(id)) data['_id'] = id;
    if (!IZIValidate.nullOrEmpty(idUser)) data['idUser'] = idUser;
    if (!IZIValidate.nullOrEmpty(idSubSpecialize)) data['idSubSpecialize'] = idSubSpecialize;
    if (!IZIValidate.nullOrEmpty(content)) data['content'] = content;
    if (!IZIValidate.nullOrEmpty(attachImages)) data['attachImages'] = attachImages;
    if (!IZIValidate.nullOrEmpty(attachFiles)) data['attachFiles'] = attachFiles;
    if (!IZIValidate.nullOrEmpty(hashTag)) data['hashTag'] = hashTag;
    if (!IZIValidate.nullOrEmpty(moneyFrom)) data['moneyFrom'] = moneyFrom;
    if (!IZIValidate.nullOrEmpty(moneyTo)) data['moneyTo'] = moneyTo;
    if (!IZIValidate.nullOrEmpty(priorityLanguage)) data['priorityLanguage'] = priorityLanguage;
    if (!IZIValidate.nullOrEmpty(priorityGender)) data['priorityGender'] = priorityGender;
    if (!IZIValidate.nullOrEmpty(priorityRegion)) data['priorityRegion'] = priorityRegion;
    if (!IZIValidate.nullOrEmpty(priorityExperience)) data['priorityExperience'] = priorityExperience;
    if (!IZIValidate.nullOrEmpty(priorityExpert)) data['priorityExpert'] = priorityExpert;
    if (!IZIValidate.nullOrEmpty(priorityRank)) data['priorityRank'] = priorityRank;
    if (!IZIValidate.nullOrEmpty(totalTime)) data['totalTime'] = totalTime;
    if (!IZIValidate.nullOrEmpty(timeUsed)) data['timeUsed'] = timeUsed;
    if (!IZIValidate.nullOrEmpty(historyTimeUsed)) data['historyTimeUsed'] = historyTimeUsed;
    if (!IZIValidate.nullOrEmpty(statusPayment)) data['statusPayment'] = statusPayment;
    if (!IZIValidate.nullOrEmpty(statusQuestion)) data['statusQuestion'] = statusQuestion;
    if (!IZIValidate.nullOrEmpty(answerList)) data['answerList'] = answerList;
    if (!IZIValidate.nullOrEmpty(answerer)) data['answerer'] = answerer;
    if (!IZIValidate.nullOrEmpty(finalPrice)) data['finalPrice'] = finalPrice;
    if (!IZIValidate.nullOrEmpty(comment)) data['comment'] = comment;
    if (!IZIValidate.nullOrEmpty(complains)) data['complains'] = complains;
    if (!IZIValidate.nullOrEmpty(denounce)) data['denounce'] = denounce;
    if (!IZIValidate.nullOrEmpty(denounceBy)) data['denounceBy'] = denounceBy;
    if (!IZIValidate.nullOrEmpty(linkRecords)) data['linkRecords'] = linkRecords;
    if (!IZIValidate.nullOrEmpty(statusShare)) data['statusShare'] = statusShare;
    if (!IZIValidate.nullOrEmpty(mySharePrice)) data['mySharePrice'] = mySharePrice;
    if (!IZIValidate.nullOrEmpty(partnerSharePrice)) data['partnerSharePrice'] = partnerSharePrice;
    if (!IZIValidate.nullOrEmpty(updatedAt)) data['createdAt'] = createdAt;
    if (!IZIValidate.nullOrEmpty(updatedAt)) data['updatedAt'] = updatedAt;
    return data;
  }

  @override
  String toString() {
    return 'QuestionResponse(id: $id, idUser: $idUser, idSubSpecialize: $idSubSpecialize, content: $content, attachImages: $attachImages, attachFiles: $attachFiles, hashTag: $hashTag, moneyFrom: $moneyFrom, moneyTo: $moneyTo, priorityLanguage: $priorityLanguage, priorityGender: $priorityGender, priorityRegion: $priorityRegion, priorityExperience: $priorityExperience, priorityExpert: $priorityExpert, priorityRank: $priorityRank, totalTime: $totalTime, timeUsed: $timeUsed, historyTimeUsed: $historyTimeUsed, statusPayment: $statusPayment, statusQuestion: $statusQuestion, answerList: $answerList, answerer: $answerer, finalPrice: $finalPrice, comment: $comment, complains: $complains, denounce: $denounce, linkRecords: $linkRecords, statusShare: $statusShare, mySharePrice: $mySharePrice, partnerSharePrice: $partnerSharePrice, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
