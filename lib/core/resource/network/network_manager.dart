import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import '../request_params/request_params.dart';
import 'client.dart';

class NetworkManager {
  final Dio _dio = Client().dio;

  Future<Response?> makeNetworkRequest(RequestParams requestParams,
      {Function(int)? onsendProgress, Function(int)? onReceiveProgress}) async {
    Response? response;
    Options options = Options(
      headers: requestParams.header,
      responseType: requestParams.responseType,
    );
    switch (requestParams.apiMethods) {
      case ApiMethods.get:
        debugPrint(requestParams.url);
        try {
          response = await _dio.get(
            requestParams.url,
            options: options,
            onReceiveProgress: (count, total) {
              if (onReceiveProgress != null) {
                onReceiveProgress(((count / total) * 100).toInt());
              }
            },
          );

          return response;
        } on DioException catch (e) {
          throw Exception(e.response != null &&
                  e.response!.data.isNotEmpty &&
                  e.response!.data != null
              ? e.response!.data['message']
              : e.message);
        }

      case ApiMethods.download:
        debugPrint(requestParams.url);
        try {
          response = await _dio.download(
            requestParams.url,
            '${(Platform.isAndroid ? "/storage/emulated/0/Download" //FOR ANDROID
                : await getApplicationSupportDirectory() //FOR IOS
            )}/Metaltrade',
            options: options,
            onReceiveProgress: (count, total) {
              if (onReceiveProgress != null) {
                onReceiveProgress(((count / total) * 100).toInt());
              }
            },
          );
          return response;
        } on DioException catch (e) {
          throw Exception(e.response != null &&
                  e.response!.data.isNotEmpty &&
                  e.response!.data != null
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
          throw Exception(e.response != null &&
                  e.response!.data.isNotEmpty &&
                  e.response!.data != null
              ? e.response!.data['message']
              : e.message);
        }

      case ApiMethods.put:
        debugPrint(requestParams.url);
        debugPrint(requestParams.header.toString());
        debugPrint(jsonEncode(requestParams.body));

        try {
          response = await _dio.put(requestParams.url,
              data: requestParams.body, options: options);
          return response;
        } on DioException catch (e) {
          throw Exception(e.response != null &&
                  e.response!.data.isNotEmpty &&
                  e.response!.data != null
              ? e.response!.data['message']
              : e.message);
        }

      case ApiMethods.delete:
        debugPrint(requestParams.url);
        debugPrint(requestParams.header.toString());
        debugPrint(jsonEncode(requestParams.body));

        try {
          response = await _dio.delete(requestParams.url,
              data: requestParams.body, options: options);
          return response;
        } on DioException catch (e) {
          throw Exception(e.response != null &&
                  e.response!.data.isNotEmpty &&
                  e.response!.data != null
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
          response = await _dio.post(
            requestParams.url,
            data: formData,
            options: options,
            onReceiveProgress: (count, total) {
              if (onReceiveProgress != null) {
                onReceiveProgress(((count / total) * 100).toInt());
              }
            },
            onSendProgress: (count, total) {
              if (onsendProgress != null) {
                onsendProgress(((count / total) * 100).toInt());
              }
            },
          );
          return response;
        } on DioException catch (e) {
          throw Exception(e.response != null &&
                  e.response!.data.isNotEmpty &&
                  e.response!.data != null
              ? e.response!.data['message']
              : e.message);
        }
      default:
        return null;
    }
  }
}
