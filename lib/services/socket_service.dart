import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:tctt_mobile/services/token_service.dart';
import 'package:tctt_mobile/shared/utils/constants.dart';

class EventNames {
  static const joinEvent = "joinConv";
  static const joinedConversationEvent = "joinedConversation";
}

class SocketIOService {
  SocketIOService()
      : _socket = IO.io(
          socketUrl,
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
