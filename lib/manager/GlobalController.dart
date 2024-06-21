import 'dart:async';
import '../base/BasePageController.dart';
import '../utils/LogCat.dart';
import '../utils/StoreUtils.dart';

/// 전역 페이지 컨트롤러(앱 기동중 계속 생존)
class GlobalController extends BasePageController<GlobalController> {
  static const TAG = 'GlobalController';

  @override
  String getControllerTag() {
    return TAG;
  }

  @override
  void onInit() async {
    super.onInit();
    LogCat.d(TAG, 'onInit');
  }

  @override
  void onReady() {
    super.onReady();
    LogCat.d(TAG, 'onReady');
  }

  @override
  void onClose() {
    super.onClose();
    LogCat.d(TAG, 'onClose');
  }

  Future<void> initData() async {
    // 로컬 저장 클래스 초기화
    await StoreUtils.instance.init();
  }
}

