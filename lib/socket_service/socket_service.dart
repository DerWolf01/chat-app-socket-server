import 'dart:convert';
import 'dart:io' as io;
import 'dart:isolate';
import 'dart:typed_data';
import 'package:chat_app_socket_server/active_users/active_users_service.dart';
import 'package:chat_app_socket_server/get_it/get_it.dart';
import 'package:chat_app_socket_server/messages/register_message/register_message.dart';
import 'package:chat_app_socket_server/socket_user.dart';
import 'package:chat_app_socket_server/messages/socket_message/socket_message.dart';

class SocketService {
  io.ServerSocket? _socket;
  ActiveUsersService get activeUsersService => getIt<ActiveUsersService>();

  Future createServer() async {
    _socket = await io.ServerSocket.bind("0.0.0.0", 3000);
    listen();
    print("listening on 0.0.0.0:3000");
  }

  listen() {
    _socket?.listen(onConnect);
  }

  onConnect(io.Socket socket) {
    print("connection from ${socket.address.address} established");

    socket.listen(
      (event) {
        print(decode(event));
        onMessage(socket, event);
      },
    );
  }

  onMessage(io.Socket socket, Uint8List event) {
    Map<String, dynamic> message = decode(event);

    if (message["type"] == "RegisterMessage") {
      var r = RegisterMessage.fromMap(message);
      activeUsersService.addUser(SocketUser(
        socket,
        r.userId,
      ));
    }
  }

  notifyUsers(SocketMessage message) async {
    for (var user in activeUsersService.activeUsers.values) {
      await send(message, user);
    }
  }

  Future send(SocketMessage message, SocketUser user) async {
    user.socket.write(encode(message.toMap()));
    return await user.socket.done;
  }

  String encode(Map map) => json.encode(map);
  Map<String, dynamic> decode(Uint8List event) =>
      json.decode(utf8.decode(event));
}
