import 'package:dart_blockchain/repositories/blockchain_repository.dart';
import 'package:dart_blockchain/services/hash_calculator.dart';
import 'package:dart_blockchain/services/json_service.dart';

void main() async {
  final hashCalculator = HashCalculator();
  final blockchainJsonService = BlockchainJsonServiceImpl();

  final blockchain = BlockchainRepositoryImpl(
    hashCalculator,
    blockchainJsonService,
  );

  blockchain.validateChain();
}
