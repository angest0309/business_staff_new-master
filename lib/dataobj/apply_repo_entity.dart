import 'package:registration_staff/config/const.dart';

class ApplyRepoEntity {
  int id;
  String applicant;
  String position;
  String accompany;
  String reason;
  String fundsFrom;
  String startTime;
  String endTime;
  String departure;
  String destination;
  String transport;
  String transportBeyond;
  String advise;
  String approval;
  String applyTime;
  int status;
  int state;

  ApplyRepoEntity(
      {this.id,
        this.applicant,
        this.position,
        this.accompany,
        this.reason,
        this.fundsFrom,
        this.startTime,
        this.endTime,
        this.departure,
        this.destination,
        this.transport,
        this.transportBeyond,
        this.advise,
        this.approval,
        this.status,
        this.applyTime}){
    if(this.status == SUCCESS) //4
      this.state = 2;//通过 最终
    else if(this.status ==FAILED) //5
      this.state = 1; //失败
    else if(this.status == CANCEL) //1
      this.state = 3;//作废
    else
      this.state = 0;//审核中
    print("${id}:${state}");

  }

  ApplyRepoEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    applicant = json['applicant'];
    position = json['position'];
    accompany = json['accompany'];
    reason = json['reason'];
    fundsFrom = json['fundsFrom'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    departure = json['departure'];
    destination = json['destination'];
    transport = json['transport'];
    transportBeyond = json['transportBeyond'];
    advise = json['advise'];
    approval = json['approval'];
    status = json['status'];
    applyTime = json['applyTime'];
    if(this.status == SUCCESS) //4
      this.state = 2;//通过 最终
    else if(this.status ==FAILED) //5
      this.state = 1; //失败
    else if(this.status == CANCEL) //1
      this.state = 3;//作废
    else
      this.state = 0;//审核中
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['applicant'] = this.applicant;
    data['position'] = this.position;
    data['accompany'] = this.accompany;
    data['reason'] = this.reason;
    data['fundsFrom'] = this.fundsFrom;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['departure'] = this.departure;
    data['destination'] = this.destination;
    data['transport'] = this.transport;
    data['transportBeyond'] = this.transportBeyond;
    data['advise'] = this.advise;
    data['approval'] = this.approval;
    data['status'] = this.status;
    data['applyTime'] = this.applyTime;
    return data;
  }
  static List<ApplyRepoEntity> fromJsonList(List list) {
    List<ApplyRepoEntity> res = List();
    list.forEach((element) {res.add(ApplyRepoEntity.fromJson(element));});
    return res;
  }
}