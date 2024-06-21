import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../base/BasePage.dart';
import '../../utils/CommonColors.dart';
import 'MainPageController.dart';

/// 메인 페이지
class MainPage extends BasePage<MainPageController> {
  static const _TAG = 'MainPage';

  MainPage({Key? key}) : super(key: key, isSafeArea: true, tag: _TAG);

  @override
  getController() {
    return Get.put(MainPageController());
  }

  @override
  Widget setBuild() {
    return const Center(
      child: Text("Main Page",style: TextStyle(color: CommonColors.txtBlack)),
    );
  }
}
