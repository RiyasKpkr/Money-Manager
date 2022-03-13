import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_managment/models/transaction/transaction_model.dart';

const TRANSACTION_DB_NAME = 'transaction-db';

abstract class TransactionDbFynctions {
  Future<void> addTransaction(TransactionModel obj);
  Future<List<TransactionModel>> getAllTransations();
  Future<void> deleteTransaction(String id);
}

class TransactionDB implements TransactionDbFynctions {
  TransactionDB._internal();

  static TransactionDB instance = TransactionDB._internal();

  factory TransactionDB() {
    return instance;
  }

  ValueNotifier<List<TransactionModel>> transactionListNotifier =
      ValueNotifier([]);

  @override
  Future<void> addTransaction(TransactionModel obj) async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    _db.put(obj.id, obj);
  }

  Future<void> refresh() async{
    final _list = await getAllTransations();
    _list.sort((first,second)=> second.date.compareTo(first.date));
    transactionListNotifier.value.clear();
    transactionListNotifier.value.addAll(_list);
    transactionListNotifier.notifyListeners();
  }

  @override
  Future<List<TransactionModel>> getAllTransations() async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    return _db.values.toList();
  }

  @override
  Future<void> deleteTransaction(String id) async {
    final _db = await Hive.openBox<TransactionModel>(TRANSACTION_DB_NAME);
    _db.delete(id);
    refresh();
  }
}
