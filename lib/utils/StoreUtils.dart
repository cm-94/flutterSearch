import 'package:shared_preferences/shared_preferences.dart';

/// 로컬 메모리 저장 유틸 클래스
class StoreUtils {
  static const _TAG = 'StoreUtils';
  StoreUtils._();

  /// singleton
  static final StoreUtils _instance = StoreUtils._();

  static StoreUtils get instance => _instance;

  SharedPreferences? _box;

  /// 초기화시 설정이 필요한 항목을 처리
  Future<void> init() async {
    _box = await SharedPreferences.getInstance();
    await _box!.reload();
  }

  /// 초기화
  void reset() {
    _box?.clear();
  }

  /// 스플래시 or 락스크린 데이터 전체 취득
  String? getSharedString(String key){
    if (_box == null) return null;
    if (!_box!.containsKey(key)) {
      return null;
    }
    else{
      return _box!.getString(key)!;
    }
  }

  /// 스플래시 or 락스크린 데이터 전체 저장
  Future<void> setSharedString(String key,String? data) async {
    if (_box == null) return;
    if(data == null){
      await _box!.remove(key);
    }
    else{
      await _box!.setString(key, data);
    }
  }
}