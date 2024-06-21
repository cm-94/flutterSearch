import 'package:flutter/material.dart';
import 'package:flutter_search/utils/CommonColors.dart';
import 'package:get/get.dart';
import '../../base/BasePage.dart';
import 'SplashPageController.dart';

/// 초기 기동 화면
class SplashPage extends BasePage<SplashPageController> {
  static const _TAG = 'SplashPage';

  SplashPage({Key? key}) : super(key: key, isSafeArea: false, tag: _TAG);

  @override
  getController() {
    return Get.put(SplashPageController());
  }

  @override
  Widget setBuild() {
    return Container(
      color: Colors.blueGrey,
      alignment: Alignment.center,
      child: const Text("Splash Page",style: TextStyle(color: CommonColors.txtBlack)),
    );
  }
}
