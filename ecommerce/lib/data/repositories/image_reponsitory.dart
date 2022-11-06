import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:template/data/datasource/remote/dio/dio_client.dart';
import 'package:template/data/datasource/remote/exception/api_error_handler.dart';
import 'package:template/data/model/base/api_response.dart';

import '../model/images/image_response.dart';

class ImageUploadRepository {
  DioClient? dioClient = GetIt.I.get<DioClient>();

  ImageUploadRepository();

  ///
  /// Insert import-ware-house to database
  ///
  Future<ApiResponse> addImages(List<File> files) async {
    try {
      final response = await dioClient!.uploadImages('/uploads/', files: files);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print("error: $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert import-ware-house to database
  ///
  Future<ApiResponse> addFiles(List<PlatformFile> files) async {
    try {
      final response = await dioClient!.uploadFiles('/uploads/', files: files);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Insert import-ware-house to database
  ///
  Future<ApiResponse> confirmFilesOrImages(ImageResponse items) async {
    try {
      final response =
          await dioClient!.post('/uploads/local-tmp', data: items.toJson());
      print("aa $response");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  ///
  /// Find import-ware-house by id
  ///
  Future<ApiResponse> find(String id) async {
    try {
      final String uri = '/uploads/$id';
      final response = await dioClient!.get(uri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
