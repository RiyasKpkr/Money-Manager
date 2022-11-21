import 'package:flutter/material.dart';
import 'package:money_managment/db/category/category_db.dart';
import 'package:money_managment/screens/category/expanse_category_list.dart';
import 'package:money_managment/screens/category/income_category_list.dart';

class ScreenCategory extends StatefulWidget {
  const ScreenCategory({Key? key}) : super(key: key);

  @override
  State<ScreenCategory> createState() => _ScreenCategoryState();
}

class _ScreenCategoryState extends State<ScreenCategory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDB().refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: Column(
        children: [
          Container(
            height: 45,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius : BorderRadius.circular(25),
            ),
            child: TabBar(
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.amber
              ),
              controller: _tabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.black54,
              tabs: const [
                Tab(
                  text: 'Income',
                ),
                Tab(
                  text: 'Expense',
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                IncomeCategoryList(),
                ExpanseCategoryList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
