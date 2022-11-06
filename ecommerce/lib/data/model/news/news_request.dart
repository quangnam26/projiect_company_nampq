
import '../../../helper/izi_number.dart';
import '../../../helper/izi_validate.dart';

class NewsRequest {
  String? id;

  String? title;
  String? description;
  String? thumbnail;
  int? numberView;
  String? image;
  String? content;
  String? createdAt;
  String? updatedAt;
  NewsRequest(
      {this.id,
      this.title,
      this.description,
      this.thumbnail,
      this.image,
      this.content,
      this.updatedAt,
      this.createdAt,
      this.numberView});

  NewsRequest.fromJson(Map<String, dynamic> json) {
    id = (json['_id'] == null) ? null : json['_id'] as String;

    description =
        (json['description'] == null) ? null : json['description'].toString();
    numberView = IZIValidate.nullOrEmpty(json['numberView'])? null: IZINumber.parseInt(json['numberView']);
    title = (json['title'] == null) ? null : json['title'].toString();
    thumbnail =
        (json['thumbnail'] == null) ? null : json['thumbnail'].toString();
    image = (json['image'] == null) ? null : json['image'].toString();
    content = (json['content'] == null) ? null : json['content'].toString();
    createdAt =
        (json['createdAt'] == null) ? null : json['createdAt'].toString();
    updatedAt =
        (json['updatedAt'] == null) ? null : json['updatedAt'].toString();
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (!IZIValidate.nullOrEmpty(id)) data['_id'] = id;

    if (!IZIValidate.nullOrEmpty(title)) data['title'] = title;
    if (!IZIValidate.nullOrEmpty(description)) {
      data['description'] = description;
    }
    if (!IZIValidate.nullOrEmpty(thumbnail)) data['thumbnail'] = thumbnail;
    if (!IZIValidate.nullOrEmpty(image)) data['image'] = image;
    if (!IZIValidate.nullOrEmpty(numberView)) data['numberView'] = numberView;
    if (!IZIValidate.nullOrEmpty(content)) data['content'] = content;
    if (!IZIValidate.nullOrEmpty(updatedAt)) data['updatedAt'] = updatedAt;
    if (!IZIValidate.nullOrEmpty(createdAt)) data['createdAt'] = createdAt;
    return data;
  }
}
