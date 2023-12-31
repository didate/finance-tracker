import 'package:finance/model/solde.model.dart';
import 'package:finance/model/transaction.model.dart';

abstract class TransactionService {
  Transaction findOne();
  Future<List<Transaction>> findAll(int page);
  Future<Transaction> save(Transaction transaction);
  Future<Transaction> update(Transaction transaction);
  void delete(String id);

  Future<List<Solde>> getSolde();
}
