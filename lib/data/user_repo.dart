import 'package:dio/dio.dart';
import 'package:registration_staff/config/api.dart';
import 'package:registration_staff/dataobj/login_response_entity.dart';
import 'package:registration_staff/common/req_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'storage_manager.dart';

/// 调用api接口，并转换数据/缓存数据
class UserRepo {
  Future initData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String id = sp.getString(SpKey.KEY_ID);
    print('sp get id:' + id);
    if (id == null) return Future.error('未缓存');
    return doLogin(id);
  }

  Future doLogin(id) async {
    try {
      Map<String, dynamic> res = await ReqModel.get(API.USER_LOGIN, {'identityId': id});

      LoginEntity loginResponseEntity = LoginEntity.fromJson(res);

      // 缓存 身份id
      StorageManager.sp.setString(SpKey.KEY_ID, id);
      StorageManager.sp.setString(SpKey.KTY_ID_NUM, loginResponseEntity.user.id.toString());

      return Future.value(loginResponseEntity);
    } catch (error) {
      return Future.error(error);
    }
  }

  /// 登出，清除sp
  Future logout() async{
    StorageManager.sp.clear();
    print("清除缓存成功清除缓存成功清除缓存成功清除缓存成功清除缓存成功清除缓存成功清除缓存成功清除缓存成功清除缓存成功清除缓存成功");
  }


  // Future register(User user) async {
  //   try {
  //     var res = await ReqModel.post(API.REGISTER, user.toJson());
  //
  //     StorageManager.sp.setString(SpKey.KEY_ID, user.workerIdNum);
  //     return Future.value(User.fromJson(res));
  //   } catch (error) {
  //     return Future.error(error);
  //   }
  // }

  Future confirmHealth(HealthRecord healthRecord) {
    return ReqModel.post(API.CONFIRM_HEALTH, healthRecord.toJson());
  }

  Future confirmActivity(User user) => ReqModel.post(API.CONFIRM_ACTIVITY, user.toJson());
}
