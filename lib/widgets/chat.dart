
import 'dart:convert';
import 'dart:math';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

String randomString() {
  final random = Random.secure();
  final values = List<int>.generate(16, (i) => random.nextInt(255));
  return base64UrlEncode(values);
}

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  final List<types.Message> _messages = [];
  final _user = const types.User(id: '8359a903-ab0e-4335-ac81-05c8b058b61a');
  final _responder = const types.User(id: '82091008-a484-4a89-ae75-a22bf8d6f3ac');
  final openAI = OpenAI.instance.build(token: dotenv.env['TOKEN'],baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 30)),enableLog: true);

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      appBar: AppBar(
        title: const Text("Chat"),
      ),
      body: Chat(
        theme: const DarkChatTheme(),
        messages: _messages,
        onSendPressed: _handleSendPressed,
        user: _user
      )
    );
  }
  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
    );

    chatComplete(message.text);
    _addMessage(textMessage);
  }
  void chatComplete(String queryMessage) async {
    final request = ChatCompleteText(messages: [
      Map.of({"role": "user", "content": queryMessage})
    ], maxToken: 200, model: Gpt4ChatModel());

    final response = await openAI.onChatCompletion(request: request);
    for (var element in response!.choices) {
      print("data -> ${element.message?.content}");
      if (element.message == null)
        continue;
      final textMessage = types.TextMessage(
        author: _responder,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: randomString(),
        text: element.message!.content,
      );
      _addMessage(textMessage);
    }
  }
}