import 'package:registration_staff/common/req_model.dart';
import 'package:registration_staff/config/api.dart';

class Abolish{
  //撤销出差申请
  Future doAbolish(int applicationId, int userId) async {
    try {
      var res = await ReqModel.get(API.ABOLISH, {'applicationId':applicationId, 'userId':userId});
      return Future.value(res);
    } catch (error) {
      return Future.error(error);
    }
  }

  //撤销出差总结


  //同意申请（填报端只有正主任有权限）
  Future doAggree(int applicationId, int type, int userId) async {
    try {
      var res = await ReqModel.get(API.CHECK, {'applicationId':applicationId, 'userId':userId, 'type':type});
      print("同意申请操作测试 : " + res.toString());
      return Future.value(res);
    } catch (error) {
      return Future.error(error);
    }
  }
}