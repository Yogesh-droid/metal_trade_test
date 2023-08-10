import 'dart:developer';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import '../constants/hive/local_storage.dart';

class StompClientProvider {
  static StompClientProvider instance = StompClientProvider._internal();

  StompClient stompCl = StompClient(
    config: StompConfig(
        url: 'wss://api.metaltrade.io/ws',
        onWebSocketError: (dynamic error) => log('', error: error.toString()),
        stompConnectHeaders: {
          'Authorization': 'Bearer ${LocalStorage.instance.token}',
          'Content-Type': 'application/json'
        },
        webSocketConnectHeaders: {
          'Authorization': 'Bearer ${LocalStorage.instance.token}',
          'Content-Type': 'application/json'
        }),
  );

  factory StompClientProvider() {
    return instance;
  }

  StompClientProvider._internal();
}
