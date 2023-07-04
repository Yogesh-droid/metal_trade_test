import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/app_widgets/main_app_bar.dart';
import 'package:metaltrade/core/constants/hive/local_storage.dart';
import 'package:metaltrade/features/profile/ui/controllers/profile_bloc/profile_bloc.dart';
import 'package:metaltrade/features/profile/ui/widgets/kyc_dialog.dart';
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

/* final stompClient = StompClient(
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
  stompClient.subscribe(
    destination: '/company/1/queue/messages',
    headers: {"Accept-Encoding": "gzip"},
    callback: (frame) {
      List<dynamic>? result = json.decode(frame.body!);
      log(result.toString(), name: EVENT);
    },
  );
} */

class _ChatTestPageState extends State<ChatTestPage> {
  late ChatBloc chatBloc;
  final TextEditingController textEditingController = TextEditingController();
  late String token;
  late StompClient? stompClient;
  late ProfileBloc profileBloc;

  @override
  void initState() {
    token = LocalStorage.instance.token ?? '';
    profileBloc = context.read<ProfileBloc>();
    profileBloc.stream.listen((state) {
      if (state is ProfileSuccessState) {
        if (state.profileEntity.company != null) {
          stompClient = StompClient(
            config: StompConfig(
                url: 'wss://api.metaltrade.io/ws',
                onConnect: onConnect,
                beforeConnect: () async {
                  log("Stomp Server Connecting", name: EVENT);
                },
                onWebSocketError: (dynamic error) =>
                    log('', error: error.toString()),
                stompConnectHeaders: {
                  'Authorization': 'Bearer ${LocalStorage.instance.token}'
                },
                webSocketConnectHeaders: {
                  'Authorization': 'Bearer ${LocalStorage.instance.token}'
                }),
          );
          stompClient!.activate();
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(
        title: Text(kChat),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileSuccessState) {
            if (state.profileEntity.company != null) {
              return Column(
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
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context).colorScheme.outline)),
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
                              if (stompClient != null) {
                                stompClient!.send(
                                  destination: '/mtp/chat',
                                  body: json.encode({
                                    "senderCompanyId": 1,
                                    "recipientCompanyId": 1,
                                    "body": {
                                      "text":
                                          "Hello, this is from your app only, so enjoy."
                                    }
                                  }),
                                );
                              }
                              // channel.sink.add(textEditingController.text);
                              // chatBloc.add(ChatInitiateEvent(
                              //     message: textEditingController.text, receiverId: 3));
                            },
                            icon: const Icon(Icons.send))
                      ],
                    ),
                  )
                ],
              );
            } else {
              return const KycDialog();
            }
          }
          return const SizedBox();
        },
      ),
    );
  }

  void onConnect(StompFrame frame) {
    stompClient!.subscribe(
      destination: '/company/1/queue/messages',
      headers: {"Accept-Encoding": "gzip"},
      callback: (frame) {
        List<dynamic>? result = json.decode(frame.body!);
        log(result.toString(), name: EVENT);
      },
    );
  }

  @override
  void dispose() {
    //channel.sink.close();
    super.dispose();
  }
}
