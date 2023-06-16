import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorageClient {
  static final LocalStorageClient instance = LocalStorageClient._internal();
  final FlutterSecureStorage flutterSecureStorage =
      const FlutterSecureStorage();
  factory LocalStorageClient() {
    return instance;
  }
  LocalStorageClient._internal();
}
