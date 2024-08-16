import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showToast({String? title, Color color = Colors.green}) {
  Fluttertoast.showToast(
    msg: title!,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.SNACKBAR,
    timeInSecForIosWeb: 1,
    backgroundColor: color,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
