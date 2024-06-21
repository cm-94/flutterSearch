import 'package:flutter/material.dart';
import 'package:flutter_search/manager/DialogManager.dart';
import 'package:get/get.dart';
import '../utils/CommonUtils.dart';
import '../utils/LogCat.dart';

/// 공통 페이지 컨트롤러
abstract class BasePageController<T> extends GetxController {
  static const _TAG = 'BasePageController';


  // 앱 종료
  static const snackBarDuration = Duration(seconds: 2);
  DateTime? backButtonPressTime;

  @override
  void onInit() {
    super.onInit();
    try {
      LogCat.d(_TAG, '[$_TAG]onInit');
    } catch (e) {
      LogCat.printStackTrace(e);
    }
  }

  @override
  void onReady() {
    super.onReady();
    try {
      LogCat.d(_TAG, '[$_TAG]onReady');
    } catch (e) {
      LogCat.printStackTrace(e);
    }
  }

  @override
  void onClose() {
    super.onClose();
    try {
      LogCat.d(_TAG, '[$_TAG]onClose');
    } catch (e) {
      LogCat.printStackTrace(e);
    }
  }

  Future<bool> onBackPressed() async {
    // 뒤로 버튼 연속 터치시 종료
    if (!(await handlePop(Get.context!))) {
      return false;
    }
    backButtonPressTime = null;
    CommonUtils.appExit();
    return true;
  }

  Future<bool> handlePop(BuildContext context) async {
    final now = DateTime.now();
    final backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
        backButtonPressTime == null || now.difference(backButtonPressTime!) > snackBarDuration;

    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
      backButtonPressTime = now;
      DialogManager.showToast('뒤로 버튼을 한번 더 누르시면 종료됩니다.'.tr);
      return false;
    }

    return true;
  }

  String getControllerTag();
}
