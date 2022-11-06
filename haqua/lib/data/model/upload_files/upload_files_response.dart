import 'package:template/helper/izi_validate.dart';

class UploadFilesResponse {
  List<dynamic>? files;
  UploadFilesResponse({
    this.files,
  });

  ///
  /// From JSON
  ///
  UploadFilesResponse.fromJson(Map<String, dynamic> json) {
    files = !IZIValidate.nullOrEmpty(json['files']) ? json['files'] as List<dynamic> : null;
  }

  ///
  /// From Confirm Files
  ///
  UploadFilesResponse.fromJsonConfirmFiles(dynamic json) {
    files = !IZIValidate.nullOrEmpty(json) ? json as List<dynamic> : null;
  }

  ///
  /// To JSON
  ///
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (files != null) data['files'] = files;
    return data;
  }

  @override
  String toString() => 'UploadFilesResponse(files: $files)';
}
