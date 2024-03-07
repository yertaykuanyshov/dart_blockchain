import 'package:dart_blockchain/services/hash_calculator.dart';
import 'package:dart_blockchain/services/json_service.dart';

import '../models/bloc.dart';

class Blockchain {
  Blockchain(
    this._hashCalculator,
    this._blockchainJsonService,
  );

  final HashCalculator _hashCalculator;
  final BlockchainJsonService _blockchainJsonService;

  void add(String text) async {
    var bloc = Bloc(
      text: text,
      date: DateTime.now(),
    );

    final currentBlocHash = _hashCalculator.calculate(bloc.toString());

    final lastBlocHash = await getLastBlocHash();

    bloc = bloc.copyFrom(
      hash: currentBlocHash,
      prevHash: lastBlocHash,
    );

    _blockchainJsonService.write(bloc);
  }

  Future<String> getLastBlocHash() async {
    try {
      final addedBlocs = await _blockchainJsonService.read();
      final lastBloc = addedBlocs.last;
      return _hashCalculator.calculate(lastBloc.toString());
    } catch (e) {
      return "";
    }
  }

  Future<void> mining() async {}
}
