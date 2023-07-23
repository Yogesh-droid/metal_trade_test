import 'dart:developer';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import '../constants/hive/local_storage.dart';

class StompClientProvider {
  static StompClientProvider instance = StompClientProvider._internal();

  StompClient stompCl = StompClient(
    config: StompConfig(
        url: 'wss://api.metaltrade.io/ws',
        onConnect: (p0) {
          log("this is stompframe ${p0.toString()}");
        },
        onWebSocketError: (dynamic error) => log('', error: error.toString()),
        stompConnectHeaders: {
          'Authorization': 'Bearer ${LocalStorage.instance.token}'
        },
        webSocketConnectHeaders: {
          'Authorization': 'Bearer ${LocalStorage.instance.token}'
        }),
  );

  factory StompClientProvider() {
    return instance;
  }

  StompClientProvider._internal();
}