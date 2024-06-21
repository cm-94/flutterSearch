import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../manager/GlobalController.dart';
import '../utils/CommonColors.dart';
import 'BasePageController.dart';

/// Base Page
abstract class BasePage<T> extends StatelessWidget {
  final String tag;

  // Controller
  late T ctrl;

  final GlobalController _globalCtrl = Get.find<GlobalController>();
  get globalCtrl => _globalCtrl;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // SafeArea 사용여부 체크
  bool isSafeArea;

  BasePage({Key? key, required this.tag, this.isSafeArea = true, T? controller})
      : super(key: key) {
    if (controller != null) {
      ctrl = controller;
    } else {
      ctrl = getController();
    }
  }

  T getController();

  // 각 Page에서 호출
  Widget setBuild();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (ctrl is BasePageController) {
          return (ctrl as BasePageController).onBackPressed();
        }
        return true;
      },
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: CommonColors.bgWhite,
        body: isSafeArea
            ? SafeArea(
            child: setBuild())
            : setBuild(),
      ),
    );
  }
}
