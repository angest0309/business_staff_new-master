
import 'package:registration_staff/common/req_model.dart';
import 'package:registration_staff/config/api.dart';
import 'package:registration_staff/dataobj/summer_entity.dart';

class SummerRepo{

  var res;

  //提交总结
  Future doSummer(SummerEntity summerEntity) async {
    try {
      print(res.toString());
      res = await ReqModel.post(API.SUMMER, summerEntity.toJson());
      return Future.value(res);
    } catch (error) {
      print("（0123测试）applyPost() : " + res.toString());
      return Future.error(error);
    }
  }

  //获取总结
  Future doGetOneSummer(int applicationId) async {
    try{
      var res = await ReqModel.get(API.GET_ONESUMMER, {'applicationId': applicationId});
      return Future.value(SummerEntity.fromJson(res));
    }catch(error){
      print(error);
      return Future.error(error);
    }
  }

  //删除出差总结
  // Future delSummer(SummerEntity summerEntity) async {
  //   try{
  //     var res = await ReqModel.get(API.DEL_SUMMER, {'applicationId':applicationId, 'userId':userId});
  //     return Future.value(res);
  //   }catch(error){
  //     print(error);
  //     return Future.error(error);
  //   }
  // }

  //删除出差总结
  Future delSummer(int applicationId) async {
    try{
      var res = await ReqModel.get(API.DEL_SUMMER, {'applicationId': applicationId});
      return Future.value(res);
    }catch(error){
      print(error);
      return Future.error(error);
    }
  }

  //上传出差文件
  Future UpSummerFile(id) async {
    // try{
    //   var res = await ReqModel.get(API.UPLOAD_SUMMER_FILE, {'fileId': id});
    //   return Future.value(res);
    // }catch(error){
    //   print(error);
    //   return Future.error(error);
    // }
  }

  //删除出差文件
  Future delSummerfile(id) async {
    try{
      var res = await ReqModel.get(API.DEL_SUMMER_FILE, {'fileId': id});
      return Future.value(res);
    }catch(error){
      print(error);
      return Future.error(error);
    }
  }

  //获取总结列表
  Future doGetSummerList(int id) async {
    try{
      List<dynamic> res = await ReqModel.get(API.GET_SUMMERLIST, {'userId': id});
      return Future.value(res);
    }catch(error){
      print(error);
      return Future.error(error);
    }
  }

}