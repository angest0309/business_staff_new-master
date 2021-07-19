import 'package:flutter/material.dart';

const appBarColor = Color(0xff4169e2);

const Color fixedColor = Colors.blue;

const bgColor = Color(0xfff7f7f7);

const mainSpace = 10.0;

const mainLineWidth = 0.3;

const lineColor = Colors.grey;

const mainTextColor = Color.fromRGBO(115, 115, 115, 1.0);

const LOGO = 'assets/logo.jpeg';

const TextStyle TEXT_STYLE_LABEL = TextStyle(
  color: Color(0xff757575),
  fontSize: 18,
  fontWeight: FontWeight.w500
);

typedef DataCallback = void Function(String);


/// 收敛界面ui常量定义
/// ***************************
/// 标题
const String TITLE_NAME = "经信所出差审批系统\n出差填报";

/// 主界面
const String MAIN_PLAN = "月度工作计划";
const String MAIN_BUSINESS_LIST = "出差申请清单";
const String MAIN_BUSINESS_HISTORY = "历史记录";

//审核表状态
const WAIT = 0;
const CANCEL = 1;
const ONEPASS = 2;
const ONEREFUSE = 3;
const SUCCESS = 4;
const FAILED = 5;
/// 主要内容部分
const String STATUS_NOTHING = '健康';
const String STATUS_COUGH = '咳嗽';
const String STATUS_FEVER = '发热';
const String STATUS_COLD = '感冒';
const String STATUS_SUSPECT_ILL = '疑似新冠肺炎';
const String STATUS_CONFIRM_ILL = '确诊新冠肺炎';

/// 底部工具栏
const String BUTTON_BUSINESS_APPLY = "新建出差申请";
const String BUTTON_BUSINESS_SUMMER = "新建出差总结";
const String BUTTON_BUSINESS_GOPULL = "出差拼团";