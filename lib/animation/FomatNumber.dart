import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:intl/intl.dart';
class Format{
  // 12,345,678.90
  static String nonSymbol(double number){
    FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
        amount: number
    );
    MoneyFormatterOutput fo = fmf.output;
    return  fo.nonSymbol;
  }
// 12,345,678.90
  static String symbolOnLeft(double number){
    FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
        amount: number
    );
    MoneyFormatterOutput fo = fmf.output;
    return  fo.symbolOnLeft;
  }
  // 12,345,678.90 $
  static String symbolOnRight(double number){
    FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
        amount: number
    );
    MoneyFormatterOutput fo = fmf.output;
    return  fo.symbolOnRight;
  }
  // 90
  static String fractionDigitsOnly(double number){
    FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
        amount: number
    );
    MoneyFormatterOutput fo = fmf.output;
    return  fo.fractionDigitsOnly;
  }
  // 12,345,678
  static String withoutFractionDigits(double number){
    FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
        amount: number
    );
    MoneyFormatterOutput fo = fmf.output;
    return  fo.withoutFractionDigits;
  }
  // 12.3M
  static String compactNonSymbol(double number){
    FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
        amount: number
    );
    MoneyFormatterOutput fo = fmf.output;
    return  fo.compactNonSymbol;
  }

  static String formatdate(String date){
    String newdate;
    newdate= new DateFormat("dd-MM-yyyy").format(DateTime.parse(date));
    return newdate;
  }


}