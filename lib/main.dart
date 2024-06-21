import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_search/manager/GlobalController.dart';
import 'package:flutter_search/router/PageRouter.dart';
import 'package:flutter_search/utils/CommonColors.dart';
import 'package:get/get.dart';

void main() async {
  /// 상태표시줄 색상 => 투명
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: CommonColors.transparent, // transparent status bar
  ));

  /// 최초 초기화 데이터 세팅
  GlobalController globalController = Get.put(GlobalController());
  await globalController.initData();

  /// 앱 실행
  runApp(const FlutterSearchApp());
}

class FlutterSearchApp extends StatelessWidget {
  const FlutterSearchApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: PageRouter.route,
      initialRoute: '/splashPage',
    );
  }
}