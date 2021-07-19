import 'package:flutter/foundation.dart';
import 'package:registration_staff/data/apply_repo.dart';
import 'package:registration_staff/data/user_repo.dart';
import 'package:registration_staff/dataobj/apply_entity.dart';
import 'package:registration_staff/dataobj/login_response_entity.dart';

/// 申请管理类
class ApplyModel extends ChangeNotifier{
  ApplyRepo _repository = ApplyRepo();
  ApplyEntity applyEntity;

  Future apply(applyEntity,id) async{
    try {
      // 拿到结果
      LoginEntity res = await _repository.doApply(applyEntity);
      //handleLoginResp(res);

      return Future.value(res);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future getDepHeaderList(id) async{
    try {
      // 拿到结果
      LoginEntity res = await _repository.doGetDepHeaderList(id);
      print("获取部门负责人结果 apply_model" + res.toString());
      return Future.value(res);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future getFundsList() async{
    try {
      // 拿到结果
      LoginEntity res = await _repository.doGetFundsList();
      print("获取经费来源结果 apply_model" + res.toString());
      return Future.value(res);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future getLeaderList(id) async{
    try {
      // 拿到结果
      LoginEntity res = await _repository.doGetLeaderList(id);
      print("获取部门领导结果 apply_model" + res.toString());
      return Future.value(res);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future getReasonList() async{
    try {
      // 拿到结果
      LoginEntity res = await _repository.doGetReasonList();
      print("获取出差理由结果 apply_model" + res.toString());
      return Future.value(res);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future getTransportBeyondList() async{
    try {
      // 拿到结果
      LoginEntity res = await _repository.doGetTransportBeyondList();
      print("获取超标原因结果 apply_model" + res.toString());
      return Future.value(res);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future getTransportList() async{
    try {
      // 拿到结果
      LoginEntity res = await _repository.doGetTransportList();
      print("获取交通方式结果 apply_model" + res.toString());
      return Future.value(res);
    } catch (e) {
      return Future.error(e);
    }
  }
  // void handleLoginResp(LoginEntity loginEntity) {
  //   _repository = loginEntity.user;
  //   //_healthRecord = loginEntity.record;
  //   print('user:' + repository.toString());
  //   notifyListeners(); // 通知消费者
  // }

}

