import 'package:dart_blockchain/blochchain_repository.dart';
import 'package:dart_blockchain/services/hash_calculator.dart';
import 'package:dart_blockchain/services/json_service.dart';

void main() async {
  final hashCalculator = HashCalculator();
  final blockchainJsonService = BlockchainJsonServiceImpl();
  final app = Blockchain(hashCalculator, blockchainJsonService);

  app.addBloc("How are you!");
}
