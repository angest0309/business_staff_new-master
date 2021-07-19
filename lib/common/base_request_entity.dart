class BaseResponseEntity {
	dynamic data;
	int errorCode;
	String msg;

	BaseResponseEntity.fromJson(Map<String, dynamic> json) {
		data = json['data'] != null ? json['data'] : null;
		errorCode = json['error_code'];
		msg = json['msg'];
	}

	bool isSuccess() => errorCode == 0;
}

