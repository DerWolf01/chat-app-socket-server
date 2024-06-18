import 'package:chat_app_socket_server/model/model.dart';

class SocketMessage<T extends Model> extends Model {
  SocketMessage(this.content);

  T content;
  @override
  Map<String, dynamic> toMap() {
    return {"type": content.runtimeType.toString(), ...content.toMap()};
  }
}
