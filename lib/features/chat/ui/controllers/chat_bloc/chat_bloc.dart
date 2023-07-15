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
  ChatBloc({required this.chatListUsecase}) : super(ChatInitial()) {
    final List<String> chats = [];

    on<ChatEvent>((event, emit) async {
      if (event is GetPreviousChatEvent) {
        try {
          String url = '';
          if (event.chatType == ChatType.enquiry.name) {
            url =
                "${baseUrl}user/${event.userId}/enquiry/${event.enquiryId}/chat?page=${event.page}&size=20";
          }
          DataState<ChatResponseEntity> dataState = await chatListUsecase.call(
              RequestParams(
                  url: url, apiMethods: ApiMethods.get, header: header));

          if (dataState.data != null) {
            emit(PreviousChatLoaded(chatList: dataState.data!.content!));
          } else {
            print(dataState.exception);
            emit(PreviousChatFailed(Exception(dataState.exception)));
          }
        } on Exception catch (e) {
          print(e.toString());
          emit(PreviousChatFailed(e));
        }
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
