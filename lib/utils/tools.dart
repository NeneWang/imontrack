import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
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

  static String getFormattedDateShort(int time) {
    DateFormat newFormat = new DateFormat("MMM dd, yyyy");
    return newFormat.format(new DateTime.fromMillisecondsSinceEpoch(time));
  }

    static String getFormattedDateShortDateTime(DateTime time) {
    DateFormat newFormat = new DateFormat("MMM dd, yyyy");
    return newFormat.format(time);
  }

  static String getFormattedDateSimple(int time) {
    DateFormat newFormat = new DateFormat("yyyy-MM-dd");
    return newFormat.format(new DateTime.fromMillisecondsSinceEpoch(time));
  }

  static String getFormattedDateEvent(int time) {
    DateFormat newFormat = new DateFormat("EEE, MMM dd yyyy");
    return newFormat.format(new DateTime.fromMillisecondsSinceEpoch(time));
  }

  static String getFormattedTimeEvent(int time) {
    DateFormat newFormat = new DateFormat("h:mm a");
    return newFormat.format(new DateTime.fromMillisecondsSinceEpoch(time));
  }

    static String getFormattedTimeEventDateTime(DateTime time) {
    DateFormat newFormat = new DateFormat("h:mm a");
    return newFormat.format(time);
  }

}
