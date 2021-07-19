import 'package:bot_toast/bot_toast.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:registration_staff/common/check.dart';
import 'package:registration_staff/config/const.dart';
import 'package:registration_staff/data/apply_repo.dart';
import 'package:registration_staff/dataobj/apply_entity.dart';
import 'package:registration_staff/states/user_state_model.dart';
import 'package:registration_staff/widget/area_spinner.dart';
import 'package:registration_staff/widget/area_spinner_page.dart';
import 'package:registration_staff/widget/auto_resize_widget.dart';
import 'package:smart_select/smart_select.dart';
import 'package:registration_staff/dataobj/institue_entity.dart';

/// 员工出差申请填写对话框

class ApplyPage extends StatelessWidget {
  ApplyEntity applyEntity;
  UserStateModel state;

  ApplyPage(this.applyEntity, this.state);

  @override
  Widget build(BuildContext context) {
    return AutoResizeWidget(
      child: ApplyWidget(applyEntity, state),
    );
  }
}

class ApplyWidget extends StatefulWidget {
  ApplyEntity applyEntity;
  UserStateModel state;
  ApplyWidget(this.applyEntity, this.state);

  @override
  State<StatefulWidget> createState() {
    return ApplyState(state);
  }
}

class ApplyState extends State<ApplyWidget> {
  UserStateModel state;
  ApplyState(this.state);

  TextEditingController _wayController = TextEditingController();
  TextEditingController _accompanyController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey();
  int sexGroupValue;

  ApplyEntity applyEntity = new ApplyEntity(
      startTime: formatDate(DateTime.now(), [yyyy, "-", mm, "-", dd]),
      endTime: formatDate(DateTime.now(), [yyyy, "-", mm, "-", dd]));

  //选择器选择的时间临时存放
  String startTimeTemp = formatDate(DateTime.now(), [yyyy, "-", mm, "-", dd]);
  String endTimeTemp = formatDate(DateTime.now(), [yyyy, "-", mm, "-", dd]);

  ///单选框
  bool reasonValue = true; //1：公开行程 0：不公开行程
  bool isAllName = false; //是否全选全所的工作人员

  ///选择器
  //部门负责人
  int depHeaderSelect = 1;
  //部门领导
  int leaderSelect = 1;
  //经费来源
  int fundsSelect = 1;
  //出差事由
  int reasonSelect = 1;
  //超标原因
  int transportBeyondSelect = 1;
  //交通工具
  List<int> transportSelect = [];
  //随行人员
  List<int> userNameSelect = [];

  TextStyle labelStyle = TextStyle(color: Colors.black, fontSize: 18);

