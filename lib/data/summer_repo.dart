
import 'package:registration_staff/common/req_model.dart';
import 'package:registration_staff/config/api.dart';
import 'package:registration_staff/dataobj/summer_entity.dart';

class SummerRepo{

  var res;

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

  Future doGetOneSummer(id) async {
    try{
      var res = await ReqModel.get(API.GET_ONESUMMER, {'applicationId': id});
      return Future.value(SummerEntity.fromJson(res));
    }catch(error){
      print(error);
      return Future.error(error);
    }
  }

  Future delSummer(id) async {
    try{
      var res = await ReqModel.get(API.DEL_SUMMER, {'fileId': id});
      return Future.value(res);
    }catch(error){
      print(error);
      return Future.error(error);
    }
  }

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