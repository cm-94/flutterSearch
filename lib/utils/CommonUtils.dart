import 'dart:async';
import 'dart:io';
import 'dart:io' show Platform;
import 'package:flutter/services.dart';
import 'LogCat.dart';

/// 공통 유틸 클래스
class CommonUtils {
  CommonUtils._();

  /// 앱 종료. 딜레이 필요
  /// (https://stackoverflow.com/questions/45109557/flutter-how-to-programmatically-exit-the-app)
  static void appExit({bool isSplashScreen = false}) {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
      Future.delayed(const Duration(microseconds: 200), () {
        exit(0);
      });
    } else if (Platform.isIOS) {
      Future.delayed(const Duration(microseconds: 100), () {
        exit(0);
      });
    }
  }

  /// 타이머
  static Completer<bool> periodic(Duration interval, Function(int cycle) callback) {
    final done = Completer<bool>();
    () async {
      var cycle = 0;
      while (!done.isCompleted) {
        try {
          await callback(cycle);
        } catch (e, s) {
          LogCat.d("$e", s.toString());
        }
        cycle++;
        await done.future
            .timeout(interval)
            .onError((error, stackTrace) => true);
      }
    }();
    return done;
  }

  /// 현재 날짜 취득
  static String getDateTime(){
    DateTime now = DateTime.now();
    var result = "${now.year}${(now.month < 10? "0${now.month}" : now.month)}${(now.day < 10? "0${now.day}" : now.day)}";
    return result;
  }
}
