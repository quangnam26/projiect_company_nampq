import '../../../helper/izi_validate.dart';

class AnswerQuizResponse {
  String? id;
  String? typeAnswers;
  String? text;
  String? image;
  bool? isTrue;
  AnswerQuizResponse({
    this.id,
    this.typeAnswers,
    this.text,
    this.image,
    this.isTrue,
  });

  ///
  /// From JSON
  ///

  AnswerQuizResponse.fromJson(Map<String, dynamic> json) {
    id = !IZIValidate.nullOrEmpty(json['_id']) ? json['_id'].toString() : null;
    typeAnswers = !IZIValidate.nullOrEmpty(json['typeAnswer']) ? json['typeAnswer'].toString() : null;
    text = !IZIValidate.nullOrEmpty(json['text']) ? json['text'].toString() : null;
    image = !IZIValidate.nullOrEmpty(json['image']) ? json['image'].toString() : null;
    if (!IZIValidate.nullOrEmpty(json['isTrue'])) {
      isTrue = json['isTrue'] as bool;
    } else {
      isTrue = false;
    }
  }

  ///
  /// To JSON
  ///

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (!IZIValidate.nullOrEmpty(id)) data['_id'] = id;
    if (!IZIValidate.nullOrEmpty(typeAnswers)) data['typeAnswer'] = typeAnswers;
    if (!IZIValidate.nullOrEmpty(text)) data['text'] = text;
    if (!IZIValidate.nullOrEmpty(image)) data['image'] = image;
    if (!IZIValidate.nullOrEmpty(isTrue)) data['isTrue'] = isTrue;

    return data;
  }

  @override
  String toString() {
    return 'AnswerQuizResponse(id: $id, typeAnswer: $typeAnswers, text: $text, image: $image, isTrue: $isTrue)';
  }
}
