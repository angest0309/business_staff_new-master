import 'package:registration_staff/common/req_model.dart';
import 'package:registration_staff/config/api.dart';
import 'package:registration_staff/dataobj/apply_repo_entity.dart';

class ApplyRepo{
  //获取全部
  Future getAllList(userID) async{
    try{
      var res = await ReqModel.get(API.GET_HISLIST, {"type":0,"userId":userID});
      print("getAllList success:"+res.toString());
      return Future.value(ApplyRepoEntity.fromJsonList(res));
    }catch(error){
      print("getAllList error:"+error.toString());
      return Future.error(error);
    }
  }

  //获取未通过 被拒绝
  Future getWaitList(userID) async{
    try{
      var res = await ReqModel.get(API.GET_HISLIST, {"type":1,"userId":userID});
      List<ApplyRepoEntity> result = new List<ApplyRepoEntity>();
      List<ApplyRepoEntity> t = ApplyRepoEntity.fromJsonList(res);
      for(int i = 0;i<t.length;i++){
        if(t[i].status == 5){
          result.add(t[i]);
          print(t[i].id.toString());
        }
      }
      print("getWaitList success:"+res.toString());
      return Future.value(result);
    }catch(error){
      print("getWaitList error:"+error.toString());
      return Future.error(error);
    }
  }

  //获取已通过
  Future getAcceptList(userID) async{
    try{
      var res = await ReqModel.get(API.GET_HISLIST, {"type":2,"userId":userID});
      print("getAcceptList success:"+res.toString());
      return Future.value(ApplyRepoEntity.fromJsonList(res));
    }catch(error){
      print("getAcceptList error:"+error.toString());
      return Future.error(error);
    }

  }
  //获取作废
  Future getCancelList(userID) async{
    try{
      var res = await ReqModel.get(API.GET_HISLIST, {"type":3,"userId":userID});
      print("getCancelList success:"+res.toString());
      return Future.value(ApplyRepoEntity.fromJsonList(res));
    }catch(error){
      print("getCancelList error:"+error.toString());
      return Future.error(error);
    }
  }
}