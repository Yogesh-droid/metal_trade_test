import 'package:dio/dio.dart';

class Client {
  static final Client instance = Client._internal();
  final Dio dio = Dio();

  factory Client() {
    return instance;
  }

  Client._internal();
}
