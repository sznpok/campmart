import 'package:flutter_secure_storage/flutter_secure_storage.dart';

FlutterSecureStorage _localStorage = const FlutterSecureStorage();

Future<String?> readTokenAccess() async {
  return _localStorage.read(key: "token");
}

writeTokenAccess(data) {
  return _localStorage.write(key: "token", value: data);
}

deleteTokenAccess() {
  return _localStorage.delete(key: "token");
}
