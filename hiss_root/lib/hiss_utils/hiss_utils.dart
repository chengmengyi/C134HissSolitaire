import 'dart:convert';
import 'dart:math';
import 'dart:ui';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

extension StColor on String{
  Color toColor(){
    var hexStr = replaceAll("#", "");
    return Color(int.parse(hexStr, radix: 16)).withAlpha(255);
  }
}

extension ShowToast on String{
  showToast(){
    if(isEmpty){
      return;
    }
    Fluttertoast.showToast(
      msg: this,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black45,
      textColor: Colors.white,
      fontSize: 16,
    );
  }
}

extension RandomList on List{
  random()=> this[Random().nextInt(length)];
}

String formatHMS(int seconds) {
  int h = seconds ~/ 3600;
  int m = (seconds % 3600) ~/ 60;
  int s = seconds % 60;

  String hh = h.toString().padLeft(2, '0');
  String mm = m.toString().padLeft(2, '0');
  String ss = s.toString().padLeft(2, '0');
  return "$hh:$mm:$ss";
}

String getTodayTime(){
  var dateTime = DateTime.now();
  return "${dateTime.year}-${dateTime.month}-${dateTime.day}";
}

String getTodayEn(){
  final result = DateFormat('MMM dd, yyyy', 'en_US').format(DateTime.now());
  return result;
}

String userNameStar(String name){
  var length = name.length;
  if(length<=1){
    return name;
  }else if(length<=2){
    return "${name.substring(0,1)}*";
  }else if(length<=3){
    return "${name.substring(0,2)}*";
  }else{
    return "${name.substring(0,3)}***";
  }
}

extension StringBase64 on String{
  String base64()=>const Utf8Decoder().convert(base64Decode(this));
}


showToast(String s){
  if(s.isEmpty){
    return;
  }
  Fluttertoast.showToast(
    msg: s,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black45,
    textColor: Colors.white,
    fontSize: 16,
  );
}

extension Strint2Double on String{
  double toDouble(){
    try{
      return double.parse(this);
    }catch(e){
      return 0.0;
    }
  }
}

double doubleAdd(num1,num2){
  try{
    return (Decimal.parse("$num1")+Decimal.parse("$num2")).toDouble();
  }catch(e){
    return 0.0;
  }
}


double doubleSub(num1,num2){
  try{
    return (Decimal.parse("$num1")-Decimal.parse("$num2")).toDouble();
  }catch(e){
    return 0.0;
  }
}


double doubleMul(num1,num2){
  try{
    return (Decimal.parse("$num1")*Decimal.parse("$num2")).toDouble();
  }catch(e){
    return 0.0;
  }
}

double doubleDiv(num1,num2){
  try{
    return (Decimal.parse("$num1")/Decimal.parse("$num2")).toDouble();
  }catch(e){
    return 0.0;
  }
}