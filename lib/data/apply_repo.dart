import 'package:registration_staff/common/req_model.dart';
import 'package:registration_staff/config/api.dart';
import 'package:registration_staff/dataobj/apply_entity.dart';

class ApplyRepo{

  Future doApply(ApplyEntity applyEntity) async {
    try {
      var res = await ReqModel.post(API.APPLY, applyEntity.toJson());
      //print("（0123测试）applyPost() : " + res.toString());
      return Future.value(res);
    } catch (error) {
      return Future.error(error);
    }
  }

  Future doGetDepHeaderList(id) async {
    try{
      List<dynamic> res = await ReqModel.get(API.GET_DEPHEADER_LIST, {'userId':id});
      return Future.value(res);//res为List
    }catch(error){
      print(error);
      return Future.error(error);
    }
  }

  Future doGetFundsList() async {
    try{
      List<dynamic> res = await ReqModel.get(API.GET_FUNDSLIST, null);
      return Future.value(res);
    }catch(error){
      return Future.error(error);
    }
  }

  Future doGetLeaderList(id) async {
    try{
      List<dynamic> res = await ReqModel.get(API.GET_LEADERLIST, {'userId':id});
      return Future.value(res);
    }catch(error){
      return Future.error(error);
    }
  }

  //获取所有出差原因
  Future doGetReasonList() async {
    try{
      List<dynamic> res = await ReqModel.get(API.GET_REASONLIST, null);
      return Future.value(res);
    }catch(error){
      return Future.error(error);
    }
  }

  //获取所有超标原因
  Future doGetTransportBeyondList() async {
    try{
      List<dynamic> res = await ReqModel.get(API.GET_TRANSPORTBEYONDLIST, null);
      return Future.value(res);
    }catch(error){
      return Future.error(error);
    }
  }

  //获取所有交通方式
  Future doGetTransportList() async {
    try{
      List<dynamic> res = await ReqModel.get(API.GET_TRANSPORTLIST, null);
      return Future.value(res);
    }catch(error){
      return Future.error(error);
    }
  }

  //获取所有未审批列表
  Future doGetHisList(int id) async{
    try{
      List<dynamic> res = await ReqModel.get(API.GET_HISLIST, {'type': 1,'userId': id});
      return Future.value(res);
    }catch(error){
      return Future.error(error);
    }
  }

  //获取所有用户姓名
  Future doGetAllUserName() async{
    try{
      List<dynamic> res = await ReqModel.get(API.All_USER_NAME, null);
      return Future.value(res);
    }catch(error){
      return Future.error(error);
    }
  }
}