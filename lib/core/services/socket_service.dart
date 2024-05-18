import 'dart:async';
import 'package:conversation_repository/conversation_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:tctt_mobile/core/services/token_service.dart';

class EventNames {
  static const joinEvent = "joinConv";
  static const joinedConversationEvent = "joinedConversation";
  static const messageEvent = "message";
  static const sendMessageEvent = "sendMsg";
}

class CreatingConversationSocketIOService {
  CreatingConversationSocketIOService()
      : _socket = IO.io(
          dotenv.env['SOCKET_IO_URL'],
          IO.OptionBuilder()
              .setTransports(['websocket'])
              .disableAutoConnect()
              .build(),
        ) {
    _socket.onConnect((_) => print('conversation creating socket connected'));

    _socket.on(EventNames.joinedConversationEvent,
        (data) => addResponse(data['conversationId']));

    _socket.onDisconnect((_) => print('disconnect'));

    _socket.onError((data) => print(data));
  }

  Future<void> connect() async {
    final token = await TokenService.getToken();

    _socket.io.options?['extraHeaders'] = {'Authorization': 'Bearer $token'};
    _socket.connect();
  }

  final _socketResponse = StreamController<String>();

  final IO.Socket _socket;

  void Function(String) get addResponse => _socketResponse.sink.add;

  Stream<String> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
    _socket.disconnect();
  }

  void sendOneByOneConversationRequest(String otherUserId) {
    print('sent');
    _socket.emit(EventNames.joinEvent, [
      {"userId": otherUserId}
    ]);
  }
}

class CommunicationSocketIOService {
  CommunicationSocketIOService({required String conversationId})
      : _conversationId = conversationId,
        _socket = IO.io(
          dotenv.env['SOCKET_IO_URL'],
          IO.OptionBuilder()
              .setTransports(['websocket'])
              .disableAutoConnect()
              .build(),
        ) {
    _socket.onConnect((_) {
      print('communication socket connected');
      joinToConversation();
    });

    _socket.on(EventNames.joinedConversationEvent,
        (data) => print('joined to conversation ${data['conversationId']}'));

    _socket.on(EventNames.messageEvent, (data) {
      print('received message');
      addResponse(Message.fromJson(data));
    });

    _socket.onDisconnect((_) => print('communication socket disconnect'));

    _socket.onError((data) => print(data));
  }

  Future<void> connect() async {
    final token = await TokenService.getToken();

    _socket.io.options?['extraHeaders'] = {'Authorization': 'Bearer $token'};
    _socket.connect();
  }

  final _socketResponse = StreamController<Message>();

  final IO.Socket _socket;

  final String _conversationId;

  void Function(Message) get addResponse => _socketResponse.sink.add;

  Stream<Message> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
    _socket.disconnect();
  }

  void joinToConversation() {
    _socket.emit(EventNames.joinEvent, [
      {"id": _conversationId}
    ]);
  }

  void sendMessage(String content) {
    print('sent message $content');
    _socket.emit(EventNames.sendMessageEvent, [
      {
        "conversationId": _conversationId,
        "content": content,
      }
    ]);
  }
}
