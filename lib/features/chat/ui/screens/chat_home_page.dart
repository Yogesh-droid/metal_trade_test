import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:metaltrade/core/constants/app_widgets/main_app_bar.dart';
import 'package:metaltrade/core/constants/strings.dart';
import 'package:metaltrade/core/constants/text_tyles.dart';
import 'package:metaltrade/features/chat/ui/controllers/chat_bloc/chat_bloc.dart';
import 'package:metaltrade/features/chat/ui/controllers/chat_home/chat_home_bloc.dart';

import '../../../../core/constants/app_widgets/loading_dots.dart';
import '../../../../core/routes/routes.dart';

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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BlocBuilder<ChatHomeBloc, ChatHomeState>(
                  builder: (context, state) {
                if (state is ChatHomeInitial) {
                  return const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 400),
                      Center(child: LoadingDots()),
                    ],
                  );
                }
                if (state is ChatHomeListFetched) {
                  return ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: chatHomeBloc.chatList
                        .map((e) => Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .outlineVariant))),
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                titleAlignment: ListTileTitleAlignment.center,
                                onTap: () {
                                  context.read<ChatBloc>().add(
                                      GetPreviousChatEvent(
                                          chatType: ChatType.enquiry.name,
                                          enquiryId: e.enquiryId,
                                          page: 0));
                                  context.pushNamed(chatPageName);
                                },
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(e.heading ?? ''),
                                    Text(
                                        DateFormat('dd MMM yyyy').format(
                                            DateTime.parse(
                                                e.lastChatDate ?? '')),
                                        style: secMed10.copyWith(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .outline))
                                  ],
                                ),
                                subtitle: Text(
                                  e.description ?? '',
                                  style: secMed11.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .outline),
                                ),
                                leading: CircleAvatar(
                                    radius: 25,
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



/* listener: (context, state) {
                  if (state is PreviousChatLoaded) {
                    context.pop();
                    context
                        .pushNamed(chatPageName, queryParameters: {"id": "1"});
                  }
                  if (state is PreviousChatLoading) {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const Dialog.fullscreen(
                              backgroundColor: Colors.transparent,
                              child: LoadingDots());
                        });
                  }
                }, */