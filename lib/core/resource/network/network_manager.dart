import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../request_params/request_params.dart';
import 'client.dart';

class NetworkManager {
  final Dio _dio = Client().dio;

  Future<Response?> makeNetworkRequest(RequestParams requestParams) async {
    Response? response;
    Options options = Options(headers: requestParams.header);
    switch (requestParams.apiMethods) {
      case ApiMethods.get:
        debugPrint(requestParams.url);
        try {
          response = await _dio.get(requestParams.url, options: options);
          return response;
        } on DioException catch (e) {
          throw Exception(e.response != null && e.response!.data != null
              ? e.response!.data['message']
              : e.message);
        }

      case ApiMethods.post:
        debugPrint(requestParams.url);
        debugPrint(requestParams.header.toString());
        debugPrint(jsonEncode(requestParams.body));

        try {
          response = await _dio.post(requestParams.url,
              data: requestParams.body, options: options);
          return response;
        } on DioException catch (e) {
          throw Exception(e.response != null && e.response!.data != null
              ? e.response!.data['message']
              : e.message);
        }

      case ApiMethods.multipart:
        debugPrint("file name network manager ${requestParams.fileName}");
        debugPrint("file path network manager ${requestParams.filePath}");
        try {
          FormData formData = FormData.fromMap({
            "file": await MultipartFile.fromFile(requestParams.filePath ?? '',
                filename: requestParams.fileName),
          });
          response = await _dio.post(requestParams.url,
              data: formData, options: options);
          return response;
        } on DioException catch (e) {
          throw Exception(e.response != null && e.response!.data != null
              ? e.response!.data['message']
              : e.message);
        }
      default:
        return null;
    }
  }
}