  @override
  void initState() {
    super.initState();
    //初始化部门负责人列表
    ApplyRepo().doGetDepHeaderList(state.user.id).then((value) {
      setState(() {
        if (listNoEmpty(value)) {
          for (int i = 0; i < value.length; i++) {
            InstituteEntity ii = new InstituteEntity();
            ii.id = i + 1;
            ii.name = value[i];
            applyEntity.depHeaderList.add(ii);
          }
        }
      });
    }).catchError((error) {
      BotToast.showText(text: '获取部门负责人列表失败，请检查网络');
    });

    //初始化部门领导列表
    ApplyRepo().doGetLeaderList(state.user.id).then((value) {
      setState(() {
        if (listNoEmpty(value)) {
          for (int i = 0; i < value.length; i++) {
            InstituteEntity ii = new InstituteEntity();
            ii.id = i + 1;
            ii.name = value[i];
            applyEntity.leaderList.add(ii);
          }
        }
      });
    }).catchError((error) {
      print(error);
      BotToast.showText(text: '获取部门领导列表失败，请检查网络');
    });

    //初始化经费来源
    ApplyRepo().doGetFundsList().then((value) {
      setState(() {
        if (listNoEmpty(value)) {
          for (int i = 0; i < value.length; i++) {
            InstituteEntity ii = new InstituteEntity();
            ii.id = value[i]["id"];
            ii.name = value[i]["fundsFromName"];
            applyEntity.fundsList.add(ii);
          }
        }
      });
    }).catchError((error) {
      BotToast.showText(text: '获取经费来源列表失败，请检查网络');
    });

    //初始化出差事由
    ApplyRepo().doGetReasonList().then((value) {
      setState(() {
        if (listNoEmpty(value)) {
          for (int i = 0; i < value.length; i++) {
            InstituteEntity ii = new InstituteEntity();
            ii.id = value[i]["id"];
            ii.name = value[i]["reasonName"];
            applyEntity.reasonList.add(ii);
          }
        }
      });
    }).catchError((error) {
      print(error);
      BotToast.showText(text: '获取出差原因列表失败，请检查网络');
    });

    //初始化超标原因
    ApplyRepo().doGetTransportBeyondList().then((value) {
      setState(() {
        if (listNoEmpty(value)) {
          for (int i = 0; i < value.length; i++) {
            InstituteEntity ii = new InstituteEntity();
            ii.id = value[i]["id"];
            ii.name = value[i]["transportBeyond"];
            applyEntity.transportBeyondList.add(ii);
          }
        }
      });
    }).catchError((error) {
      print(error);
      BotToast.showText(text: '获取超标原因列表失败，请检查网络');
    });

    //初始化交通工具
    ApplyRepo().doGetTransportList().then((value) {
      setState(() {
        if (listNoEmpty(value)) {
          for (int i = 0; i < value.length; i++) {
            InstituteEntity ii = new InstituteEntity();
            ii.id = value[i]["id"];
            ii.name = value[i]["transportName"];
            applyEntity.transportList.add(ii);
          }
        }
      });
    }).catchError((error) {
      print(error);
      BotToast.showText(text: '获取交通工具列表失败，请检查网络');
    });

    //初始化用户姓名
    ApplyRepo().doGetAllUserName().then((value) {
      setState(() {
        if (listNoEmpty(value)) {
          for (int i = 0; i < value.length; i++) {
            InstituteEntity ii = new InstituteEntity();
            ii.id = i + 1;
            ii.name = value[i];
            applyEntity.userNameList.add(ii);
          }
        }
      });
    }).catchError((error) {
      print(error);
      BotToast.showText(text: '获取随行人员列表失败，请检查网络');
    });
  }

  //出发地选择器
  _buildAreaPicker(String label, String init, DataCallback callback) {
    return AreaSpinner(
      location: init,
      callback: callback,
      label: label,
    );
  }

