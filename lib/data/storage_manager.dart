import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  /// app全局配置
  static SharedPreferences sp;

  /// 网络连接
  var connect;

  /// 必备数据的初始化操作
  static init() async {
    // async 异步操作
    // sync 同步操作
    sp = await SharedPreferences.getInstance();
  }
}

class SpKey {
  static const KEY_ID = "key_user_data";
  static const KTY_ID_NUM = "key_user_id_num";
  static const KET_NAME = "key_user_name";
}
