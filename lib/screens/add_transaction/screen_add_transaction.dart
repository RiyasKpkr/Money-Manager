import 'package:flutter/material.dart';
import 'package:money_managment/db/category/category_db.dart';
import 'package:money_managment/db/transactions/transaction_db.dart';
import 'package:money_managment/models/category/category_model.dart';
import 'package:money_managment/models/transaction/transaction_model.dart';

class ScreenaddTransaction extends StatefulWidget {
  static const routeName = 'add-transaction';
  const ScreenaddTransaction({Key? key}) : super(key: key);

  @override
  State<ScreenaddTransaction> createState() => _ScreenaddTransactionState();
}

class _ScreenaddTransactionState extends State<ScreenaddTransaction> {
  DateTime? _selectedDate;
  CategoryType? _selectedCategorytype;
  CategoryModel? _selectedCategorymodel;

  String? _categoryID;

  final _purposeTextEditingController = TextEditingController();
  final _amountTextEditingController = TextEditingController();

  @override
  void initState() {
    _selectedCategorytype = CategoryType.income;
    super.initState();
  }

  /*
  Purpose
  Date
  Amount
  income/Expanse
  Category type
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Purpose
              TextFormField(
                controller: _purposeTextEditingController,
                decoration: const InputDecoration(
                  hintText: 'Purpose',
                ),
              ),
              //Amount
              TextFormField(
                controller: _amountTextEditingController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Amount',
                ),
              ),
              //Date

              TextButton.icon(
                onPressed: () async {
                  final _selectedDateTemp = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now().subtract(
                      const Duration(days: 30),
                    ),
                    lastDate: DateTime.now(),
                  );
                  if (_selectedDateTemp == null) {
                    return;
                  } else {
                    print(_selectedDateTemp.toString());
                    setState(() {
                      _selectedDate = _selectedDateTemp;
                    });
                  }
                },
                icon: const Icon(Icons.calendar_today),
                label: Text(_selectedDate == null
                    ? 'Select Date'
                    : _selectedDate!.toString()),
              ),
              //income / expanse
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Radio(
                        value: CategoryType.income,
                        groupValue: _selectedCategorytype,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCategorytype = CategoryType.income;
                            _categoryID = null;
                          });
                        },
                      ),
                      Text('Income'),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                        value: CategoryType.expanse,
                        groupValue: _selectedCategorytype,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedCategorytype = CategoryType.expanse;
                            _categoryID = null;
                          });
                        },
                      ),
                      Text('Expanse'),
                    ],
                  ),
                ],
              ),
              //category type
              DropdownButton<String>(
                hint: const Text('Select Category'),
                value: _categoryID,
                items: (_selectedCategorytype == CategoryType.income
                        ? CategoryDB().incomeCategoryListListener
                        : CategoryDB().expanseCategoryListListener)
                    .value
                    .map((e) {
                  return DropdownMenuItem(
                    value: e.id,
                    child: Text(e.name),
                    onTap: () {
                      print(e.toString());
                      _selectedCategorymodel = e;
                    },
                  );
                }).toList(),
                onChanged: (selectedValue) {
                  print(selectedValue);
                  setState(() {
                    _categoryID = selectedValue;
                  });
                },
              ),
              //submit
              ElevatedButton(
                onPressed: () {
                  addTransaction();
                },
                child: const Text(
                  'Submit',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addTransaction() async {
    final _purposeText = _purposeTextEditingController.text;
    final _amountText = _amountTextEditingController.text;

    if (_purposeText.isEmpty) {
      return;
    }
    if (_amountText.isEmpty) {
      return;
    }
    // if (_categoryID == null) {
    //   return;
    // }
    if (_selectedDate == null) {
      return;
    }
    if(_selectedCategorymodel == null){
      return;
    }

    final _parseAmount = double.tryParse(_amountText);
    if(_parseAmount == null){
      return;
    }
    //_selectedDate
    //_selectedCategorytype
    //CategoryID
    final _model = TransactionModel(
      purpose: _purposeText,
      amount: _parseAmount,
      date: _selectedDate!,
      type: _selectedCategorytype!,
      category: _selectedCategorymodel!,
    );
    await TransactionDB.instance.addTransaction(_model);
    Navigator.of(context).pop();
    TransactionDB.instance.refresh();
  }
}
