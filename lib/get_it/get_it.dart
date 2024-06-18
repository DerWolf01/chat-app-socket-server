import 'package:chat_app_socket_server/active_users/active_users_service.dart';
import 'package:chat_app_socket_server/socket_service/socket_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;
initGetIt() {
  getIt.registerSingleton<SocketService>(SocketService());
  getIt.registerSingleton<ActiveUsersService>(ActiveUsersService());
}
