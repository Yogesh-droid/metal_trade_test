import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:metaltrade/core/constants/assets.dart';
import 'package:metaltrade/core/constants/spaces.dart';
import 'package:metaltrade/core/constants/text_tyles.dart';
import 'package:metaltrade/features/chat/ui/controllers/chat_bloc/chat_bloc.dart';
import 'package:metaltrade/features/chat/ui/controllers/chat_home/chat_home_bloc.dart';
import 'package:metaltrade/features/chat/ui/widgets/animated_emoji.dart';

import '../../../../core/constants/app_widgets/loading_dots.dart';
import '../../../../core/routes/routes.dart';
import '../../../profile/domain/entities/profile_entity.dart';
import '../../../profile/ui/controllers/profile_bloc/profile_bloc.dart';
import '../../../profile/ui/widgets/kyc_dialog.dart';

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
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.read<ChatBloc>().add(GetPreviousChatEvent(
                  chatType: ChatType.enquiry.name, enquiryId: 0, page: 0));
              context.pushNamed(chatPageName,
                  queryParameters: {'room': "MetalTrade support"});
            },
            child: Image.asset(Assets.assetsWelcomeMetalTradeLogo)),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileSuccessState) {
              if (state.profileEntity.company != null) {
                return SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: appWidgetGap),
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
                          return chatHomeBloc.chatList.isEmpty
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 300),
                                    const AnimatedEmoji(),
                                    const SizedBox(height: appPadding),
                                    Center(
                                      child: Text(
                                          "No Chats found\n Start chat by submitting quote",
                                          style: secMed20.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .outline),
                                          textAlign: TextAlign.center),
                                    ),
                                  ],
                                )
                              : ListView(
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
                                              titleAlignment:
                                                  ListTileTitleAlignment.center,
                                              onTap: () {
                                                context.read<ChatBloc>().add(
                                                    GetPreviousChatEvent(
                                                        chatType: ChatType
                                                            .enquiry.name,
                                                        enquiryId: e.enquiryId,
                                                        page: 0));
                                                context.pushNamed(chatPageName,
                                                    queryParameters: {
                                                      'room': e.heading
                                                    });
                                              },
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(e.heading ?? ''),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                          DateFormat(
                                                                  'dd MMM yyyy')
                                                              .format(DateTime
                                                                  .parse(
                                                                      e.lastChatDate ??
                                                                          '')),
                                                          style: secMed10.copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .outline)),
                                                      Text(
                                                          DateFormat('hh mm a')
                                                              .format(DateTime
                                                                  .parse(
                                                                      e.lastChatDate ??
                                                                          '')),
                                                          style: secMed10.copyWith(
                                                              color: Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .outline))
                                                    ],
                                                  ),
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
                                                  child: Text(e.initial ??
                                                      e.enquiryId.toString())),
                                            ),
                                          ))
                                      .toList(),
                                );
                        } else {
                          return const Center(child: Text("Some Error"));
                        }
                      }),
                      if (loadMore)
                        const SizedBox(height: 100, child: LoadingDots())
                    ],
                  ),
                );
              } else {
                return KycDialog(
                  profileEntity: ProfileEntity(),
                );
              }
            } else if (state is ProfileFailed) {
              return const Center(
                  child: Text("Something went wrong !! \n Profile not found",
                      textAlign: TextAlign.center));
            }
            return const SizedBox(
              child: Center(child: LoadingDots()),
            );
          },
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