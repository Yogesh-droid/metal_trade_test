import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/api_constants.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/chat/data/models/chat_list_model.dart';
import 'package:metaltrade/features/chat/domain/entities/chat_list_entity.dart';
import 'package:metaltrade/features/chat/domain/usecases/chat_home_list_usecase.dart';
part 'chat_home_event.dart';
part 'chat_home_state.dart';

class ChatHomeBloc extends Bloc<ChatHomeEvent, ChatHomeState> {
  final ChatHomeListUsecase chatHomeListUsecase;
  final List<Content> chatList = [];
  bool isChatListEnd = false;
  int chatListPage = 0;

  ChatHomeBloc(this.chatHomeListUsecase) : super(ChatHomeInitial()) {
    on<ChatHomeEvent>((event, emit) async {
      if (event is GetChatHomeList) {
        if (event.page == 0) {
          emit(ChatHomeInitial());
        }
        try {
          DataState<ChatListEntity> dataState = await chatHomeListUsecase.call(
              RequestParams(
                  url: "${baseUrl}user/chat/room?page=${event.page}&size=20",
                  apiMethods: ApiMethods.get,
                  header: header));

          if (dataState.data != null) {
            chatListPage = dataState.data!.number!;
            isChatListEnd = dataState.data!.last!;
            chatList.addAll(dataState.data!.content!);
            emit(ChatHomeListFetched(chatList: chatList));
          } else {
            emit(ChatHomeError(Exception(dataState.exception)));
          }
        } on Exception catch (e) {
          emit(ChatHomeError(e));
        }
      }
    });
  }
}
