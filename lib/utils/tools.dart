import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
class Tools {
  static void setStatusBarColor(Color color) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: color));
  }

  static String allCaps(String str) {
    if(str != null && str.isNotEmpty){
      return str.toUpperCase();
    }
    return str;
  }

  static String getFormattedCardNo(String cardNo){
    if(cardNo.length < 5) return cardNo;
    return cardNo.replaceAllMapped(RegExp(r".{4}"), (match) => "${match.group(0)} ");
  }

  static void directUrl(String link) async {
    

  }

  static DateTime getSimplifiedDate(DateTime dateTime){
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  static DateTime getPreviousDate(DateTime dateTime){
    return dateTime.subtract(const Duration(days: 1));
  }


}
