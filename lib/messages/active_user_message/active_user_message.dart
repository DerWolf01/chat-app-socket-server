import 'package:chat_app_socket_server/messages/register_message/register_message.dart';
import 'package:chat_app_socket_server/messages/socket_message/socket_message.dart';
import 'package:chat_app_socket_server/model/model.dart';

class ActiveUserMessage extends RegisterMessage {
  ActiveUserMessage(super.userId);

  @override
  Map<String, dynamic> toMap() {
    var map = super.toMap();
    print(map);
    return map;
  }
}
