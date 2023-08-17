import 'package:flutter/material.dart';
import './bar_chart.dart';
import '../models/transactions.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> trans;

  Chart(this.trans);

  List<Map<String, Object>> get lastTransaction {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double total = 0.0;
      for (var i = 0; i < trans.length; i++) {
        if (trans[i].date.day == weekDay.day &&
            trans[i].date.month == weekDay.month &&
            trans[i].date.year == weekDay.year) {
          total += trans[i].amount;
        }
      }
      return {"day": DateFormat.E().format(weekDay).substring(0,1), "amt": total};
    }).reversed.toList();
  }

  double get weekamount {
    return lastTransaction.fold(
        0.0, (previousValue, element) => previousValue + element['amt']);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(15),
      child: 
      Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children:
          lastTransaction.map((val) => 
          Flexible(
            fit: FlexFit.tight,
            child: Bar(
                val['day'], val['amt'],weekamount==0.0 ? 0.0:((val['amt'] as double) / weekamount)),
          ))
              .toList()
        ),
      ),
    );
  }
}
