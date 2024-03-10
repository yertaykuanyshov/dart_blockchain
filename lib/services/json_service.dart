import 'dart:convert';
import 'dart:io';

import '../models/bloc.dart';

abstract class BlockchainJsonService {
  Future<void> write(Bloc bloc);

  Future<List<Bloc>> read();
}

class BlockchainJsonServiceImpl implements BlockchainJsonService {
  final _file = File("bloc.json");

  @override
  Future<void> write(Bloc bloc) async {
    final List<Bloc> addedBlocs = await read();
    addedBlocs.add(bloc);

    final jsonData = addedBlocs.map((e) => e.toJson()).toList();

    final blockData = jsonEncode(jsonData);

    _file.writeAsString(blockData);
  }

  @override
  Future<List<Bloc>> read() async {
    final String data = await _file.readAsString();

    if (data.isEmpty) {
      return [];
    }

    final List<dynamic> jsonData = jsonDecode(data);

    if (jsonData.isNotEmpty) {
      return jsonData.map<Bloc>((e) => Bloc.fromJson(e)).toList();
    }

    return [];
  }
}
