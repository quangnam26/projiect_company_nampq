import 'dart:convert';

import 'package:flutter/foundation.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class ImageResponse {
  List<String>? files;
  ImageResponse({
    this.files,
  });
  

  ImageResponse copyWith({
    List<String>? files,
  }) {
    return ImageResponse(
      files: files ?? this.files,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'files': files,
    };
  }

  factory ImageResponse.fromMap(Map<String, dynamic> map) {
    return ImageResponse(
      files: map['file'] != null ? (map['file'] as List<dynamic>).map((e) => e.toString()).toList() : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageResponse.fromJson(String source) => ImageResponse.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ImageResponse(files: $files)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ImageResponse &&
      listEquals(other.files, files);
  }

  @override
  int get hashCode => files.hashCode;
}
