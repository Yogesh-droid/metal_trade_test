import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/app_colors.dart';
import 'package:metaltrade/core/constants/app_widgets/context_menu_app_bar.dart';
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

class _ChatTestPageState extends State<ChatTestPage> {
  late ChatBloc chatBloc;
  final TextEditingController textEditingController = TextEditingController();

  late StompClient stompClient;

  @override
  void initState() {
    stompClient = StompClient(
      config: StompConfig(
          url: 'ws://api.metaltrade.io/ws',
          onConnect: onConnect,
          beforeConnect: () async {
            print('waiting to connect...');
            print('connecting...');
          },
          onWebSocketError: (dynamic error) => print(error.toString()),
          stompConnectHeaders: {
            'Authorization':
                'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIrOTE5ODExODcxNDUxIiwiaWF0IjoxNjg3ODYwNzIyLCJleHAiOjE3MTkzOTY3MjJ9.E0NI54y68qiR9GsGArmaKLZhLT7shvBk8QvYa2K1bVE'
          },
          webSocketConnectHeaders: {
            'Authorization':
                'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIrOTE5ODExODcxNDUxIiwiaWF0IjoxNjg3ODYwNzIyLCJleHAiOjE3MTkzOTY3MjJ9.E0NI54y68qiR9GsGArmaKLZhLT7shvBk8QvYa2K1bVE'
          }),
    );

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
                          "sender": {"id": 1},
                          "recipient": {"id": 1},
                          "enquiry": {"id": 1},
                          "quote": {"id": 1},
                          "message": "hello"
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

  void onConnect(StompFrame frame) {
    stompClient.subscribe(
      destination: '/company/6/queue/messages',
      callback: (frame) {
        List<dynamic>? result = json.decode(frame.body!);
        print(result);
      },
    );

    @override
    void dispose() {
      //channel.sink.close();
      super.dispose();
    }
  }
}
