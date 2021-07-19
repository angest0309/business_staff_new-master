import 'package:registration_staff/common/req_model.dart';
import 'package:registration_staff/config/api.dart';

class RxportPDF{
  //导出PDF
  Future doExport(int applicantId) async {
    try {
      var res = await ReqModel.get(API.PDF, {'applicantId':applicantId});
      print("导出操作测试 : " + res.toString());
      return Future.value(res);
    } catch (error) {
      print("导出失败了      +" + error.toString());
      return Future.error(error);
    }
  }

}