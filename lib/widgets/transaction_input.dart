import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;
  NewTransaction(this.addTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _nameController = TextEditingController();

  final _amountController = TextEditingController();
  DateTime _selectedDate;
  void _add_transaction() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final name = _nameController.text;
    final amt = double.parse(_amountController.text);
    if (name.isEmpty || amt <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTransaction(name, amt, _selectedDate);
    Navigator.of(context).pop();
  }

  void _getDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
            primary: Colors.green,
          )),
          child: child,
        );
      },
    ).then((val) {
      if (val == null) {
        return;
      }
      setState(() {
        _selectedDate = val;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
          elevation: 3,
          child: Container(
              margin: EdgeInsets.only(
                top: 10,left: 10,right: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom +10
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: "Product"),
                    controller: _nameController,
                    keyboardType: TextInputType.text,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: "Amount"),
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    onSubmitted: (_) => _add_transaction(),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: Text(_selectedDate == null
                              ? "No Date Selected"
                              : "Selected Date:${DateFormat.yMd().format(_selectedDate)}")),
                      TextButton(
                          onPressed: _getDate,
                          child: Text(
                            "Choose Date",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          style: TextButton.styleFrom(
                              primary: Theme.of(context).colorScheme.secondary))
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () => _add_transaction(),
                    child: const Text("Add Transaction"),
                    style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).colorScheme.secondary),
                  ),
                ],
              ))),
    );
  }
}
