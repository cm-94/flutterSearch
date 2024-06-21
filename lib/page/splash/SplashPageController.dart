import 'dart:async';

import 'package:flutter_search/utils/CommonUtils.dart';
import 'package:get/get.dart';

import '../../base/BasePageController.dart';
import '../../utils/LogCat.dart';

/// Splash
class SplashPageController extends BasePageController<SplashPageController> {
  static const TAG = 'SplashPageController';

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    Timer(const Duration(seconds: 5), () {
      Get.offAllNamed('/mainPage');
    });
  }

  @override
  void onClose() async {
    super.onClose();
  }

  @override
  String getControllerTag() {
    return TAG;
  }
}
