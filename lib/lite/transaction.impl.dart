import 'package:finance/lite/supa.dart';
import 'package:finance/model/solde.model.dart';
import 'package:finance/model/transaction.model.dart';
import 'package:finance/service/transaction.service.dart';
import 'package:finance/utils.dart';

class TransactionImpl extends Supa implements TransactionService {
  @override
  Future<List<Transaction>> findAll(int page) async {
    try {
      int from = (pageSize * page) - pageSize;
      int to = from + pageSize - 1;

      var response = await client
          .from('transaction_cat')
          .select()
          .order('created_at', ascending: false)
          .range(from, to);

      List jsonResponse = response as List;
      List<Transaction> transactions = [];
      for (var i = 0; i < jsonResponse.length; i++) {
        Transaction t = Transaction.fromMap(jsonResponse[i]);
        if (i == 0 ||
            Utils.getDate(
                    Transaction.fromMap(jsonResponse[i - 1]).createdAt!) !=
                Utils.getDate(t.createdAt!)) {
          transactions
              .add(Transaction(dateHeader: Utils.getDate(t.createdAt!)));
        }
        transactions.add(t);
      }
      return transactions; //jsonResponse.map((data) => Transaction.fromMap(data)).toList();
    } catch (e) {
      throw new UnimplementedError();
    }
  }

  @override
  Transaction findOne() {
    // TODO: implement findOne
    throw UnimplementedError();
  }

  @override
  Future<Transaction> save(Transaction transaction) async {
    try {
      var response = await client
          .from('transaction')
          .insert(transaction.toMapWithoutId())
          .select();
      List jsonResponse = response as List;
      Transaction t =
          jsonResponse.map((data) => Transaction.fromMap(data)).toList().first;
      return t;
    } catch (e) {
      print(e);
      throw UnimplementedError();
    }
  }

  @override
  Future<List<Solde>> getSolde() async {
    try {
      var response = await client.from('solde').select();
      List jsonResponse = response as List;
      return jsonResponse.map((data) => Solde.fromMap(data)).toList();
    } catch (e) {
      print(e);
      throw new UnimplementedError();
    }
  }

  @override
  Future<void> delete(String id) async {
    try {
      await client.from('transaction').delete().eq('id', id);
    } catch (e) {
      print(e);
      throw UnimplementedError();
    }
  }

  @override
  Future<Transaction> update(Transaction transaction) async {
    try {
      var response =
          await client.from('transaction').upsert(transaction.toMap()).select();
      List jsonResponse = response as List;
      Transaction t =
          jsonResponse.map((data) => Transaction.fromMap(data)).toList().first;
      return t;
    } catch (e) {
      print(e);
      throw UnimplementedError();
    }
  }
}
