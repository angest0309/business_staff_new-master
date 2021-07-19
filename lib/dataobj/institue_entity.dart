class InstituteEntity {
	int id;
	String name;

	InstituteEntity({this.id, this.name});

	InstituteEntity.fromJson(Map<String, dynamic> json) {
		id = json['instituteSchoolId'];
		name = json['instituteName'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['instituteSchoolId'] = this.id;
		data['instituteName'] = this.name;
		return data;
	}

	static Map<String, dynamic> toMap(List<InstituteEntity> list) {
		Map<String, String> res = Map();
		list.forEach((element) {res[element.name] = element.id.toString();});
		return res;
	}

  static List<InstituteEntity> fromJsonList(List list) {
		List<InstituteEntity> res = List();
		list.forEach((element) {res.add(InstituteEntity.fromJson(element));});
		return res;
	}
}
