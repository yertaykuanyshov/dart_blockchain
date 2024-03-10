import 'package:dart_blockchain/services/hash_calculator.dart';
import 'package:dart_blockchain/services/json_service.dart';

import '../models/bloc.dart';

abstract class BlockchainRepository {
  Future<void> addBloc(String text);

  Future<void> validateChain();
}

class BlockchainRepositoryImpl implements BlockchainRepository {
  BlockchainRepositoryImpl(
    this._hashCalculator,
    this._blockchainJsonService,
  );

  final HashCalculator _hashCalculator;
  final BlockchainJsonService _blockchainJsonService;

  @override
  Future<void> addBloc(String text) async {
    try {
      addToBlockchain(text);
    } catch (e) {
      print("Error adding new bloc: $e");
    }
  }

  Future<void> addToBlockchain(String text) async {
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

    await _blockchainJsonService.write(bloc);
  }

  @override
  Future<void> validateChain() async {
    final allBlocs = await _blockchainJsonService.read();

    allBlocs.asMap().forEach((idx, bloc) {
      bool isNotFirstBloc = idx != 0;

      if (isNotFirstBloc) {
        final prevBloc = allBlocs[idx - 1];
        final prevBlocHash = _hashCalculator.calculate(prevBloc.toString());
        final currentBlocPrevHash = allBlocs[idx].prevHash;

        if (currentBlocPrevHash != prevBlocHash) {
          print("Chain: $idx not valid");
          return;
        }
      }
    });
  }

  /// Get last bloc hash. If first block return empty;

  Future<String> getLastBlocHash() async {
    try {
      final addedBlocs = await _blockchainJsonService.read();
      final lastBloc = addedBlocs.last;
      return _hashCalculator.calculate(lastBloc.toString());
    } catch (e) {
      return "";
    }
  }
}
