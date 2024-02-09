// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:wac_test_001/view/widgets/custom_text.dart';

showSnackBar(BuildContext context, String message,
    {Color? color,
    Duration? duration,
    double margin = 10,
    SnackBarAction? action}) {
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    action: action,
    //   margin: EdgeInsets.only(bottom: margin),
    elevation: 5.0,
    behavior: SnackBarBehavior.floating,

    duration: duration ?? const Duration(seconds: 1),
    content: CustomText(
      name: message,
      fontsize: 18,
      fontweight: FontWeight.bold,
      color: Colors.white,
      maxlines: 5,
    ),
    backgroundColor: color ?? Colors.red,
  ));
}
