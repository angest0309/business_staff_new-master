import 'package:registration_staff/config/const.dart';

///区别于健康系统，只需要user信息
///210122对user进行修改
class LoginEntity {
  //HealthRecord record;
  User user;

  LoginEntity({this.user});

  LoginEntity.fromJson(Map<String, dynamic> json) {
    // record =
    // json['record'] != null ? new HealthRecord.fromJson(json['record']) : null;
    user = new User.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // if (this.record != null) {
    //   data['record'] = this.record.toJson();
    // }
    // if (this.user != null) {
    //   data['user'] = this.user.toJson();
    // }
    data['user'] = this.user.toJson();
    return data;
  }
}

class HealthRecord {
  int selfSuspectIll;
  int selfConfirmIll;
  int closeNone;
  int closeFever;
  int closeConfirmIll;
  int selfCough;
  int selfFever;
  String closeCreateTime;
  int selfNone;
  int selfCold;
  int closeCough;
  int closeSuspectIll;
  int closeCold;
  int workerId;

  Map<String, bool> _personRecord;
  Map<String, bool> _otherRecord;

  HealthRecord(
      {this.selfSuspectIll, this.selfConfirmIll, this.closeNone, this.closeFever, this.closeConfirmIll, this.selfCough, this.selfFever, this.closeCreateTime, this.selfNone, this.selfCold, this.closeCough, this.closeSuspectIll, this.closeCold});

  HealthRecord.fromJson(Map<String, dynamic> json) {
    selfSuspectIll = json['selfSuspectIll'];
    closeCough = json['closeCough'];
    workerId = json['workerId'];
    closeCold = json['closeCold'];
    closeNone = json['closeNone'];
    closeConfirmIll = json['closeConfirmIll'];
    selfNone = json['selfNone'];
    closeCreateTime = json['closeCreateTime'];
    closeFever = json['closeFever'];
    selfFever = json['selfFever'];
    selfCold = json['selfCold'];
    selfCough = json['selfCough'];
    closeSuspectIll = json['closeSuspectIll'];
    selfConfirmIll = json['selfConfirmIll'];
  }

  HealthRecord.fromSelected(Map<String, bool> personMap,
      Map<String, bool> otherMap) {
    selfSuspectIll = toInt(personMap[STATUS_SUSPECT_ILL]);
    selfConfirmIll = toInt(personMap[STATUS_CONFIRM_ILL]);
    closeNone = toInt(otherMap[STATUS_NOTHING]);
    closeFever = toInt(otherMap[STATUS_FEVER]);
    closeConfirmIll = toInt(otherMap[STATUS_CONFIRM_ILL]);
    selfCough = toInt(personMap[STATUS_COUGH]);
    selfFever = toInt(personMap[STATUS_FEVER]);
    selfNone = toInt(personMap[STATUS_NOTHING]);
    selfCold = toInt(personMap[STATUS_COLD]);
    closeCough = toInt(otherMap[STATUS_COUGH]);
    closeSuspectIll = toInt(otherMap[STATUS_SUSPECT_ILL]);
    closeCold = toInt(otherMap[STATUS_COLD]);
  }


  get personRecord {
    if (_personRecord != null) return _personRecord;

    _personRecord = Map();
    _personRecord[STATUS_NOTHING] = toBool(selfNone);
    _personRecord[STATUS_SUSPECT_ILL] = toBool(selfSuspectIll);
    _personRecord[STATUS_CONFIRM_ILL] = toBool(selfConfirmIll);
    _personRecord[STATUS_COUGH] = toBool(selfCough);
    _personRecord[STATUS_FEVER] = toBool(selfFever);
    _personRecord[STATUS_COLD] = toBool(selfCold);
    return _personRecord;
  }

