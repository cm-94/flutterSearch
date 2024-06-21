import 'package:get/get.dart';
import '../page/main/MainPage.dart';
import '../page/splash/SplashPage.dart';

/// 화면 전환 정보
class PageRouter {
  static final route = [
    // 스플레쉬. 기동화면
    GetPage(
      name: '/splashPage',
      page: () => SplashPage(),
        transition: Transition.noTransition
    ),
    // 메인 화면
    GetPage(
      name: '/mainPage',
      page: () => MainPage(),
      transition: Transition.noTransition
    ),
  ];
}