import 'package:chat_app_socket_server/get_it/get_it.dart';
import 'package:chat_app_socket_server/messages/active_user_message/active_user_message.dart';
import 'package:chat_app_socket_server/messages/socket_message/socket_message.dart';
import 'package:chat_app_socket_server/socket_service/socket_service.dart';
import 'package:chat_app_socket_server/socket_user.dart';

class ActiveUsersService {
  SocketService get socketService => getIt<SocketService>();
  final Map<int, SocketUser> activeUsers = {};

  addUser(SocketUser user) {
    removeUser(user);
    notifyUserofActiveUsers(user);
    activeUsers[user.userId] = user;
    socketService.notifyUsers(SocketMessage(ActiveUserMessage(user.userId)));
  }

  removeUser(SocketUser user) => activeUsers.removeWhere(
        (key, value) => key == user.userId,
      );

  notifyUserofActiveUsers(SocketUser user) async {
    for (var u in activeUsers.values.toList()) {
      await socketService.send(
          SocketMessage(ActiveUserMessage(u.userId)), user);
    }
  }
}