  //目的地选择器
  _buildAreaPagePicker(DataCallback callback) {//未使用
    return AreaSpinnerPage(
      callback: callback,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: SizedBox(
          child: Container(
            padding: EdgeInsets.all(10.0),
            color: Colors.white,
            width: double.infinity,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('   ' + BUTTON_BUSINESS_APPLY,
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 20,
                            )),
                        IconButton(
                          icon: Icon(Icons.close),
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          /// 选择器 -- 出发地
                          _buildAreaPicker('出发地  ', "广东省广州市天河区", (res) {
                            print('select:' + res);
                            applyEntity.departure = res;
                          }),

                          Divider(//分割线
                            color: Colors.black,
                            height: 4,
                          ),

                          /// 选择器 -- 目的地
                          // _buildAreaPagePicker(  (res) {
                          //   print('select:' + res);
                          //   applyEntity.destination = res;
                          // }),
                          _buildAreaPicker('目的地  ', "广东省广州市天河区", (res) {
                            print('select:' + res);
                            applyEntity.destination = res;
                          }),

                          TextFormField(
                            controller: _wayController,
                            decoration: InputDecoration(
                                labelText: '途经地',
                                hintText: '请输入出差的途径地',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                                prefixIcon: Container(
                                  padding: EdgeInsets.all(17.0),
                                  alignment: Alignment.centerLeft,
                                  child: Icon(Icons.location_on),
                                  width: 70,
                                  height: 50,
                                )),
                          ),

                          ///时间选择器 -- 开始时间
                          Container(
                            height: 55.0,
                            width: double.infinity,
                            padding: EdgeInsets.all(12.0),
                            child: InkWell(
                              onTap: () {
                                DatePicker.showDatePicker(context,
                                    showTitleActions: true,
                                    currentTime: DateTime.now(),
                                    minTime: DateTime(1900),
                                    maxTime: DateTime(2100),
                                    theme: DatePickerTheme(
                                        headerColor: Colors.green,
                                        backgroundColor: Colors.white,
                                        itemStyle: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                        doneStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16)), onConfirm: (date) {
                                  print(date.toString().substring(
                                      0, date.toString().length - 13));
                                  setState(() {
                                    startTimeTemp = date.toString().substring(
                                        0, date.toString().length - 13);
                                  });
                                }, locale: LocaleType.zh);
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 50,
                                    width: 5,
                                  ),
                                  Icon(Icons.timer, color: Colors.grey),
                                  SizedBox(width: 30.0),
                                  Text(
                                    "开始时间",
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                                  SizedBox(width: 60.0),
                                  Text(startTimeTemp),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                            height: 4,
                          ),

                          ///时间选择器 -- 结束时间
                          Container(
                            height: 55.0,
                            width: double.infinity,
                            padding: EdgeInsets.all(12.0),
                            child: InkWell(
                                onTap: () {
                                  DatePicker.showDatePicker(context,
                                      showTitleActions: true,
                                      currentTime: DateTime.now(),
                                      minTime: DateTime(1900),
                                      maxTime: DateTime(2100),
                                      theme: DatePickerTheme(
                                          headerColor: Colors.green,
                                          backgroundColor: Colors.white,
                                          itemStyle: TextStyle(
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                          doneStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16)), onChanged: (date) {
                                        print('$date ' +
                                            date.timeZoneOffset.inHours.toString());
                                      }, onConfirm: (date) {
                                        setState(() {
                                          endTimeTemp = date.toString().substring(
                                              0, date.toString().length - 13);
                                        });
                                      }, locale: LocaleType.zh);
                                },
                                child:Row(
                                  children: [
                                    SizedBox(
                                      height: 50,
                                      width: 5,
                                    ),
                                    Icon(Icons.timer, color: Colors.grey),
                                    SizedBox(width: 30.0),
                                    Text(
                                      "结束时间",
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                    SizedBox(width: 60.0),
                                    Text(endTimeTemp),
                                  ],
                                ),
                            ),
                          ),
                          Divider(
                            color: Colors.black,
                            height: 4,
                          ),

                          /// 选择器 -- 随行人员
                          SmartSelect<int>.multiple(
                            value: userNameSelect,
                            placeholder: "点击选择本所人员",
                            options: SmartSelectOption.listFrom<int,
                                InstituteEntity>(
                              source: applyEntity.userNameList,
                              value: (index, item) => item.id,
                              title: (index, item) => item.name,
                            ),
                            leading: Icon(Icons.person),
                            onChange: (v) {
                              setState(() {
                                userNameSelect = v;
                              });
                            },
                            modalType: SmartSelectModalType.bottomSheet,
                            title: '随行本所人员',
                            trailing: Row(
                              children: [
                                Checkbox(
                                  value: this.isAllName,
                                  activeColor: Colors.green,
                                  onChanged: (bool val) {
                                    this.setState(() {
                                      this.isAllName = !this.isAllName;
                                    });
                                    if (isAllName) {
                                      setState(() {
                                        userNameSelect = [];
                                        for (int i = 1;
                                            i <=
                                                applyEntity.userNameList.length;
                                            i++) {
                                          userNameSelect.add(i);
                                        }
                                      });
                                    } else {
                                      setState(() {
                                        userNameSelect = [];
                                      });
                                    }
                                  },
                                ),
                                Text(
                                  "全选",
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            ),
                          ),

                          // 输入框 -- 非本所随行人员
                          TextFormField(
                            controller: _accompanyController,
                            decoration: InputDecoration(
                                labelText: '随行非本所人员',
                                hintText: '请输入非本所的随行人员，多个人员请用“，”隔开',
                                labelStyle: labelStyle,
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                                prefixIcon:Container(
                                  padding: EdgeInsets.all(17.0),
                                  alignment: Alignment.centerLeft,
                                  child: Icon(Icons.person),
                                  width: 70,
                                  height: 50,
                                )),
                          ),

                          /// 选择器 -- 部门负责人
                          SmartSelect<int>.single(
                            value: depHeaderSelect,
                            options: SmartSelectOption.listFrom<int,
                                InstituteEntity>(
                              source: applyEntity.depHeaderList,
                              value: (index, item) => item.id,
                              title: (index, item) => item.name,
                            ),
                            leading: Icon(Icons.person),
                            onChange: (v) {
                              setState(() {
                                depHeaderSelect = v;
                              });
                            },
                            modalType: SmartSelectModalType.bottomSheet,
                            title: '呈报部门(课题组)',
                          ),

                          Divider(
                            color: Colors.black,
                            height: 4,
                          ),

                          /// 选择器 -- 部门领导
                          SmartSelect<int>.single(
                            value: leaderSelect,
                            options: SmartSelectOption.listFrom<int,
                                InstituteEntity>(
                              source: applyEntity.leaderList,
                              value: (index, item) => item.id,
                              title: (index, item) => item.name,
                            ),
                            leading: Icon(Icons.person),
                            onChange: (v) {
                              setState(() {
                                leaderSelect = v;
                              });
                            },
                            modalType: SmartSelectModalType.bottomSheet,
                            title: '呈报所领导',
                          ),
                          Divider(
                            color: Colors.black,
                            height: 4,
                          ),

                          /// 选择器 -- 经费来源
                          SmartSelect<int>.single(
                            value: fundsSelect,
                            options: SmartSelectOption.listFrom<int,
                                InstituteEntity>(
                              source: applyEntity.fundsList,
                              value: (index, item) => item.id,
                              title: (index, item) => item.name,
                            ),
                            leading: Icon(Icons.monetization_on),
                            onChange: (v) {
                              setState(() {
                                fundsSelect = v;
                              });
                            },
                            modalType: SmartSelectModalType.bottomSheet,
                            title: '经费来源',
                          ),
                          Divider(
                            color: Colors.black,
                            height: 4,
                          ),

                          /// 选择器 -- 出差事由
                          SmartSelect<int>.single(
                            value: reasonSelect,
                            options: SmartSelectOption.listFrom<int,
                                InstituteEntity>(
                              source: applyEntity.reasonList,
                              value: (index, item) => item.id,
                              title: (index, item) => item.name,
                            ),
                            leading: Icon(Icons.list),
                            onChange: (v) {
                              setState(() {
                                reasonSelect = v;
                              });
                            },
                            modalType: SmartSelectModalType.bottomSheet,
                            title: '出差事由',
                          ),
                          Row(
                            children: [
                              Expanded(flex: 16, child: Container()),
                              Expanded(
                                  flex: 9,
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: this.reasonValue,
                                        activeColor: Colors.green,
                                        onChanged: (bool val) {
                                          this.setState(() {
                                            this.reasonValue =
                                                !this.reasonValue;
                                          });
                                        },
                                      ),
                                      Text(
                                        "公开行程",
                                        style: TextStyle(fontSize: 16),
                                      )
                                    ],
                                  )),
                            ],
                          ),
                          Divider(
                            color: Colors.black,
                            height: 4,
                          ),

                          /// 选择器 -- 超标原因
                          SmartSelect<int>.single(
                            value: transportBeyondSelect,
                            options: SmartSelectOption.listFrom<int,
                                InstituteEntity>(
                              source: applyEntity.transportBeyondList,
                              value: (index, item) => item.id,
                              title: (index, item) => item.name,
                            ),
                            leading: Icon(Icons.list),
                            onChange: (v) {
                              setState(() {
                                transportBeyondSelect = v;
                              });
                            },
                            modalType: SmartSelectModalType.bottomSheet,
                            title: '超标原因',
                          ),
                          Divider(
                            color: Colors.black,
                            height: 4,
                          ),

                          /// 选择器 -- 交通工具
                          SmartSelect<int>.multiple(
                            value: transportSelect,
                            placeholder: "点击选择交通工具",
                            options: SmartSelectOption.listFrom<int,
                                InstituteEntity>(
                              source: applyEntity.transportList,
                              value: (index, item) => item.id,
                              title: (index, item) => item.name,
                            ),
                            leading: Icon(Icons.directions_car),
                            onChange: (v) {
                              setState(() {
                                transportSelect = v;
                              });
                            },
                            modalType: SmartSelectModalType.bottomSheet,
                            title: '交通工具',
                          ),

                          Divider(
                            color: Colors.black,
                            height: 4,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          child: Text(
                            "取消",
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Color(0xFF087f23),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(width: 80.0),
                        Builder(
                          builder: (BuildContext context) {
                            return RaisedButton(
                              child: Text("提交",
                                  style: TextStyle(color: Colors.white)),
                              color: Color(0xFF087f23),
                              onPressed: () => showAlertDialog(),
                            );
                          },
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }

  //确定提交申请时获取选择器等的值，并将值post到服务器
  _handleApply() async {
    String accompanyTemp = "";
    if (userNameSelect.length > 0) {
      for (int i in userNameSelect) {
        accompanyTemp =
            accompanyTemp + "，" + applyEntity.userNameList[i - 1].name;
      }
      if (_accompanyController.text != "") {
        applyEntity.accompany =
            accompanyTemp.substring(1, accompanyTemp.length) +
                "，" +
                _accompanyController.text;
      } else {
        applyEntity.accompany =
            accompanyTemp.substring(1, accompanyTemp.length);
      }
    } else {
      if (_accompanyController.text != "") {
        applyEntity.accompany = _accompanyController.text;
      } else {
        applyEntity.accompany = "无";
      }
    }

    if (transportSelect.length == 0) {
      applyEntity.transport = "汽车（含单位车）";
    } else {
      applyEntity.transport = "";
      for (int i in transportSelect) {
        applyEntity.transport =
            applyEntity.transport + "，" + applyEntity.transportList[i - 1].name;
      }
      applyEntity.transport =
          applyEntity.transport.substring(1, applyEntity.transport.length);
    }

    applyEntity.advise = applyEntity.depHeaderList[depHeaderSelect - 1].name;
    applyEntity.approval = applyEntity.leaderList[leaderSelect - 1].name;
    applyEntity.fundsFrom = applyEntity.fundsList[fundsSelect - 1].name;
    applyEntity.advise = applyEntity.depHeaderList[depHeaderSelect - 1].name;
    applyEntity.reason = applyEntity.reasonList[reasonSelect - 1].name;
    applyEntity.transportBeyond =
        applyEntity.transportBeyondList[transportBeyondSelect - 1].name;
    //applyEntity.transport = applyEntity.transportList[transportSelect - 1].name;
    applyEntity.id = state.user.id;
    applyEntity.status = 0;
    applyEntity.applicant = state.user.name;
    applyEntity.position = state.user.job;

    //出差目的地
    if (_wayController.text != "") {
      applyEntity.destination += "，" + _wayController.text;
    }
    // print(_wayController.text);

    //日期格式转化
    applyEntity.startTime = startTimeTemp + "T00:00:00.234Z";
    applyEntity.endTime = endTimeTemp + "T00:00:00.234Z";

    ApplyRepo().doApply(applyEntity).then((value) {
      BotToast.showText(text: '提交申请成功！');
      Navigator.of(context).pop();
      Navigator.of(context).pop("刷新页面");
    }).catchError((error) {
      BotToast.showText(text: error.toString());
    });
  }

  _apply() async {
    await _handleApply();
  }

  //提交申请时弹出提示框
  void showAlertDialog() {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text(
              '提交申请',
              style: TextStyle(color: Colors.green, fontSize: 20),
            ),
            //可滑动
            content: new SingleChildScrollView(
                child: Text(
              "是否确定提交申请？",
              style: TextStyle(fontSize: 15),
            )),
            actions: <Widget>[
              new FlatButton(
                child: new Text(
                  '取消',
                  style: TextStyle(color: Colors.grey),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text(
                  '确定',
                  style: TextStyle(color: Colors.green),
                ),
                onPressed: () {
                  _apply();
                },
              ),
            ],
          );
        });
  }
}
