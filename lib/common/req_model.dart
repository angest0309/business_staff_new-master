import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:registration_staff/common/check.dart';
import 'package:registration_staff/config/api.dart';
import 'package:registration_staff/config/config.dart';
import 'package:registration_staff/common/base_request_entity.dart';

// 请求计数
var _id = 0;

/*
* 请求类型枚举
* */

enum RequestType { GET, POST }

class ReqModel {
  static Dio _client;

  /*
  * get请求
  * */
  static Future get(url, params) async {
    return _request(
      url: url,
      method: RequestType.GET,
      params: params,
    );
  }

  /*
  * post请求
  * */
  static Future post(url, params) async {
    return _request(
      url: url,
      method: RequestType.POST,
      params: params,
    );
  }


  /*
  * 请求方法
  * */
  static Future _request({
    String url,
    RequestType method,
    Map params,
  }) async {

    final httpUrl = '${API.reqUrl}$url';

    if (_client == null) {
      initDio();
    }

    final id = _id++;
    int statusCode;
    try {
      Response response;
      if (method == RequestType.GET) {
        ///组合GET请求的参数
        if (mapNoEmpty(params)) {
          response = await _client.get(
            url,
            queryParameters: params,
          );
        } else {
          response = await _client.get(
            url,
          );
        }
      } else {
        if (mapNoEmpty(params)) {
          //FormData formData = FormData.fromMap(params);
          response = await _client.post(
            url,
            data: params,
          );
        } else {
          response = await _client.post(
            url,
          );
        }
      }

      statusCode = response.statusCode;



      if (response != null) {
        print('HTTP_REQUEST_URL::[$id]::$httpUrl');
        if (mapNoEmpty(params)) print('HTTP_REQUEST_BODY::[$id]::${json.encode(params)}');
        print('HTTP_RESPONSE_BODY::[$id]::${json.encode(response.data)}');
        print('HTTP_RESPONSE_HEADER::[$id]::${response.headers}');
        BaseResponseEntity baseResponse = BaseResponseEntity.fromJson(response.data);
        if (baseResponse.isSuccess())
          return baseResponse.data;
        return _handError(statusCode: baseResponse.errorCode, msg: baseResponse.msg);
      }

      ///处理错误部分
      if (statusCode < 0) {
        return _handError(statusCode: statusCode);
      }
    } catch (e) {
      print("（0121测试）e：" + e.toString());
      print('url: $url;requestBody: ${params.toString()}');
      print('dio request error:' + e.toString());
      return _handError(statusCode: statusCode);
    }
  }

  ///处理异常
  static Future _handError({statusCode, msg}) {
    String errorMsg = msg ?? 'Network request error';

    print("HTTP_RESPONSE_ERROR::$errorMsg code:$statusCode");
    return Future.error(errorMsg);
  }

  static void initDio() {
    BaseOptions options = new BaseOptions();
    options.connectTimeout = connectTimeOut;
    options.receiveTimeout = receiveTimeOut;
    options.headers ['Content-Type'] = 'application/json';
    options.baseUrl = API.reqUrl;

    _client = new Dio(options);
  }
}