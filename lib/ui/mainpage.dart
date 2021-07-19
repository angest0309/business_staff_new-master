import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:registration_staff/config/config.dart';
import 'package:registration_staff/config/const.dart';
import 'package:registration_staff/data/apply_repo.dart';
import 'package:registration_staff/data/storage_manager.dart';
import 'package:registration_staff/data/summer_repo.dart';
import 'package:registration_staff/dataobj/apply_entity.dart';
import 'package:registration_staff/dataobj/login_response_entity.dart';
import 'package:registration_staff/dataobj/summer_entity.dart';
import 'package:registration_staff/main.dart';
import 'package:registration_staff/states/apply_state_model.dart';
import 'package:registration_staff/states/user_state_model.dart';
import 'package:registration_staff/ui/dialog/login_dialog.dart';
import 'package:registration_staff/ui/mainwidget/go_pull_page.dart';
import 'package:registration_staff/ui/mainwidget/mainSummerList.dart';
import 'package:registration_staff/widget/auto_resize_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';
import '../config/const.dart';
import 'dialog/apply_dialog.dart';
import 'dialog/summer_dialog.dart';
import 'mainwidget/mainBusinessList.dart';
import 'mainwidget/mainHistoryList.dart';
import 'mainwidget/mainWorkPlan.dart';
import 'mainwidget/staff.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> widgets = [];
  List hisList = []; //出差申请清单列表
  List summerList = [];//出差总结清单列表
  MainBusinessList mainBusinessList;//？
  String userName = "请登录";

  @override
  void initState() {
    super.initState();
    initData();//初始化数据
    // mainBusinessList = new MainBusinessList(hisList);
    // widgets.add(_buildTitle(context));
    // widgets.add(MainWorkPlan());
    // widgets.add(mainBusinessList);
    // widgets.add(MainHistoryList());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (BuildContext context,UserStateModel value,Widget child){
      return ChangeNotifierProvider<ApplyStateModel>(
        create:(BuildContext context) => ApplyStateModel()..init(value.isLogin==true?value.user.id:-1),
        child:  AutoResizeWidget(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Container(
                child: Builder(builder: (context) {
                  return Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: <Widget>[
                              //_buildTitle(context),
                              Container(height: 20),//均为组件
                              MainBusinessList(),//出差申请列表
                              MainHistoryList(),//历史记录列表
                              MainSummerList(),//出差总结列表
                            ]),
                      ),
                      Flexible(//大小不自动填充，类比expanded
                        flex: 0,
                        child: _buildButtonGroup(context),
                      )
                    ],
                  );
                }),
              ),
            ),
          ),
        ),

      );
    });
  }

  Row _buildTitle(BuildContext context) {//未使用
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Image.asset(
        //   LOGO,
        //   width: 85,
        //   height: 85,
        // ),
        Text(
          TITLE_NAME,
          //style: Theme.of(context).textTheme.headline,
          style: new TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
          softWrap: true,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  ApplyEntity applyEntity = new ApplyEntity();
  SummerEntity summerEntity = new SummerEntity();
  int id;

  _buildButtonGroup(BuildContext context) {//按钮栏
    return Container(
        width: double.infinity,
        height: 60.0,
        decoration: BoxDecoration(color: Theme.of(context).primaryColor),
        child: Consumer<UserStateModel>(builder:
            (BuildContext context, UserStateModel value, Widget child) {
          UserStateModel state =
              Provider.of<UserStateModel>(context, listen: false);
          return Row(
            children: [
              Expanded(flex: 1, child: Container()),
              Expanded(
                flex: 3,
                child: RaisedButton(//出差拼团按钮
                    child: Text(
                      BUTTON_BUSINESS_GOPULL,
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Color(0xFF087f23),
                    onPressed: value.isLogin ? () =>Navigator.push(
                        context, MaterialPageRoute(//出差拼团类似查找历史记录
                        builder: (context) => GoPullPage())) : null),
              ),
              Expanded(flex: 1, child: Container()),
              Expanded(
                flex: 3,
                child: RaisedButton(//新建出差申请按钮
                    child: Text(
                      BUTTON_BUSINESS_APPLY,
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Color(0xFF087f23),
                    onPressed: value.isLogin
                        ? () async {
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(//直接跳转页面到新建出差申请页面
                                        builder: (context) =>
                                            ApplyPage(applyEntity, state)))
                                .then((data) {
                              ApplyRepo()
                                  .doGetHisList(value.user.id)
                                  .then((data) {
                                setState(() {
                                  value.hisList = data;
                                });
                              }).catchError((error) {
                                print("获取出差申请清单出错： " + error.toString());
                              });
                            });
                          }
                        : null),
              ),
              Expanded(flex: 1, child: Container()),
              Expanded(
                flex: 3,
                child: RaisedButton(//登录按钮
                    child: Text(
                      value.isLogin ? '退出登录' : "登录",
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Color(0xFF087f23),
                    onPressed: value.isLogin//如果已经登录了，则变为退出登录点击按钮
                        ? () => showAlertDialog(state)//是否退出登录弹窗
                        : () {
                            showLoginDialog(state).then((data){//登录弹窗
                              ApplyRepo()//读取出差申请清单数据
                                  .doGetHisList(value.user.id)
                                  .then((data) {
                                setState(() {
                                  value.hisList = data;
                                });
                              }).catchError((error) {
                                print("获取出差申请清单出错： " + error.toString());
                              });
                              SummerRepo()//读取出差总结清单数据
                                  .doGetSummerList(value.user.id)
                                  .then((data) {
                                setState(() {
                                  value.summerList = data;
                                });
                              }).catchError((error) {
                                print("获取出差总结清单出错： " + error.toString());
                              });
                              StorageManager.sp.setString(SpKey.KET_NAME, value.user.name);
                              setState(() {
                                userName = value.user.name;
                              });
                            });
                          }),
              ),
              Expanded(flex: 1, child: Container()),
            ],
          );
        }));
  }

  //重新获取hisList
  //在initState函数中调用
  Future initData() async {
    hisList = [];
    SharedPreferences sp = await SharedPreferences.getInstance();
    String id0 = sp.getString(SpKey.KTY_ID_NUM);
    if(sp.getString(SpKey.KET_NAME) != null){
      this.userName = sp.getString(SpKey.KET_NAME);
    }
    setState(() {
      this.id = int.parse(id0);

    });
    ApplyRepo().doGetHisList(id).then((value) {//前往后台api，读取出差申请数据
      setState(() {
        hisList = value;
      });
    }).catchError((error) {
      print("获取出差申请清单出错： " + error.toString());
    });
    SummerRepo().doGetSummerList(id).then((value) {//前往后台api，读取出差总结数据
      setState(() {
        summerList = value;
      });
    }).catchError((error) {
      print("获取出差总结清单出错： " + error.toString());
    });
  }

  showApplyDialog(UserStateModel state, UserStateModel value) async {//未调用
    //pop后调用的方法
    Navigator.push(//点击后跳转到出差申请页面
        context,
        MaterialPageRoute(
            builder: (context) => ApplyPage(applyEntity, state))).then((data) {}
        );
  }

  showLoginDialog(UserStateModel state) async { //登录界面弹窗
    await showDialog(
        context: context,
        builder: (context) {
          return LoginDialog(state);
        });
    refreshPage();
  }

  handleLogout(UserStateModel state) async {
    await state.logout();
    setState(() {
      this.userName = "请登录";
    });

    refreshPage();
  }

  /// 刷新界面，避免界面被折叠
  refreshPage() {
    refreshWebPage();
  }

  //退出时弹出提示框
  void showAlertDialog(UserStateModel state) {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text(
              '退出登录',
              style: TextStyle(color: Colors.green, fontSize: 20),
            ),
            //可滑动
            content: new SingleChildScrollView(
                child: Text(
              "是否确定退出登录？",
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
                  handleLogout(state);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
