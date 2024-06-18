import 'package:chat_app_socket_server/model/model.dart';

class RegisterMessage extends Model {
  RegisterMessage(this.userId);

  int userId;
  @override
  Map<String, dynamic> toMap() => {"userId": userId};
  RegisterMessage.fromMap(Map map) : userId = map["userId"];
}
