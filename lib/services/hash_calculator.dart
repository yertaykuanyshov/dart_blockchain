import 'dart:convert';

import 'package:crypto/crypto.dart';

class HashCalculator {
  String calculate(String data) {
    return sha256.convert(utf8.encode(data)).toString();
  }
}
