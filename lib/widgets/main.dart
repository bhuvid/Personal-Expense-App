import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import './chart.dart';
import './transaction_list.dart';
import './transaction_input.dart';
import '../models/transactions.dart';

void main() {
  /*
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  */
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Personal Expenses',
        home: MyHomePage(),
        theme: ThemeData(
          primarySwatch: Colors.pink,
          colorScheme: ThemeData()
              .colorScheme
              .copyWith(primary: Colors.pink, secondary: Colors.green),
          fontFamily: 'Opensans',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'Quicksans',
                  fontSize: 17,
                  fontWeight: FontWeight.bold)),
          appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
                fontFamily: 'Quicksans',
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver{

  final List<Transaction> _transaction = [];

  List<Transaction> get _lastWeekTrans {
    return _transaction.where((element) {
      return element.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _delete(int index) {
    setState(() {
      _transaction.removeAt(index);
    });
  }

  void _addTransaction(String title, double amt, DateTime currentDate) {
    final trans = Transaction(
        date: currentDate,
        amount: amt,
        id: DateTime.now().toString(),
        name: title);
    setState(() {
      _transaction.add(trans);
    });
  }

  void _selectTransactionSheet(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addTransaction);
        });
  }

  bool _showChart = false;

  List<Widget> _landscape (AppBar appBar,Widget transactionWidget){
  return [
    Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Show chart"),
                  Switch(
                      activeColor: Colors.green,
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                        });
                      }),
                ],
              ),
                _showChart
                  ? Container(
                      height: (MediaQuery.of(context).size.height -
                              appBar.preferredSize.height -
                              MediaQuery.of(context).padding.top) *
                          0.60,
                      child: Chart(_lastWeekTrans))
                  : transactionWidget
  ];
  }

List<Widget>_portrait(BuildContext context, AppBar appBar,Widget transactionWidget) {
    return [Container(
                    height: (MediaQuery.of(context).size.height -
                            appBar.preferredSize.height -
                            MediaQuery.of(context).padding.top) *
                        0.30,
                    child: Chart(_lastWeekTrans)),
                    transactionWidget];
  }
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }
  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
  @override
  Widget build(BuildContext context) {

    final appBar = AppBar(
      title: const Text('Personal Expenses'),
      actions: [
        IconButton(
          onPressed: () => _selectTransactionSheet(context),
          icon: Icon(Icons.add),
        )
      ],
    );

    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final transactionWidget = Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.60,
        child: TransactionList(_transaction, _delete));

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment:MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape)
            ..._landscape(appBar, transactionWidget)
          ,
          if(!isLandscape)
          ..._portrait(context, appBar,transactionWidget),
          ]
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child:  Icon(Icons.add),
        onPressed: () => _selectTransactionSheet(context),
      ),
    );
  }

}
