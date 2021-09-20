import 'package:expenses_manager/widgets/chart.dart';
import 'package:expenses_manager/widgets/new_transaction.dart';
import 'package:expenses_manager/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'model/transaction.dart';

void main() {
  // For force stop rotation
  //
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.lightBlue,
      accentColor: Colors.lightBlueAccent,
      fontFamily: 'OpenSans',
      textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            button: TextStyle(
              color: Colors.white,
            ),
          ),
    ),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transaction> _userTransaction = [];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((txx) {
      return txx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime chooseDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: chooseDate);

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _startAddNewTransactiion(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {},
          child: NewTransaction(_addNewTransaction),
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  Widget _potraitContent(
      MediaQueryData mediaQuery, PreferredSizeWidget appBar) {
    return Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.3,
      child: Chart(_recentTransactions),
    );
  }

  Widget _landscapeContent() {
    return Row(
      children: [
        Text('Show Chart', style: Theme.of(context).textTheme.title),
        Switch.adaptive(
          // adaptive is used for IOS style switch
          value: _showChart,
          onChanged: (value) {
            setState(() {
              _showChart = value;
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandScape = mediaQuery.orientation == Orientation.landscape;

    //preferedSizeWidget is used to select preferable size of appBar
    final PreferredSizeWidget appBar;
    if (Platform.isIOS) {
      appBar = CupertinoNavigationBar(
        middle: Text('Expenses Manager!'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              child: const Icon(CupertinoIcons.add),
              onTap: () => _startAddNewTransactiion(context),
            )
          ],
        ),
      );
    } else {
      appBar = AppBar(
        title: const Text('Expenses Manager!'),
        actions: [
          IconButton(
            onPressed: () => _startAddNewTransactiion(context),
            icon: const Icon(Icons.add),
          ),
        ],
      );
    }
    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(_userTransaction, _deleteTransaction),
    );

//pageBody is body for android scaffold and child for cupertino scaffold
    final pagebody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandScape) _landscapeContent(),
            if (isLandScape)
              _showChart
                  ? Container(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.7,
                      child: Chart(_recentTransactions),
                    )
                  : txListWidget,
            if (!isLandScape) _potraitContent(mediaQuery, appBar),
            if (!isLandScape) txListWidget,
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pagebody,
            navigationBar: appBar as ObstructingPreferredSizeWidget,
            //casting appBar for IOS
          )
        : Scaffold(
            appBar: appBar,
            body: pagebody,
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () => _startAddNewTransactiion(context),
                  ),
          );
  }
}
