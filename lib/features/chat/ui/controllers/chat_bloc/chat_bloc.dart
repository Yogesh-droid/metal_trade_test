import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/api_constants.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/chat/data/models/chat_response_model.dart';
import 'package:metaltrade/features/chat/domain/entities/chat_response_entity.dart';
import 'package:metaltrade/features/chat/domain/usecases/chat_list_usecase.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
part 'chat_event.dart';
part 'chat_state.dart';

enum ChatType { enquiry }

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatListUsecase chatListUsecase;
  final List<String> chats = [];
  final List<Content> chatList = [];
  ChatBloc({required this.chatListUsecase}) : super(ChatInitial()) {
    on<ChatEvent>((event, emit) async {
      if (event is GetPreviousChatEvent) {
        chatList.clear();
        emit(PreviousChatLoading());
        try {
          String url = '';
          if (event.chatType == ChatType.enquiry.name) {
            url =
                "${baseUrl}user/enquiry/${event.enquiryId}/chat?page=${event.page}&size=20";
          }
          DataState<ChatResponseEntity> dataState = await chatListUsecase.call(
              RequestParams(
                  url: url, apiMethods: ApiMethods.get, header: header));

          if (dataState.data != null) {
            chatList.addAll(dataState.data!.content!);
            emit(PreviousChatLoaded(chatList: dataState.data!.content!));
          } else {
            emit(PreviousChatFailed(Exception(dataState.exception)));
          }
        } on Exception catch (e) {
          emit(PreviousChatFailed(e));
        }
      }

      if (event is AddNewChat) {
        chatList.add(Content.fromJson(event.chat));
        emit(PreviousChatLoaded(chatList: chatList));
      }

      if (event is ChatInitiateEvent) {
        chats.add(event.message);
        emit(ChatListSuccessState(chats: chats));
      }

      if (event is MessageReceived) {
        emit(MessageReceivedState(event.message));
      }
    });
  }
}