  get otherRecord {
    if (_otherRecord != null) return _otherRecord;

    _otherRecord = Map();
    _otherRecord[STATUS_NOTHING] = toBool(closeNone);
    _otherRecord[STATUS_SUSPECT_ILL] = toBool(closeSuspectIll);
    _otherRecord[STATUS_CONFIRM_ILL] = toBool(closeConfirmIll);
    _otherRecord[STATUS_COUGH] = toBool(closeCough);
    _otherRecord[STATUS_FEVER] = toBool(closeFever);
    _otherRecord[STATUS_COLD] = toBool(closeCold);
    return _otherRecord;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['selfSuspectIll'] = this.selfSuspectIll;
    data['closeCough'] = this.closeCough;
    data['workerId'] = this.workerId;
    data['closeCold'] = this.closeCold;
    data['closeNone'] = this.closeNone;
    data['closeConfirmIll'] = this.closeConfirmIll;
    data['selfNone'] = this.selfNone;
    data['closeCreateTime'] = this.closeCreateTime;
    data['closeFever'] = this.closeFever;
    data['selfFever'] = this.selfFever;
    data['selfCold'] = this.selfCold;
    data['selfCough'] = this.selfCough;
    data['closeSuspectIll'] = this.closeSuspectIll;
    data['selfConfirmIll'] = this.selfConfirmIll;
    return data;
  }

  bool toBool(int status) {
    return status == 1;
  }

  int toInt(bool status) {
    return status == true ? 1 : 0;
  }
}

class User {
  int id;
  int gender;
  String username;
  String name;
  String phoneNum;
  String wechatAccount;
  String wechatId;
  String regTime;
  String indentityId;
  String job;
  int firstPositionId;
  int secondPositionId;
  int firstDepId;
  int secondDepId;
  int roleId;
  String wokeCurAdd;
  int status;
  String firstDepName;
  String secondDepName;
  String firstPosition;
  String  secondPosition;

  
  // paresTrans() {
  //   if (strNoEmpty(workerTrans)) {
  //     List<String> items = workerTrans.split('，');
  //     if (items.length == 3)  {
  //       this.transBatch = items[1].trim();
  //       this.isDrive = items[0].trim() == '自驾'? 0:1;
  //       this.passHubei = items[2].trim() == '途经湖北'? 0:1;
  //     }
  //   }
  // }




  // set workerToaddTime(String value) {
  //   _workerToaddTime = value;
  // }
  //
  // String get workerToaddTime => _workerToaddTime ?? "";
  //
  // String get workerToaddLasttime => _workerToaddLasttime ?? "";


  // User({this.workerBelongTo, this.workerCurAdd, this.workerAge,
  //   this.workerPhoneNum, this.workerLastAdd,
  //   this.workerName, this.workerSex, this.workerIdNum, this.workerTrans, this.workInstituteId
  // });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gender = json['gender'];
    username = json['username'];
    name = json['name'];
    phoneNum = json['phoneNum'];
    wechatAccount = json['wechatAccount'];
    wechatId = json['wechatId'];
    regTime = json['regTime'];
    indentityId = json['indentityId'];
    job = json['job'];
    firstPositionId = json['firstPositionId'];
    secondPositionId = json['secondPositionId'];
    firstDepId = json['firstDepId'];
    secondDepId = json['secondDepId'];
    roleId = json['roleId'];
    wokeCurAdd = json['wokeCurAdd'];
    status = json['status'];
    firstDepName = json['firstDepName'];
    secondDepName = json['secondDepName'];
    firstPosition = json['firstPosition'];
    secondPosition = json['secondPosition'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['gender'] = this.gender;
    data['username'] = this.username;
    data['name'] = this.name;
    data['phoneNum'] = this.phoneNum;
    data['wechatAccount'] = this.wechatAccount;
    data['wechatId'] = this.wechatId;
    data['regTime'] = this.regTime;
    data['indentityId'] = this.indentityId;
    data['job'] = this.job;
    data['firstPositionId'] = this.firstPositionId;
    data['secondPositionId'] = this.secondPositionId;
    data['firstDepId'] = this.firstDepId;
    data['secondDepId'] = this.secondDepId;
    data['roleId'] = this.roleId;
    data['wokeCurAdd'] = this.wokeCurAdd;
    data['status'] = this.status;
    data['firstDepName'] = this.firstDepName;
    data['secondDepName'] = this.secondDepName;
    data['firstPosition'] = this.firstPosition;
    data['secondPosition'] = this.secondPosition;
    return data;
  }

  // get wrapperSex => workerSex == 1 ? '男' : '女';
  //
  User copyWith() {
    return User.fromJson(this.toJson());
  }
  //
  // set workerToaddLasttime(String value) {
  //   _workerToaddLasttime = value;
  // }
}
