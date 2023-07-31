import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';
import 'storage_client.dart';

class LocalStorage {
  static final LocalStorage instance = LocalStorage._internal();
  factory LocalStorage() {
    return instance;
  }
  LocalStorage._internal();

  String? token;
  String? userId;
  final FlutterSecureStorage secureStorage =
      LocalStorageClient().flutterSecureStorage;

  // This method stores the token in encrypted form
  Future<void> saveToken(String token) async {
    this.token = token;
    final enctriptedBox = await getEnctriptedBox();
    await enctriptedBox.put(dotenv.env['token_value'], token);
  }

  Future<void> deleteToken() async {
    final enctriptedBox = await getEnctriptedBox();
    token = null;
    await enctriptedBox.delete(dotenv.env['token_value']);
    token = null;
  }

  Future<String> getToken() async {
    final enctriptedBox = await getEnctriptedBox();
    token = await enctriptedBox.get(dotenv.env['token_value']) ?? '';
    return token!;
  }

  Future<void> saveUserCompanyId(int userId) async {
    final enctriptedBox = await getEnctriptedBox();
    await enctriptedBox.put(dotenv.env['user_company_id'], userId);
  }

  Future<String> getUserCompanyId() async {
    final enctriptedBox = await getEnctriptedBox();
    userId = await enctriptedBox.get(dotenv.env['user_company_id']) ?? '';
    return userId!;
  }

  Future<void> saveIsUserFirstTime(int noOfTimesappOpening) async {
    final enctriptedBox = await getEnctriptedBox();
    await enctriptedBox.put(
        dotenv.env['is_user_first_time'], noOfTimesappOpening);
  }

  Future<int> getIsUserFirstTime() async {
    final enctriptedBox = await getEnctriptedBox();
    return await enctriptedBox.get(dotenv.env['is_user_first_time']) ?? 0;
  }

  Future<Box<E>> getEnctriptedBox<E>() async {
    // Read token key from secure storage
    final token = await secureStorage.read(key: dotenv.env['token_key']!);

    // If token key does not exist, generate a new key and write it to secure storage
    if (token == null) {
      final key = Hive.generateSecureKey();

      // Write the key value as base64 encoded string
      await secureStorage.write(
          key: dotenv.env['token_key']!, value: base64UrlEncode(key));
    }

    // Get the token key and decode it into Uint8List format
    final key = await secureStorage.read(key: dotenv.env['token_key']!);
    final encryptionKeyUint8List = base64Url.decode(key!);

    // Open an encrypted box using the decoded key and store the token value in this box
    return await Hive.openBox('tokenBox',
        encryptionCipher: HiveAesCipher(encryptionKeyUint8List));
  }
}
