
import 'package:flutter/foundation.dart';
import 'package:registration_staff/common/date.dart';
import 'package:registration_staff/data/apply_repo.dart';
import 'package:registration_staff/data/summer_repo.dart';
import 'package:registration_staff/data/user_repo.dart';
import 'package:registration_staff/dataobj/login_response_entity.dart';

enum LoginState {NON_LOGIN, LOGIN}
enum RecordState {RECORDED, NO_RECORD}

/// 用户状态管理类
class UserStateModel extends ChangeNotifier{
  UserRepo _repository = UserRepo();
  User _user;
  HealthRecord _healthRecord;

  //--临时存放
  List _hisList = [];//未审核列表（临时放在此管理类，后续优化代码需迁移）
  get hisList => _hisList;
  set hisList(value){
    this._hisList = value;
    notifyListeners();
  }
  //--临时存放

  List _summerList = [];
  get summerList => _summerList;
  set summerList(value){
    this._summerList = value;
    notifyListeners();
  }

  get user => _user;
  get isLogin => _user != null;
  set isLogin(value) {
    this.isLogin = value;
  }
  get isRecord => _healthRecord != null;
  HealthRecord get healthRecord => _healthRecord;

  void init() async{
    try {
      LoginEntity loginEntity = await _repository.initData();
      handleLoginResp(loginEntity);
    } catch (e) {
      // 未登录
      // empty handle
    }
  }
  
  Future login(id) async{
   try {
     // 拿到结果
     LoginEntity res = await _repository.doLogin(id);
     handleLoginResp(res);
     return Future.value(res);
   } catch (e) {
     return Future.error(e);
   }
  }

  // Future register(User user) async {
  //   try {
  //     // 注册完成后直接登录
  //     _user = await _repository.register(user);
  //
  //     notifyListeners();
  //     return Future.value();
  //   } catch (error) {
  //     return Future.error(error);
  //   }
  // }

  void handleLoginResp(LoginEntity loginEntity) {
    _user = loginEntity.user;
    //_healthRecord = loginEntity.record;
    print('user:' + user.toString());
    notifyListeners(); // 通知消费者
  }

  // Future confirmHealth(HealthRecord record) async{
  //   record.workerId = _user.workerId;
  //   record.closeCreateTime = DateTimeForMater.formatDateV(DateTime.now(), format: "yyyy-MM-dd");
  //   try {
  //     await  _repository.confirmHealth(record);
  //     // 提交成功
  //     _healthRecord = record;
  //     notifyListeners();
  //     return Future.value();
  //   } catch (error) {
  //     return Future.error(error);
  //   }
  // }
  
  Future confirmActivity(User user) async {
    try {
      await _repository.confirmActivity(user);
      _user = user;
      notifyListeners();
      return Future.value();
    } catch (error) {
      return Future.error(error);
    }
  }

  void logout(){
    _repository.logout();
    _user = null;
    notifyListeners();
  }

  getHisList(int id) {
    ApplyRepo().doGetHisList(id).then((value) {
      _hisList = value;
      notifyListeners();
      return value;
    }).catchError((error) {
      print("获取出差申请清单出错： " + error.toString());
    });
  }

  getSummerList(int id) {
    SummerRepo().doGetSummerList(id).then((value) {
      _summerList = value;
      notifyListeners();
      return value;
    }).catchError((error) {
      print("获取总结申请清单出错： " + error.toString());
    });
  }

}