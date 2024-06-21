import 'package:flutter/foundation.dart';
class LogCat {
  static const bool isEnable = true; //kDebugMode
  static const bool isDebugEnable = true;
  static const bool isVerboseEnable =true;
  static const bool isCommApiEnable =true;
  static const bool isErrorEnable = true;

  static void d(String tag, String msg) {
    if (isEnable && isDebugEnable) {
      print("D|[$tag]$msg");
    }
  }

  static void v(String tag, String msg) {
    if (isEnable && isVerboseEnable) {
      print("V|[$tag]$msg");
    }
  }
  static void i(String tag, String msg) {
    if (isEnable && isCommApiEnable) {
      print("I|[$tag]$msg");
    }
  }

  static void e(String tag, String msg) {
    if (isEnable && isErrorEnable) {
      print("E|[$tag]$msg");
    }
  }

  static void printStackTrace(Object e) {
    if (isEnable && isErrorEnable) {
      print("E|[printStackTrace]${e.toString()}");
    }
  }
}
