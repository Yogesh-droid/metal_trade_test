import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/app_colors.dart';
import 'package:metaltrade/core/constants/app_widgets/context_menu_app_bar.dart';
import 'package:metaltrade/features/auth/ui/controllers/login_bloc/login_bloc.dart';
import 'package:metaltrade/features/profile/ui/controllers/profile_bloc/profile_bloc.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../../core/constants/strings.dart';
import '../controllers/chat_bloc/chat_bloc.dart';

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
        print('waiting to connect...');
        print('connecting...');
      },
      onWebSocketError: (dynamic error) => print(error.toString()),
      stompConnectHeaders: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIrOTE4MzA3NzA5MzgyIiwiaWF0IjoxNjg3ODY0NjM1LCJleHAiOjE3MTk0MDA2MzV9.sXETePR2xAO6FAbLqFaAl1JfffeLMetmgT3u5TVxS8c'
      },
      webSocketConnectHeaders: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIrOTE4MzA3NzA5MzgyIiwiaWF0IjoxNjg3ODY0NjM1LCJleHAiOjE3MTk0MDA2MzV9.sXETePR2xAO6FAbLqFaAl1JfffeLMetmgT3u5TVxS8c'
      }),
);

void onConnect(StompFrame frame) {
  print("calling onConnect");
  stompClient.subscribe(
    destination: '/company/1/queue/messages',
    headers: {"Accept-Encoding": "gzip"},
    callback: (frame) {
      print(frame.body);
      List<dynamic>? result = json.decode(frame.body!);
      print(result);
    },
  );
}

class _ChatTestPageState extends State<ChatTestPage> {
  late ChatBloc chatBloc;
  final TextEditingController textEditingController = TextEditingController();
  late String token;

  @override
  void initState() {
    token = context.read<ProfileBloc>().token ?? '';

    stompClient.activate();
    super.initState();
  }

  /* late WebSocketChannel channel;
  late Stream stream;

  @override
  void initState() {
    chatBloc = context.read<ChatBloc>();
    chatBloc.add(GetPreviousChatEvent());
    // channel = WebSocketChannel.connect(Uri.parse('ws://api.metaltrade.io/ws'));
    channel = WebSocketChannel.connect(Uri.parse(
        'wss://s9304.blr1.piesocket.com/v3/1?api_key=mREErxPKDoD0AEVQRsedu7kpgldk7slxOHytUhj6&notify_self=1'));
    stream = channel.stream.asBroadcastStream();
    stream.listen((event) {
      chatBloc.add(ChatInitiateEvent(message: event, receiverId: 3));
    });
    super.initState();
  } */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ContextMenuAppBar(
        title: kChat,
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
                        destination: '/mtp/chat',
                        body: json.encode({
                          "senderCompanyId": 1,
                          "recipientCompanyId": 1,
                          "body": {
                            "text": "Hello, this is from your app only, so enjoy."
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
