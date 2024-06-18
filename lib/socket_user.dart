import 'dart:io';

import 'package:chat_app_socket_server/model/model.dart';

class SocketUser extends Model {
  SocketUser(this.socket, this.userId);
  final int userId;
  final Socket socket;

  @override
  Map<String, dynamic> toMap() => {};
}
