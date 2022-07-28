
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class MyToast{
  static myToastShow({required String text, required Color color}){
    Fluttertoast.showToast(
        msg: text,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}