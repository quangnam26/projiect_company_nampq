import 'dart:convert';

import 'package:template/helper/izi_validate.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class ImageResponse {
  List<String>? files;
  ImageResponse({
    this.files,
  });

  ImageResponse.fromJson(Map<String, dynamic> json) {
    files = IZIValidate.nullOrEmpty(json['files'])
        ? null
        : (json['files'] as List<dynamic>).cast<String>().toList();
  }

  factory ImageResponse.fromMap(Map<String, dynamic> map) {
    return ImageResponse(
      files: map['files'] != null ? map['files'] as List<String> : null,
    );
  }

  ///
  /// To JSON
  ///
  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    // data = super.toJson();
    if (!IZIValidate.nullOrEmpty(files)) data['files'] = files;

    return data;
  }

  @override
  String toString() => 'ImageUpdateModel(files: $files)';
}
