import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class AdaptiveFlatButton extends StatelessWidget {
  final String butttonText;
  final void Function() clickHandler;

  AdaptiveFlatButton(this.butttonText, this.clickHandler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: clickHandler,
            child: Text(
              butttonText,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        : FlatButton(
            textColor: Theme.of(context).primaryColor,
            onPressed: clickHandler,
            child: Text(
              butttonText,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          );
  }
}
