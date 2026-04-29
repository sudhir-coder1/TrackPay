import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:flutter_native_contact_picker/model/contact.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import '../data/dataModel.dart';

class HomeController extends GetxController {
  Database? _database;

  @override
  void onInit() {
    _loadDatabase();
    super.onInit();
  }

  final detailsList = <DetailDataModel>[].obs;

  final String _tableName = "CONTACT";
  final String _id = "id";
  final String _name = "name";
  final String _number = "number";

  Future<void> _loadDatabase() async {
    var dataBasePath = await getDatabasesPath();
    var path = "$dataBasePath/details.db";
    final db = await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE $_tableName($_id INTEGER PRIMARY KEY,$_name TEXT,$_number TEXT)",
        );
        await db.execute(
          "CREATE TABLE transactionPayment (id INTEGER PRIMARY KEY AUTOINCREMENT,user_id INTEGER,is_send INTEGER,amount REAL, remarks TEXT,date_time INTEGER)",
        );
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute(
            "CREATE TABLE IF NOT EXISTS transactionPayment (id INTEGER PRIMARY KEY AUTOINCREMENT,user_id INTEGER,is_send INTEGER,amount REAL, remarks TEXT,date_time INTEGER)",
          );
        }
      },
    );
    _database = db;
    _loadData();
  }

  Future<void> saveData(DetailDataModel model) async {
    if (_database == null) {
      Get.snackbar("Error", "DataBase not found");
    }
    final result = await _database?.insert(_tableName, model.toMap());
    if (result != null && result > 0) {
      _loadData();
    }
  }

  Future<void> _loadData() async {
    if (_database == null) {
      Get.snackbar("Error", "Database Not found");
      return;
    }
    final records = await _database?.rawQuery('''
    SELECT 
      c.id,
      c.name,
      c.number,
      
      IFNULL(SUM(CASE WHEN t.is_send = 1 THEN t.amount ELSE 0 END), 0.0) AS total_credit,
      
      IFNULL(SUM(CASE WHEN t.is_send = 0 THEN t.amount ELSE 0 END), 0.0) AS total_debit,
      
      IFNULL(SUM(CASE WHEN t.is_send = 1 THEN t.amount ELSE 0 END), 0.0) - IFNULL(SUM(CASE WHEN t.is_send = 0 THEN t.amount ELSE 0 END), 0.0) 
      AS balance
    FROM CONTACT c
    LEFT JOIN transactionPayment t ON t.user_id = c.id
    GROUP BY c.id''');
    if (records != null) {
      detailsList.assignAll(records.map((e) => DetailDataModel.fromMap(e)));
    }
  }

  Future<void> selectContact() async {
    final FlutterNativeContactPicker contactPicker =
        FlutterNativeContactPicker();
    Contact? contact = await contactPicker.selectContact();

    if (contact != null) {
      saveData(
        DetailDataModel(
          name: contact.fullName ?? "",
          number: contact.phoneNumbers?.first ?? "",
        ),
      );
    }
  }
}
