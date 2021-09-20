import 'package:expenses_manager/model/transaction.dart';
import 'package:flutter/material.dart';

import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransactions;
  TransactionList(this.transactions, this.deleteTransactions);
  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (context, constrains) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: constrains.maxHeight * 0.6,
                    child: const Image(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        'https://cdn1.iconfinder.com/data/icons/meo-muop/100/011-sleep-rest-goodnight-zzz-cat-sticker-emoji-512.png',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('No Transaction added yet!')
                ],
              );
            },
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return TransactionItem(
                  transaction: transactions[index],
                  deleteTransaction: deleteTransactions);
            },
            itemCount: transactions.length,
          );
  }
}
