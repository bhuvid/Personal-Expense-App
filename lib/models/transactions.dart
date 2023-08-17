import 'package:flutter/foundation.dart';

class Transaction {
  final String id;
  final String name;
  final double amount;
  final DateTime date;
  Transaction(
      {@required this.date,
      @required this.amount,
      @required this.id,
      @required this.name});
}
