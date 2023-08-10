import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metaltrade/core/constants/api_constants.dart';
import 'package:metaltrade/core/resource/data_state/data_state.dart';
import 'package:metaltrade/core/resource/request_params/request_params.dart';
import 'package:metaltrade/features/chat/data/models/chat_response_model.dart';
import 'package:metaltrade/features/chat/domain/entities/chat_response_entity.dart';
import 'package:metaltrade/features/chat/domain/usecases/chat_file_upload_usecase.dart';
import 'package:metaltrade/features/chat/domain/usecases/chat_list_usecase.dart';
part 'chat_event.dart';
part 'chat_state.dart';

enum ChatType { enquiry, quote }

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatListUsecase chatListUsecase;
  final ChatFileUploadUsecase chatFileUploadUsecase;
  final List<String> chats = [];
  final List<Content> chatList = [];
  int chatListPage = 0;
  bool isCHatListEnd = false;
  ChatBloc({required this.chatListUsecase, required this.chatFileUploadUsecase})
      : super(ChatInitial()) {
    on<ChatEvent>((event, emit) async {
      if (event is GetPreviousChatEvent) {
        if (event.page == 0) {
          chatList.clear();
          emit(PreviousChatLoading());
        }
        if (event.isLoadMore != null) {
          emit(PreviousChatLoadMore());
        }
        try {
          String url = '';
          if (event.chatType == ChatType.enquiry.name) {
            url =
                "${baseUrl}user/enquiry/${event.enquiryId}/chat?page=${event.page}&size=20";
          } else if (event.chatType == ChatType.quote.name) {
            url =
                "${baseUrl}user/quote/${event.quoteId}/chat?page=${event.page}&size=20";
          }
          DataState<ChatResponseEntity> dataState = await chatListUsecase.call(
              RequestParams(
                  url: url, apiMethods: ApiMethods.get, header: header));

          if (dataState.data != null) {
            chatList.insertAll(0, dataState.data!.content!.reversed.toList());
            chatListPage = dataState.data!.number!;
            isCHatListEnd = dataState.data!.last!;
            emit(PreviousChatLoaded(chatList: dataState.data!.content!));
          } else {
            emit(PreviousChatFailed(Exception(dataState.exception)));
          }
        } on Exception catch (e) {
          emit(PreviousChatFailed(e));
        }
      }

      if (event is AddNewChat) {
        chatList.add(event.chat);
        emit(PreviousChatLoaded(chatList: chatList));
      }

      if (event is ChatInitiateEvent) {
        chats.add(event.message);
        emit(ChatListSuccessState(chats: chats));
      }

      if (event is UploadChatFile) {
        try {
          DataState<String> dataState = await chatFileUploadUsecase.call(
              RequestParams(
                  url: '${baseUrl}user/file/upload',
                  apiMethods: ApiMethods.multipart,
                  filePath: event.file!.path,
                  fileName: event.file!.path.split('/').last,
                  header: header), onReceiveProgress: (value) {
            emit(ChatFileUploading(value));
          }, onSendProgress: (value) {
            emit(ChatFileUploading(value));
          });
          if (dataState.data != null) {
            emit(ChatFileUploaded(imgUrl: dataState.data!));
          } else {
            log(dataState.exception.toString());
            emit(ChatFileUploadFailed(
                exception: Exception(dataState.exception), file: event.file));
          }
        } on Exception catch (e) {
          log(e.toString());
          emit(ChatFileUploadFailed(exception: e, file: event.file));
        }
      }
    });
  }
}
