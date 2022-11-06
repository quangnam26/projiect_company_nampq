import 'package:template/data/model/user/user_response.dart';
import 'package:template/helper/izi_date.dart';
import 'package:template/helper/izi_number.dart';
import 'package:template/helper/izi_validate.dart';

class ReviewsResponse {
  String? id;
  String? idQuestion;
  String? idAuthor;
  UserResponse? idAnswerer;
  String? idAnswererRequest;
  int? reputation;
  bool? isSatisfied;
  double? rating;
  String? content;
  bool? isAgreePay;
  String? complain;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  ReviewsResponse({
    this.id,
    this.idQuestion,
    this.idAuthor,
    this.idAnswerer,
    this.idAnswererRequest,
    this.reputation,
    this.isSatisfied,
    this.rating,
    this.content,
    this.isAgreePay,
    this.complain,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  ///
  /// From JSON
  ///
  ReviewsResponse.fromJson(Map<String, dynamic> json) {
    id = !IZIValidate.nullOrEmpty(json['_id']) ? json['_id'].toString() : null;
    idQuestion = !IZIValidate.nullOrEmpty(json['idQuestion']) ? json['idQuestion'].toString() : null;
    idAuthor = !IZIValidate.nullOrEmpty(json['idAuthor']) ? json['idAuthor'].toString() : null;
    idAnswererRequest = !IZIValidate.nullOrEmpty(json['idAnswerer']) ? json['idAnswerer'].toString() : null;
    if (json['idAnswerer'] != null && json['idAnswerer'].toString().length != 24) {
      idAnswerer = UserResponse.fromJson(json['idAnswerer'] as Map<String, dynamic>);
    }

    reputation = !IZIValidate.nullOrEmpty(json['reputation']) ? IZINumber.parseInt(json['reputation'].toString()) : null;

    if (!IZIValidate.nullOrEmpty(json['isSatisfied'])) {
      isSatisfied = json['isSatisfied'] as bool;
    } else {
      isSatisfied = false;
    }
    rating = !IZIValidate.nullOrEmpty(json['rating']) ? IZINumber.parseDouble(json['rating'].toString()) : null;
    content = !IZIValidate.nullOrEmpty(json['content']) ? json['content'].toString() : null;

    if (!IZIValidate.nullOrEmpty(json['isAgreePay'])) {
      isAgreePay = json['isAgreePay'] as bool;
    } else {
      isAgreePay = false;
    }

    complain = !IZIValidate.nullOrEmpty(json['complain']) ? json['complain'].toString() : null;
    status = !IZIValidate.nullOrEmpty(json['status']) ? json['status'].toString() : null;

    createdAt = !IZIValidate.nullOrEmpty(json['createdAt']) ? IZIDate.parse(json['createdAt'].toString()) : null;
    updatedAt = !IZIValidate.nullOrEmpty(json['updatedAt']) ? IZIDate.parse(json['updatedAt'].toString()) : null;
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (!IZIValidate.nullOrEmpty(id)) data['_id'] = id;
    if (!IZIValidate.nullOrEmpty(idQuestion)) data['idQuestion'] = idQuestion;
    if (!IZIValidate.nullOrEmpty(idAuthor)) data['idAuthor'] = idAuthor;
    if (!IZIValidate.nullOrEmpty(idAnswerer)) data['idAnswerer'] = idAnswerer;
    if (!IZIValidate.nullOrEmpty(idAnswererRequest)) data['idAnswerer'] = idAnswererRequest;
    if (!IZIValidate.nullOrEmpty(reputation)) data['reputation'] = reputation;
    if (!IZIValidate.nullOrEmpty(isSatisfied)) data['isSatisfied'] = isSatisfied;
    if (!IZIValidate.nullOrEmpty(rating)) data['rating'] = rating;
    if (!IZIValidate.nullOrEmpty(content)) data['content'] = content;
    if (!IZIValidate.nullOrEmpty(isAgreePay)) data['isAgreePay'] = isAgreePay;
    if (!IZIValidate.nullOrEmpty(complain)) data['complain'] = complain;
    if (!IZIValidate.nullOrEmpty(createdAt)) data['createdAt'] = createdAt;
    if (!IZIValidate.nullOrEmpty(updatedAt)) data['updatedAt'] = updatedAt;
    if (!IZIValidate.nullOrEmpty(status)) data['status'] = status;

    return data;
  }

  @override
  String toString() {
    return 'ReviewsResponse(id: $id, idQuestion: $idQuestion, idAuthor: $idAuthor, idAnswerer: $idAnswerer, idAnswererRequest: $idAnswererRequest, reputation: $reputation, isSatisfied: $isSatisfied, rating: $rating, content: $content, isAgreePay: $isAgreePay, complain: $complain, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
