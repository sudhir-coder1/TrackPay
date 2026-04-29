import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../home/presentation/data/dataModel.dart';

class PaymentController extends GetxController {

  IconData get balanceIcon {
    if (netBalance < 0) {
      return Icons.arrow_downward;
    } else if (netBalance > 0) {
      return Icons.arrow_upward;
    } else {
      return Icons.account_balance_wallet;
    }
  }

  double get netBalance {
    double balance = 0;

    for (var item in paymentList) {
      if (item.isSend == 1) {
        balance -= item.amount;
      } else {
        balance += item.amount;
      }
    }

    return balance;
  }

  String get balanceLabel {
    if (netBalance < 0) {
      return "RECEIVE";
    } else if (netBalance > 0) {
      return "PAY";
    } else {
      return "SETTLED";
    }
  }


  String formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  String formatTime(DateTime time) {
    int hour = time.hour % 12;
    if (hour == 0) hour = 12;

    String period = time.hour >= 12 ? "PM" : "AM";

    return "$hour:${time.minute.toString().padLeft(2, '0')} $period";
  }


  Future<void> makeCall(String number) async {
    final Uri uri = Uri.parse("tel:$number");

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      print("Call test");
    }
  }

  late DetailDataModel data;

  final amountController = TextEditingController();
  final notesController = TextEditingController();

  var isPay = true.obs;



  final paymentList = <TransactionModel>[].obs;

  void selectPay() {
    isPay.value = true;
  }

  void selectReceive() {
    isPay.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    data = Get.arguments;
    _loadDataBase();

  }

  Database? _db;

  final _table = 'transactionPayment';




  Future<void> _loadDataBase() async {
    var dataBasePath = await getDatabasesPath();
    var path = "$dataBasePath/details.db";
    final db = await openDatabase(
      path,
      version: 3,
      onUpgrade: (db, olderVersion, newVersion) async {
        log("_loadDataBase $olderVersion  $newVersion ");
        await db.execute(
            "CREATE TABLE IF NOT EXISTS $_table (id INTEGER PRIMARY KEY AUTOINCREMENT,user_id INTEGER,is_send INTEGER,amount REAL, remarks TEXT,date_time INTEGER)"
        );
      },
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE $_table (id INTEGER PRIMARY KEY AUTOINCREMENT,user_id INTEGER,is_send INTEGER,amount REAL, remarks TEXT,date_time INTEGER)",
        );
      },
    );
    _db = db;
    _loadPayment();
  }





  Future<void> savePayment(TransactionModel model) async {
    if (_db == null) {
      Get.snackbar("Error", "DataBase not found");
    }
    final result = await _db?.insert(_table, model.toMap());
    if (result != null && result > 0) {
      Get.back();
      _loadPayment();
    }
  }

  Future<void> _loadPayment() async {
    if (_db == null) {
      Get.snackbar("Error", "Database Not found");
      return;
    }

    final records = await _db?.query(
      _table,
      where: 'user_id = ?',
      whereArgs: [data.id],
      orderBy: 'date_time ASC',
    );

    if (records != null) {
      paymentList.assignAll(
        records.map((e) => TransactionModel.fromMap(e)),
      );
    }
  }
}
