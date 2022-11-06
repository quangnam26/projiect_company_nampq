import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/base/api_response.dart';
import 'package:template/data/model/upload_files/upload_files_request.dart';

class UploadFilesRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  UploadFilesRepository();

  ///
  /// Upload Files Temp
  ///
  Future<ApiResponse> createUploadFilesTemp(List<File> files) async {
    final List<MultipartFile> arrayFiles = [];
    for (var i = 0; i < files.length; i++) {
      arrayFiles.add(await MultipartFile.fromFile(files[i].path.toString()));
    }
    final FormData formData = FormData.fromMap({'files': arrayFiles});
    try {
      final response = await dioClient!.post('/uploads', data: formData);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Confirm Files Temp
  ///
  Future<ApiResponse> confirmUploadFiles(UploadFilesRequest files) async {
    try {
      print("ABC:${files.toJson()}");
      final response = await dioClient!.post('/uploads/local-tmp', data: files.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
