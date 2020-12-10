import 'package:flutter/material.dart';

authSnackBar({String msg, BuildContext context}) {
  Scaffold.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
      backgroundColor: Theme.of(context).errorColor,
    ),
  );
}
