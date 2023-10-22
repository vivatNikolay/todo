import 'dart:convert';

class CryptoService {

  static String encrypt(String string) {
    var bytes = utf8.encode(string);
    return base64Encode(bytes);
  }
}