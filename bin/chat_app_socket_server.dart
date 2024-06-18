import 'package:chat_app_socket_server/get_it/get_it.dart';
import 'package:chat_app_socket_server/socket_service/socket_service.dart';

void main(List<String> arguments) async {
  initGetIt();
  await getIt<SocketService>().createServer();
}
