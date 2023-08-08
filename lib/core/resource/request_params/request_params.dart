import 'package:metaltrade/core/constants/hive/local_storage.dart';

class RequestParams {
  final String url;
  final ApiMethods apiMethods;
  final Map<String, dynamic>? body;
  final Map<String, dynamic>? header;
  final String? filePath;
  final String? fileName;

  const RequestParams(
      {required this.url,
      required this.apiMethods,
      this.body,
      this.header,
      this.filePath,
      this.fileName});
}

enum ApiMethods { get, post, delete, put, patch, multipart, download }

Map<String, String> header = {
  "Authorization": "Bearer ${LocalStorage.instance.token}",
  "Content-Type": "application/json"
};
