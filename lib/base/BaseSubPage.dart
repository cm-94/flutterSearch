import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../manager/GlobalController.dart';

/// Base Page
abstract class BaseSubPage<T> extends StatelessWidget {
  String tag;

  // 서버 타이틀
  String serverTitle = '';

  // Controller
  late T ctrl;

  final GlobalController _globalCtrl = Get.find<GlobalController>();
  get globalCtrl => _globalCtrl;

  BaseSubPage({Key? key, required this.tag, T? controller}) : super(key: key) {
    if (controller != null) {
      ctrl = controller;
    } else {
      ctrl = getController();
    }
  }

  T getController();

  // 화면에서 사용
  Widget setBuild();

  @override
  Widget build(BuildContext context) {
    return setBuild();
  }
}
