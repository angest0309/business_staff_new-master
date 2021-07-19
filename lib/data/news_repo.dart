import 'package:registration_staff/common/req_model.dart';
import 'package:registration_staff/config/api.dart';
import 'package:registration_staff/dataobj/news_entity.dart';


/// 获取新闻列表
class NewsRepo {
  Future getList() async {
    try {
      var res = await ReqModel.get(API.NEWS, null);

      return Future.value(NewsEntity.fromJsonList(res));
    } catch (err) {
      return Future.error(err);
    }
  }
}