import 'dart:convert';
import 'dart:io';

import '../models/bloc.dart';

abstract class BlockchainJsonService {
  Future<void> write(Bloc bloc);

  Future<List<Bloc>> read();
}

class BlockchainJsonServiceImpl implements BlockchainJsonService {
  @override
  Future<void> write(Bloc bloc) async {
    final File blocListFile = File("bloc.json");

    final List<Bloc> addedBlocs = await read();
    addedBlocs.add(bloc);

    final jsonData = addedBlocs.map((e) => e.toJson()).toList();

    final blockData = jsonEncode(jsonData);

    blocListFile.writeAsString(blockData);
  }

  @override
  Future<List<Bloc>> read() async {
    final File blocListFile = File("bloc.json");
    final String data = await blocListFile.readAsString();

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
