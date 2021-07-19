class SelectEntity {
  int id;
  String name;

  SelectEntity({this.id, this.name});

  SelectEntity.fromJson(Map<String, dynamic> json) {
    id = json['instituteSchoolId'];
    name = json['instituteName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['instituteSchoolId'] = this.id;
    data['instituteName'] = this.name;
    return data;
  }

  static Map<String, dynamic> toMap(List<SelectEntity> list) {
    Map<String, String> res = Map();
    list.forEach((element) {res[element.name] = element.id.toString();});
    return res;
  }

  static List<SelectEntity> fromJsonList(List list) {
    List<SelectEntity> res = List();
    list.forEach((element) {res.add(SelectEntity.fromJson(element));});
    return res;
  }
}
