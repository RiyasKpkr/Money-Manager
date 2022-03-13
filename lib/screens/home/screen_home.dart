import 'package:flutter/material.dart';
import 'package:money_managment/db/category/category_db.dart';
import 'package:money_managment/models/category/category_model.dart';
import 'package:money_managment/screens/add_transaction/screen_add_transaction.dart';
import 'package:money_managment/screens/category/category_add_popup.dart';
import 'package:money_managment/screens/category/screen_category.dart';
import 'package:money_managment/screens/home/widgets/bottom_navigation.dart';
import 'package:money_managment/screens/transactions/screen_transaction.dart';

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key}) : super(key: key);

  static ValueNotifier<int> selectedIndexNotifies = ValueNotifier(0);

  final _pages = const [ScreenTransactions(), ScreenCategory()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Money Manager'),
        centerTitle: true,
      ),
      bottomNavigationBar: MoneyManagerBottomNavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndexNotifies,
          builder: (BuildContext context, int updatedIndex, _) {
            return _pages[updatedIndex];
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndexNotifies.value == 0) {
            print('add transaction');
            Navigator.of(context).pushNamed(ScreenaddTransaction.routeName);
          } else {
             print('add category');

             showCategoryAddPopup(context);
            // final _sample = CategoryModel(
            //   id: DateTime.now().millisecondsSinceEpoch.toString(),
            //   name: 'Travel',
            //   type: CategoryType.expanse,
            // );
            // CategoryDB().insertCategory(_sample);
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
