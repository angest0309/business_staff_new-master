class ApplicationEntity {
  String destination;
  String startTime;
  String endTime;
  String applyTime;
  String applicant;

  ApplicationEntity(
      {this.destination,
        this.startTime,
        this.endTime,
        this.applyTime,
        this.applicant});

  ApplicationEntity.fromJson(Map<String, dynamic> json) {
    destination = json['destination'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    applyTime = json['applyTime'];
    applicant = json['applicant'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['destination'] = this.destination;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['applyTime'] = this.applyTime;
    data['applicant'] = this.applicant;
    return data;
  }

  static List<ApplicationEntity> fromJsonList(List list) {
    List<ApplicationEntity> res = List();
    list.forEach((element) {res.add(ApplicationEntity.fromJson(element));});
    return res;
  }
}