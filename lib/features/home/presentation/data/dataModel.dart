class DetailDataModel {
  int? id;
  String name;
  String number;
  double? totalCredit;
  double? totalDebit;
  double? balance;

  DetailDataModel({
    this.id,
    required this.name,
    required this.number,
    this.totalCredit,
    this.totalDebit,
    this.balance,
  });

  factory DetailDataModel.fromMap(Map<String, dynamic> map) {
    return DetailDataModel(
      name: map["name"],
      number: map["number"],
      id: map["id"],
      totalCredit: double.tryParse(map["total_credit"].toString()),
      totalDebit: double.tryParse(map["total_debit"].toString()),
      balance: double.tryParse(map["balance"].toString()),
    );
  }

  Map<String, dynamic> toMap() {
    return {"name": name, "number": number};
  }
}



class TransactionModel {
  int? id;
  int userId;
  int isSend;
  double amount;
  String remarks;
  DateTime dateTime;

  TransactionModel({
    this.id,
    required this.userId,
    required this.isSend,
    required this.amount,
    required this.remarks,
    required this.dateTime,
  });

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      userId: map['user_id'],
      isSend: map['is_send'],
      amount: map['amount'],
      remarks: map['remarks'],
      dateTime: map['date_time'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['date_time'] as int)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'is_send': isSend,
      'amount': amount,
      'remarks': remarks,
      'date_time': dateTime.millisecondsSinceEpoch,
    };
  }
}
