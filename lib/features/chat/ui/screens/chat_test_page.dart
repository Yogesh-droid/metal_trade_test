import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/app_widgets/loading_dots.dart';
import 'package:metaltrade/core/constants/app_widgets/main_app_bar.dart';
import 'package:metaltrade/core/constants/hive/local_storage.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/resource/stomp_client.dart';
import 'package:metaltrade/features/chat/data/models/chat_response_model.dart';
import 'package:metaltrade/features/chat/ui/controllers/chat_file_pick_cubit/chat_file_pick_cubit.dart';
import 'package:metaltrade/features/chat/ui/controllers/chat_home/chat_home_bloc.dart';
import 'package:metaltrade/features/chat/ui/widgets/chat_file_pick_upload/chat_image_dialog.dart';
import 'package:metaltrade/features/chat/ui/widgets/chat_send_btn.dart';
import 'package:metaltrade/features/profile/ui/controllers/profile_bloc/profile_bloc.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_exception.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../../core/constants/strings.dart';
import '../controllers/chat_bloc/chat_bloc.dart';
import '../widgets/chat_list.dart';

// ignore: constant_identifier_names
const String EVENT = "CHAT PAGE EVENT";

class ChatTestPage extends StatefulWidget {
  const ChatTestPage({Key? key, this.chatType, this.room, this.content})
      : super(key: key);
  final String? chatType;
  final Content? content;
  final String? room;
  @override
  State<ChatTestPage> createState() => ChatTestPageState();
}

class ChatTestPageState extends State<ChatTestPage> {
  GlobalKey<ChatTestPageState> myWidgetKey = GlobalKey();
  late ChatBloc chatBloc;
  late String token;
  StompClient? stompClient;
  late ProfileBloc profileBloc;
  late int companyId;
  int receiverId = 0;
  late int senderId;
  late int enquiryId;
  late int quoteId;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    token = LocalStorage.instance.token ?? '';
    chatBloc = context.read<ChatBloc>();
    profileBloc = context.read<ProfileBloc>();
    senderId = profileBloc.profileEntity!.company!.id!;
    stompClient = StompClientProvider.instance.stompCl;

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !chatBloc.isCHatListEnd) {
        chatBloc.add(GetPreviousChatEvent(
            chatType: ChatType.enquiry.name,
            enquiryId: enquiryId,
            quoteId: quoteId,
            page: chatBloc.chatListPage + 1,
            isLoadMore: true));
      }
    });

    if (stompClient != null) {
      stompClient!.activate();
      Future.delayed(const Duration(milliseconds: 2000), () {
        onConnect();
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.outlineVariant,
        appBar: MainAppBar(
          title: Text(widget.room ?? kChat),
        ),
        body: BlocListener<ChatFilePickCubit, ChatFilePickState>(
          listener: (context, state) {
            if (state is ChatFilePickSuccess) {
              context.read<ChatBloc>().add(UploadChatFile(file: state.file));
              showDialog(
                  context: context,
                  builder: (_) {
                    return ChatImageDialog(onSendBtnTapped: (text, imagUrl) {
                      onSendBtnTapped(text, imagUrl);
                    });
                  });
            }
          },
          child: Column(
            children: [
              const SizedBox(height: appPadding * 2),
              Expanded(
                child: SingleChildScrollView(
                  reverse: true,
                  controller: scrollController,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                        child: BlocBuilder<ChatBloc, ChatState>(
                          builder: (context, state) {
                            if (state is PreviousChatLoadMore) {
                              return const LoadingDots();
                            }
                            return const SizedBox();
                          },
                        ),
                      ),
                      BlocBuilder<ChatBloc, ChatState>(
                        builder: (context, state) {
                          if (state is PreviousChatLoading) {
                            return const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 200),
                                Center(child: LoadingDots()),
                              ],
                            );
                          }
                          if (state is PreviousChatLoaded ||
                              state is PreviousChatLoadMore ||
                              state is ChatFileUploading ||
                              state is ChatFileUploadFailed ||
                              state is ChatFileUploaded) {
                            if (chatBloc.chatList.isNotEmpty) {
                              enquiryId = chatBloc.chatList.first.enquiryId!;
                            } else if (chatBloc.chatList.isEmpty &&
                                widget.content != null &&
                                widget.content != null &&
                                (widget.content!.body!.chatMessageType ==
                                        "Enquiry" ||
                                    widget.content!.body!.chatMessageType ==
                                        "Quote")) {
                              context
                                  .read<ChatBloc>()
                                  .add(AddNewChat(widget.content!));
                              Future.delayed(const Duration(seconds: 1), () {
                                stompClient!.send(
                                  destination: '/mtp/chat',
                                  headers: {
                                    'Authorization':
                                        'Bearer ${LocalStorage.instance.token}'
                                  },
                                  body: json.encode({
                                    "senderCompanyId": senderId,
                                    "enquiryId": widget.content!.enquiryId,
                                    "quoteId": widget.content!.quoteId ?? '',
                                    "body": {
                                      "chatMessageType": "Enquiry",
                                      "enquiry": {
                                        "id": widget.content!.enquiryId
                                      },
                                      "quote": {"id": widget.content!.quoteId}
                                    }
                                  }),
                                );
                              });
                              Future.delayed(const Duration(seconds: 2), () {
                                context.read<ChatHomeBloc>().chatList.clear();
                                context
                                    .read<ChatHomeBloc>()
                                    .add(GetChatHomeList(page: 0));
                              });
                            }
                            return ChatList(chatList: chatBloc.chatList);
                          }
                          return const Center(
                              child: Text("No Previous Chat Found"));
                        },
                      ),
                    ],
                  ),
                ),
              ),
              ChatSendBtn(onSendBtnTapped: (text, imageUrl) {
                onSendBtnTapped(text, imageUrl);
              })
            ],
          ),
        ));
  }

  void onConnect() {
    try {
      stompClient!.subscribe(
        destination: '/company/$senderId/queue/messages',
        headers: {'Authorization': 'Bearer ${LocalStorage.instance.token}'},
        callback: (frame) {
          Map<String, dynamic> result = json.decode(frame.body!);
          log(result.toString(), name: EVENT);
          if (mounted) {
            context.read<ChatBloc>().add(AddNewChat(Content.fromJson(result)));
          }
        },
      );
    } on Exception catch (e) {
      if (e is WebSocketChannelException) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Your Network is seems weak or not connected")));
      } else if (e is StompBadStateException) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Cannot connect with server")));
      }
    }
  }

  onSendBtnTapped(String text, String? imageUrl) {
    if (text.isEmpty && imageUrl!.isEmpty) {
      return;
    }
    stompClient!.send(
      destination: '/mtp/chat',
      headers: {'Authorization': 'Bearer ${LocalStorage.instance.token}'},
      body: json.encode({
        "enquiryId": enquiryId,
        "body": {
          "text": text,
          "chatMessageType":
              imageUrl != null && imageUrl.isNotEmpty ? "Attachment" : "Text",
          "attachmentUrl": imageUrl ?? ''
        }
      }),
    );
    Map<String, dynamic> body = imageUrl != null && imageUrl.isNotEmpty
        ? {
            "chatMessageType": "Attachment",
            "text": text,
            "attachmentUrl": imageUrl
          }
        : {
            "chatMessageType": "Text",
            "text": text,
          };
    context.read<ChatBloc>().add(AddNewChat(Content(
          body: Body.fromJson(body),
          enquiryId: enquiryId,
          lastModifiedDate: DateTime.now().toString(),
          senderCompanyId: senderId,
        )));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
