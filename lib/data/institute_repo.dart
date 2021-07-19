

import 'package:registration_staff/common/req_model.dart';
import 'package:registration_staff/config/api.dart';
import 'package:registration_staff/dataobj/institue_entity.dart';

class InstituteRepo {
  Future getList() async {
    try {
      var res = await ReqModel.get(API.INSTITUTE, null);
      return Future.value(InstituteEntity.fromJsonList(res));
    } catch (error) {
      print('InstituteRepo error: '+ error.toString());
      return Future.error(error);
    }
  }
}