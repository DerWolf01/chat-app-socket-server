import 'dart:mirrors';
import 'package:chat_app_socket_server/model/model.dart';

List<ClassMirror> findSubClasses(Type type) {
  ClassMirror classMirror = reflectClass(type);

  return currentMirrorSystem()
      .libraries
      .values
      .expand((lib) => lib.declarations.values)
      .where((lib) {
    return lib is ClassMirror &&
        lib.isSubclassOf(classMirror) &&
        lib != classMirror;
  }).toList() as List<ClassMirror>;
}

List<ClassMirror> findModels() => findSubClasses(Model);

Map<String, ClassMirror> findModelsAsMap() => Map.fromEntries(findModels().map(
      (m) => MapEntry(m.reflectedType.toString(), m),
    ));

ClassMirror? findModelByName(String name) => findModels().where(
      (element) {
        print(element.reflectedType);
        return element.reflectedType.toString() == name;
      },
    ).firstOrNull;
