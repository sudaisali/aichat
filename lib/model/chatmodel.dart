import 'package:flutter/cupertino.dart';

class ChatModel {
  final String chatMessage;
  final int chatIndex;

  ChatModel({required this.chatMessage, required this.chatIndex});

  factory ChatModel.fromJson(Map<String, dynamic> json)=>
      ChatModel(
        chatMessage:json['msg'],
        chatIndex:json['chatIndex'],
      );
}
