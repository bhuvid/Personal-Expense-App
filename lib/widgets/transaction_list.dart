import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transactions.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTrans;
  TransactionList(this.transactions, this.deleteTrans);

  void deleteTransaction(int index) {
    deleteTrans(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 600,
        child: transactions.isEmpty
            ? LayoutBuilder(
                builder: (context, constraints) => Column(
                  children: [
                    const Text("No transactions"),
                    SizedBox(height: 10),
                    Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset('assets/images/waiting.png',
                          fit: BoxFit.cover),
                    )
                  ],
                ),
              )
            : ListView.builder(
                itemBuilder: (ctx, index) => Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                  elevation: 4,
                  child: ListTile(
                    leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: FittedBox(
                            child: Text(
                                "₹${transactions[index].amount.toStringAsFixed(2)}"),
                          ),
                        )),
                    title: Text(
                      transactions[index].name,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMMd().format(transactions[index].date),
                      style: TextStyle(color: Colors.grey),
                    ),
                    trailing: MediaQuery.of(context).size.width > 400
                        ? TextButton.icon(
                            style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.red)),
                            onPressed: () => deleteTransaction(index),
                            icon: Icon(Icons.delete),
                            label: const Text("Delete"),
                          )
                        : IconButton(
                            onPressed: () => deleteTransaction(index),
                            icon: Icon(Icons.delete),
                            color: Colors.red),
                  ),
                ),
                itemCount: transactions.length,
              ));
  }
}
