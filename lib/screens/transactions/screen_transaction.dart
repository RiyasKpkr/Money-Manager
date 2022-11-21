import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:money_managment/db/category/category_db.dart';
import 'package:money_managment/db/transactions/transaction_db.dart';
import 'package:money_managment/models/category/category_model.dart';
import 'package:money_managment/models/transaction/transaction_model.dart';

class ScreenTransactions extends StatelessWidget {
  const ScreenTransactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionDB.instance.refresh();
    CategoryDB.instance.refreshUI();
    return ValueListenableBuilder(
      valueListenable: TransactionDB.instance.transactionListNotifier,
      builder: (BuildContext ctx, List<TransactionModel> newList, Widget? _) {
        return ListView.separated(
          padding: const EdgeInsets.all(10),
          //values
          itemBuilder: (ctx, index) {
            final _value = newList[index];
            return Slidable(
              key: Key(_value.id!),
              startActionPane: ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (ctx) {
                      TransactionDB.instance.deleteTransaction(_value.id!);
                    },
                    icon: Icons.delete,
                    label: 'delete',
                  ),
                ],
              ),
              child: Card(
                color: Colors.amber,
                elevation: 0,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 50,
                    child: Text(
                      parseDate(_value.date),
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    backgroundColor: _value.type == CategoryType.income
                        ? Colors.green
                        : Colors.red,
                  ),
                  title: Text('RS ${_value.amount}',style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Text(_value.category.name,style: TextStyle(fontWeight: FontWeight.bold),),
                ),
              ),
            );
          },
          separatorBuilder: (ctx, index) {
            return const SizedBox(
              height: 10,
            );
          },
          itemCount: newList.length,
        );
      },
    );
  }

  String parseDate(DateTime date) {
    final _date = DateFormat('d/M/y').format(date);
    final _splitedDate = _date.split('/');
    // return '${_splitedDate.first}\n ${_splitedDate.last}';
    return '${_splitedDate[0]}\n${_splitedDate[1]}\n${_splitedDate[2]}';
    //return '${date.day}\n${date.month}';
  }
}
