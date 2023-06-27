import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatInitial()) {
    final List<String> chats = [];

    on<ChatEvent>((event, emit) async {
      if (event is GetPreviousChatEvent) {
        chats.addAll(["Hello", "World", "How Are You", "What Are you doing"]);
        emit(ChatListSuccessState(chats: chats));
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
