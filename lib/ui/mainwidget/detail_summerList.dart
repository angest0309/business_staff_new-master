import 'package:auto_size_text/auto_size_text.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_staff/data/summer_repo.dart';
import 'package:registration_staff/dataobj/login_response_entity.dart';
import 'package:registration_staff/dataobj/summer_entity.dart';
import 'package:registration_staff/states/user_state_model.dart';
import 'package:registration_staff/ui/dialog/summer_dialog.dart';
import 'package:registration_staff/widget/auto_resize_widget.dart';

import '../../dataobj/summer_entity.dart';
import '../mainpage.dart';

class DetailSummerPage extends StatefulWidget {
  int userId;
  SummerEntity summerEntity;
  DetailSummerPage(this.userId, this.summerEntity);
  @override
  _DetailSummerPageState createState() => _DetailSummerPageState();
}

class _DetailSummerPageState extends State<DetailSummerPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserStateModel>(builder: (BuildContext context, UserStateModel value, Widget child)
    {
      UserStateModel state =
      Provider.of<UserStateModel>(context, listen: false);
      SummerEntity summerEntity = widget.summerEntity;
      int applicationId = summerEntity.applicationId;


      return WillPopScope(//返回拦截组件
        onWillPop: ()async {//返回方法（特殊情况可设为点击两次返回键才pop）
          print("点击返回键");
          Navigator.pop(context);
          return true;
        },
        child: AutoResizeWidget(
          child: Scaffold(
            body: SizedBox(
              child: Container(
                margin: EdgeInsets.only(top: 20.0),
                padding: EdgeInsets.all(10.0),
                color: Colors.white,
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("出差总结", style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 18.0,fontWeight: FontWeight.w700),),
                        IconButton(
                          icon: Icon(Icons.close),
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      ],
                    ),
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              unit(Icons.title, "标题", widget.summerEntity.title),
                              unit(Icons.person, "内容", ""),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                padding: EdgeInsets.only(left: 10, top: 10),
                                height: 200,
                                width: double.infinity,
                                child: Text(widget.summerEntity.text,
                                style: TextStyle(fontSize: 16),),
                                decoration: new BoxDecoration(
                                  color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    border: Border.all(color: Colors.grey),
                                    boxShadow: [
                                    BoxShadow(color: Colors.grey, offset: Offset(0.0, 2.0), blurRadius: 2.0, spreadRadius: 1.0)],
                                ),
                              ),
                              Divider(
                                height: 5,
                              ),
                              //unit(Icons.panorama_outlined, "相关图片", ""),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
                      child: ButtonBar(
                        children: [
                          RaisedButton(
                              elevation: 4,
                              child: Text('撤销',style: Theme.of(context).textTheme.button,),
                              color: Color(0xFF087f23),
                              onPressed: (){//是否修改弹窗
                                showCancelAlertDialog(summerEntity, state, applicationId);
                              }
                          ),
                          Container(
                            width: 10,
                          ),
                          RaisedButton(
                              elevation: 4,
                              child: Text('修改',style: Theme.of(context).textTheme.button,),
                              color: Color(0xFF087f23),
                              onPressed: (){//是否修改弹窗
                                showChangeAlertDialog(summerEntity, state, applicationId);
                              }
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },);
  }

  Widget unit(IconData iconData, String title, String info){
    return Container(
      width: double.infinity,
      height: 40.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(width: 20.0, child: Icon(iconData, color: Colors.grey, size: 25),),
              Container(width: 10.0,),
              Container(
                child: Text('${title}：${info}', style: TextStyle(fontSize: 20),),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //撤销弹窗
  void showCancelAlertDialog(SummerEntity summerEntity, UserStateModel state, int applicationId) {
    showDialog<Null>(
        context: context,
        barrierDismissible: true,//点击dialog外区域是否可以关闭dialog
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text('撤销总结',style: TextStyle(color: Colors.green,fontSize: 20),),
            //可滑动
            content: new SingleChildScrollView(
                child: Text("是否确定撤销总结？",style: TextStyle(fontSize: 15),)
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('取消',style: TextStyle(color: Colors.grey),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text('确定',style: TextStyle(color: Colors.green),),
                onPressed: () {
                  //撤销总结

                  //Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  //修改弹窗
  void showChangeAlertDialog(SummerEntity summerEntity, UserStateModel state, int applicationId) {
    showDialog<Null>(
        context: context,
        barrierDismissible: true,//点击dialog外区域是否可以关闭dialog
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text('修改总结',style: TextStyle(color: Colors.green,fontSize: 20),),
            //可滑动
            content: new SingleChildScrollView(
                child: Text("是否确定修改总结？",style: TextStyle(fontSize: 15),)
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('取消',style: TextStyle(color: Colors.grey),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text('确定',style: TextStyle(color: Colors.green),),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SummerPage(summerEntity, state, applicationId)
                      )
                  );
                  //Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}