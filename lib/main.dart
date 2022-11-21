import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:money_managment/db/category/category_db.dart';
import 'package:money_managment/models/category/category_model.dart';
import 'package:money_managment/models/transaction/transaction_model.dart';
import 'package:money_managment/screens/add_transaction/screen_add_transaction.dart';

import 'package:money_managment/screens/home/screen_home.dart';

Future<void> main() async{


  final ob1 = CategoryDB();
  final ob2 = CategoryDB();
  // print('object comparison');
  // print(ob1 == ob2);


  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }


  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }

  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const ScreenHome(),
      routes: {
        ScreenaddTransaction.routeName:(ctx) => const ScreenaddTransaction(),
      },
    );
  }
}
