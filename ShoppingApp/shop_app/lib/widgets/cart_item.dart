import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';

class CartDetailsItem extends StatelessWidget {
  final String id;
  final double price;
  final int quantity;
  final String title;
  final String productId;

  CartDetailsItem({
    required this.id,
    required this.price,
    required this.quantity,
    required this.title,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(
          Icons.delete,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Are you sure ?'),
            content: Text('Donyou want to remove this item from cart ?'),
            actions: [
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes'),
              ),
            ],
          ),
        );
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                  padding: EdgeInsets.all(2),
                  child: FittedBox(child: Text('\$$price'))),
            ),
            title: Text(title),
            subtitle: Text('Total: \$ ${(price * quantity)}'),
            trailing: Text('x $quantity '),
          ),
        ),
      ),
    );
  }
}
