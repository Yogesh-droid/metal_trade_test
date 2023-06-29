import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/app_colors.dart';
import 'package:metaltrade/core/constants/app_widgets/main_app_bar.dart';
import 'package:metaltrade/core/constants/hive/local_storage.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import '../../../../core/constants/strings.dart';
import '../controllers/chat_bloc/chat_bloc.dart';

// ignore: constant_identifier_names
const String EVENT = "CHAT PAGE EVENT";

class ChatTestPage extends StatefulWidget {
  const ChatTestPage({super.key});

  @override
  State<ChatTestPage> createState() => _ChatTestPageState();
}

final stompClient = StompClient(
  config: StompConfig(
      url: 'wss://api.metaltrade.io/ws',
      onConnect: onConnect,
      beforeConnect: () async {
        log("Stomp Server Connecting", name: EVENT);
      },
      onWebSocketError: (dynamic error) => log('', error: error.toString()),
      stompConnectHeaders: {
        'Authorization': 'Bearer ${LocalStorage.instance.token}'
      },
      webSocketConnectHeaders: {
        'Authorization': 'Bearer ${LocalStorage.instance.token}'
      }),
);

void onConnect(StompFrame frame) {
  print(frame.headers.toString());
  stompClient.subscribe(
    destination: '/company/1/queue/messages',
    headers: {"Accept-Encoding": "gzip"},
    callback: (frame) {
      print(frame.headers.toString());
      print(frame.body);
      print(frame.binaryBody);
      List<dynamic>? result = json.decode(frame.body!);
      log(result.toString(), name: EVENT);
    },
  );
}

class _ChatTestPageState extends State<ChatTestPage> {
  late ChatBloc chatBloc;
  final TextEditingController textEditingController = TextEditingController();
  late String token;

  @override
  void initState() {
    token = LocalStorage.instance.token ?? '';

    stompClient.activate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(
        title: Text(kChat),
      ),
      body: Column(
        children: [
          BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              if (state is ChatListSuccessState) {
                return Expanded(
                  child: ListView(
                    children: state.chats.map((e) => Text(e)).toList(),
                  ),
                );
              } else {
                return const Text("Failed to connect");
              }
            },
          ),
          const Spacer(),
          Container(
            decoration: BoxDecoration(border: Border.all(color: grey5)),
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                        decoration: const InputDecoration(
                            hintText: "Enter your message",
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(8)),
                        controller: textEditingController)),
                IconButton(
                    onPressed: () {
                      stompClient.send(
                        destination: '/company/1/queue/messages',
                        body: json.encode({
                          "senderCompanyId": 1,
                          "recipientCompanyId": 1,
                          "body": {
                            "text":
                                "Hello, this is from your app only, so enjoy."
                          }
                        }),
                      );
                      // channel.sink.add(textEditingController.text);
                      // chatBloc.add(ChatInitiateEvent(
                      //     message: textEditingController.text, receiverId: 3));
                    },
                    icon: const Icon(Icons.send))
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    //channel.sink.close();
    super.dispose();
  }
}
