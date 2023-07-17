import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:metaltrade/core/constants/app_widgets/main_app_bar.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/core/routes/routes.dart';
import 'package:metaltrade/features/chat/ui/controllers/chat_bloc/chat_bloc.dart';
import 'package:metaltrade/features/chat/ui/controllers/chat_home/chat_home_bloc.dart';
import '../../../../core/constants/app_widgets/loading_dots.dart';

class ChatHomePage extends StatefulWidget {
  const ChatHomePage({super.key});

  @override
  State<ChatHomePage> createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  late ChatHomeBloc chatHomeBloc;
  late ScrollController scrollController;
  bool loadMore = false;
  @override
  void initState() {
    chatHomeBloc = context.read<ChatHomeBloc>();
    chatHomeBloc.add(GetChatHomeList(page: 0));
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !chatHomeBloc.isChatListEnd) {
        setState(() {
          loadMore = true;
        });
        chatHomeBloc.add(GetChatHomeList(page: chatHomeBloc.chatListPage + 1));
        setState(() {
          loadMore = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MainAppBar(title: Text(kChats)),
        body: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            children: [
              BlocBuilder<ChatHomeBloc, ChatHomeState>(
                  builder: (context, state) {
                if (state is ChatHomeInitial) {
                  return const Center(child: LoadingDots());
                }
                if (state is ChatHomeListFetched) {
                  return ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: chatHomeBloc.chatList
                        .map((e) => BlocListener<ChatBloc, ChatState>(
                              listener: (context, state) {
                                if (state is PreviousChatLoaded) {
                                  context.pushNamed(chatPageName,
                                      queryParameters: {"id": "1"});
                                }
                              },
                              child: ListTile(
                                onTap: () {
                                  context.read<ChatBloc>().add(
                                      GetPreviousChatEvent(
                                          chatType: ChatType.enquiry.name,
                                          enquiryId: e.enquiryId,
                                          userId: 1,
                                          page: 0));
                                },
                                title: Text(e.heading ?? ''),
                                leading: CircleAvatar(
                                    radius: 20,
                                    child: Text(e.enquiryId.toString())),
                              ),
                            ))
                        .toList(),
                  );
                } else {
                  return const Center(child: Text("Some Error"));
                }
              }),
              if (loadMore) const SizedBox(height: 100, child: LoadingDots())
            ],
          ),
        ));
  }
}
