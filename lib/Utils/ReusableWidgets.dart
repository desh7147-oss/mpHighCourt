import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReusableWidgets {
  static SnackBar getSnackBar(
      BuildContext context, String message, Color color) {
    return SnackBar(
      content: Text('$message'),
      backgroundColor: color,
      elevation: 4.0,
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 5.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
    );
  }
}
