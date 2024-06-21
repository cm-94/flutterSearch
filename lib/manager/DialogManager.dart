import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../utils/CommonUtils.dart';
import '../utils/LogCat.dart';
import '../utils/CommonColors.dart';
import 'GlobalController.dart';

class DialogManager {
  static const _TAG = 'DialogManager';

  static final DialogManager _instance = DialogManager._();
  static DialogManager get instance => _instance;

  final global = Get.find<GlobalController>();

  // 열려있는 Dialog 수 ( 중복
  int _count = -1;

  DialogManager._();

  bool isShowing() {
    return Get.isDialogOpen!;
  }

  /// 다이얼로그 닫기
  void dismiss<T>({T? result}) {
    /// Dialog 떠있을 때
    if (_count > -1  || Get.isDialogOpen! || Get.isBottomSheetOpen!) {
      try {
        _count--;
      } catch(e) {
        LogCat.printStackTrace(e);
      }
      if (result != null) {
        Get.back(result: result);
      } else {
        Get.back();
      }
    }
  }

  /// 전체 다이얼로그 닫기
  void dismissAll() {
    Completer<bool>? completerDismiss;
    completerDismiss = CommonUtils.periodic(const Duration(microseconds: 300), (cycle) {
      if (Get.isDialogOpen! || Get.isBottomSheetOpen!) {
        Get.back();
      } else {
        completerDismiss?.complete(true);
      }
    });
    _count = -1;
  }

  /// 다이얼로그 띄우기
  Future show(
    DialogType type,
    Widget widget,
    {
      required ,
      EdgeInsetsGeometry? padding = const EdgeInsets.fromLTRB(24, 36, 24, 20),
      BoxDecoration? decoration,
      bool isBarrierColor = true, // 배경색상
      bool isAutoDismiss = true, // 자동 다이얼로그 닫기 기능
      String? title,
    }) async {
    if(_count > 0){
      return;
    }
    LogCat.d(_TAG, '다이얼로그 show : [type: $type]');
    _count++;

    switch (type) {
      /// 일반 다이얼로그 ( 가운데 표시, 메시지박스 등 )
      case DialogType.GENERAL:
        break;
      /// 상단 여백 있는 Bottom Dialog
      case DialogType.BOTTOM:
        break;
      /// 전체화면 다이얼로그
      case DialogType.FULL:
        return await Get.bottomSheet(
          _getDefaultWidget(
            type,
            decoration: decoration ?? const BoxDecoration(
              color: CommonColors.txtWhite,
            ),
            widget: widget,
            height: Get.mediaQuery.size.height,
            padding: padding,
            title : title
          ),
          isScrollControlled: true,
          enableDrag: false,
          isDismissible: false,
          ignoreSafeArea: false,
          enterBottomSheetDuration: const Duration(microseconds: 0), /// bottom 이지만 바로 뜨고
          exitBottomSheetDuration: const Duration(microseconds: 0),  /// 사라지게 보이도록 설정
        );
    }
  }

  // 공통
  Widget _getDefaultWidget(
      DialogType type, {
        Decoration? decoration,
        required Widget widget,
        double? height,
        EdgeInsetsGeometry? margin,
        EdgeInsetsGeometry? padding,
        Alignment align = Alignment.center,
        String? title
      }) {
    return  WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Align(
          alignment: align,
          child: Wrap(
            children: [
              Container(
                margin: margin,
                height: height,
                width: double.maxFinite,
                decoration: decoration,
                padding: padding ?? const EdgeInsets.fromLTRB(24, 36, 24, 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Top Area ( < Button & Title )
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 12, bottom: 4),
                      color: CommonColors.bgWhite,
                      child: Stack(
                        children: [
                          // < Button
                          Container(
                            alignment: Alignment.centerLeft,
                            width: double.infinity,
                            child: InkWell(
                              child: Image.asset("assets/image/icon_arrow_L_24.png", width: 32, height: 32,fit: BoxFit.fill),
                              onTap: () {
                                dismiss(result: false);
                              },
                            ),
                          ),
                          // Title
                          Container(
                            padding: const EdgeInsets.only(left: 32),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              title ?? "",
                              maxLines: 2,
                              textScaleFactor: 1.0,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: CommonColors.black,
                                fontSize: 20,
                                height: 40
                              )
                            )
                          )
                        ],
                      ),
                    ),
                    /// Dialog Contents
                    widget
                  ]
                ),
              )
            ],
          ),
        ));
  }

  /// 토스트 메시지 표시
  static void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: CommonColors.bgToast,
        textColor: CommonColors.txtWhite,
        fontSize: 16.0);
  }
}

enum DialogType {
  GENERAL, // 일반 다이얼로그 (가운데)
  BOTTOM,  // Bottom 다이얼로그
  FULL,    // 전체화면 다이얼로그
}
