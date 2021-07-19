

import 'package:registration_staff/dataobj/application_entity.dart';

import '../common/req_model.dart';
import '../config/api.dart';

class GetApplicationRepo{

  //领导端获取所有行程
  Future getApplication({String end,String start})async{
    try{
      var res = await ReqModel.get(API.GET_APPLICATION,{
        "endTime":end,
        "startTime":start
      });
      print(" getApplication success");
      return Future.value(ApplicationEntity.fromJsonList(res));
    }catch(error){
      print("getApplication error:"+error.toString());
      return Future.error(error);
    }
  }
}