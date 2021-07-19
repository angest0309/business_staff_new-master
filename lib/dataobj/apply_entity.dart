import 'package:registration_staff/dataobj/institue_entity.dart';

///填报申请数据结构
///200122创建
class ApplyEntity{

  ApplyEntity({
    this.startTime,
    this.endTime
});

  String accompany;
  String advise;//负责人，由userId自动获取负责人
  String applicant;
  String approval;//当前状态负责人，初始时默认和advise一样
  String departure = "广东省广州市天河区";
  String destination = "广东省广州市天河区";
  String endTime;
  String fundsFrom;
  int id;
  String position;//审批位置，默认为1
  String reason;
  String startTime;
  int status;
  String transport;
  String transportBeyond;

  //部门负责人
  List<InstituteEntity> depHeaderList = [];
  //部门领导
  List<InstituteEntity> leaderList = [];
  //经费来源
  List<InstituteEntity> fundsList = [];
  //出差事由
  List<InstituteEntity> reasonList = [];
  //超标原因
  List<InstituteEntity> transportBeyondList = [];
  //交通工具
  List<InstituteEntity> transportList = [];
  //随行人员
  List<InstituteEntity> userNameList = [];

  ApplyEntity.fromJson(Map<String, dynamic> json) {
    accompany	= json['accompany'];
    advise = json['advise'];
    applicant	= json['applicant'];
    approval	= json['approval'];
    departure	= json['departure'];
    destination	= json['destination'];
    endTime	= json['endTime'];
    fundsFrom = json['fundsFrom'];
    id	= json['id'];
    position	= json['position'];
    reason	= json['reason'];
    startTime	= json['startTime'];
    status	= json['status'];
    transport	= json['transport'];
    transportBeyond	= json['transportBeyond'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accompany'] = this.accompany;
    data['advise'] = this.advise;
    data['applicant'] = this.applicant;
    data['approval'] = this.approval;
    data['departure'] = this.departure;
    data['destination'] = this.destination;
    data['endTime'] = this.endTime;
    data['fundsFrom'] = this.fundsFrom;
    data['position'] = this.position;
    data['reason'] = this.reason;
    data['startTime'] = this.startTime;
    data['status'] = this.status;
    data['transport'] = this.transport;
    data['transportBeyond'] = this.transportBeyond;
    return data;
  }
}