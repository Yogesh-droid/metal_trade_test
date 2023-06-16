import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../request_params/request_params.dart';
import 'client.dart';

class NetworkManager {
  final Dio _dio = Client().dio;

  Future<Response?> makeNetworkRequest(RequestParams requestParams) async {
    Response response;
    Options options = Options(headers: requestParams.header);
    switch (requestParams.apiMethods) {
      case ApiMethods.get:
        debugPrint(requestParams.url);

        response = await _dio.get(requestParams.url, options: options);
        return response;

      case ApiMethods.post:
        debugPrint(requestParams.url);
        debugPrint(requestParams.header.toString());
        debugPrint(jsonEncode(requestParams.body));
        response = await _dio.post(requestParams.url,
            data: requestParams.body, options: options);
        return response;

      default:
        return null;
    }
  }
}
