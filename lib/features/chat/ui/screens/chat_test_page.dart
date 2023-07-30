import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/app_widgets/loading_dots.dart';
import 'package:metaltrade/core/constants/app_widgets/main_app_bar.dart';
import 'package:metaltrade/core/constants/hive/local_storage.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/resource/stomp_client.dart';
import 'package:metaltrade/features/chat/ui/widgets/chat_send_btn.dart';
import 'package:metaltrade/features/profile/domain/entities/profile_entity.dart';
import 'package:metaltrade/features/profile/ui/controllers/profile_bloc/profile_bloc.dart';
import 'package:metaltrade/features/profile/ui/widgets/kyc_dialog.dart';
import 'package:stomp_dart_client/stomp.dart';
import '../../../../core/constants/strings.dart';
import '../controllers/chat_bloc/chat_bloc.dart';
import '../widgets/chat_list.dart';

// ignore: constant_identifier_names
const String EVENT = "CHAT PAGE EVENT";

class ChatTestPage extends StatefulWidget {
  const ChatTestPage({Key? key, this.chatType, this.room}) : super(key: key);
  final String? chatType;
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
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileSuccessState) {
            if (state.profileEntity.company != null) {
              return Column(
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
                                  state is ChatFileuploading ||
                                  state is ChatFileUpdalodFailed ||
                                  state is ChatFileUploaded) {
                                if (chatBloc.chatList.isNotEmpty) {
                                  enquiryId =
                                      chatBloc.chatList.first.enquiryId!;
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
              );
            } else {
              return KycDialog(
                profileEntity: ProfileEntity(),
              );
            }
          }
          return const SizedBox();
        },
      ),
    );
  }

  void onConnect() {
    stompClient!.subscribe(
      destination: '/company/$senderId/queue/messages',
      headers: {'Authorization': 'Bearer ${LocalStorage.instance.token}'},
      callback: (frame) {
        Map<String, dynamic> result = json.decode(frame.body!);
        log(result.toString(), name: EVENT);
        if (mounted) {
          context.read<ChatBloc>().add(AddNewChat(result));
        }
      },
    );
  }

  onSendBtnTapped(String text, String? imageUrl) {
    debugPrint("sender id is $senderId");
    if (text.isEmpty) {
      return;
    }
    stompClient!.send(
      destination: '/mtp/chat',
      headers: {'Authorization': 'Bearer ${LocalStorage.instance.token}'},
      body: json.encode({
        "enquiryId": enquiryId,
        "body": {
          "text": text,
          "chatMessageType": imageUrl != null ? "Attachment" : "Text",
          "attachmentUrl": imageUrl ?? ''
        }
      }),
    );
    Map<String, dynamic> body = imageUrl != null
        ? {
            "chatMessageType": "Attachment",
            "text": text,
            "attachmentUrl": imageUrl
          }
        : {
            "chatMessageType": "Text",
            "text": text,
          };
    context.read<ChatBloc>().add(AddNewChat({
          "lastModifiedDate": DateTime.now().toString(),
          "senderCompanyId": senderId,
          "enquiryId": enquiryId,
          "status": "Unseen",
          "body": body
        }));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
