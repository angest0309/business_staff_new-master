import 'package:auto_size_text/auto_size_text.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_staff/config/config.dart';
import 'package:registration_staff/data/abolish_repo.dart';
import 'package:registration_staff/dataobj/apply_repo_entity.dart';
import 'package:registration_staff/dataobj/login_response_entity.dart';
import 'package:registration_staff/dataobj/summer_entity.dart';
import 'package:registration_staff/main.dart';
import 'package:registration_staff/states/apply_state_model.dart';
import 'package:registration_staff/states/user_state_model.dart';
import 'package:registration_staff/ui/mainpage.dart';
import 'package:registration_staff/widget/auto_resize_widget.dart';
import 'package:registration_staff/ui/dialog/summer_dialog.dart';

class DetailBusinessPage extends StatefulWidget {
  int userId;
  //ApplyStateModel applyStateModel;
  ApplyRepoEntity applyRepoEntity;
  SummerEntity summerEntity;
  DetailBusinessPage(this.userId,this.applyRepoEntity);
  @override
  _DetailBusinessPageState createState() => _DetailBusinessPageState();
}

class _DetailBusinessPageState extends State<DetailBusinessPage> {
  DateTime dateTime;
  @override
  Widget build(BuildContext context) {
    return Consumer<UserStateModel>(builder: (BuildContext context,UserStateModel value,Widget child){
      UserStateModel state =
      Provider.of<UserStateModel>(context, listen: false);
      User user = value.user;
      String start = widget.applyRepoEntity.startTime.substring(0,10);
      List startsp = start.split("-");
      String end = widget.applyRepoEntity.endTime.substring(0,10);
      List endsp = end.split("-");
      int applicationId = widget.applyRepoEntity.id;
      int userId = widget.userId;
      String apply = widget.applyRepoEntity.applyTime.substring(0,10);
      List applysp = apply.split("-");

       return WillPopScope(
        onWillPop: ()async {
          print("点击返回键");
          Navigator.pop(context);
          return true;
        },
        child: AutoResizeWidget(
          child: Scaffold(
            //type:MaterialType.transparency,
            body: SizedBox(
              child: Container(
                margin: EdgeInsets.only(top: 20.0),
                padding: EdgeInsets.all(10.0),
                color: Colors.white,
                width: double.infinity,
                child:Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(widget.applyRepoEntity.state==0?'待审核':
                        widget.applyRepoEntity.state==2?"已通过":"未通过",
                          style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 18.0,fontWeight: FontWeight.w700),),
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
                            children: [
                              info(Icons.person, "申请人", widget.applyRepoEntity.applicant),
                              info(Icons.star, "出差原因", widget.applyRepoEntity.reason),
                              // info(Icons.person, "随行人员", widget.applyRepoEntity.accompany),
                              detailinfo(Icons.person, "随行人员", widget.applyRepoEntity.accompany),
                              info(Icons.attach_money, "经费来源", widget.applyRepoEntity.fundsFrom),
                              info(Icons.timer, "出发时间", "${startsp[0]}年${startsp[1]}月${startsp[2]}日"),
                              info(Icons.timer, "结束时间", "${endsp[0]}年${endsp[1]}月${endsp[2]}日"),
                              info(Icons.place, "出发地", widget.applyRepoEntity.departure),
                              info(Icons.place, "目的地", widget.applyRepoEntity.destination),
                              info(Icons.directions_bus, "交通方式", widget.applyRepoEntity.transport==null?"无":widget.applyRepoEntity.transport),
                              info(Icons.directions_bus, "超标原因", widget.applyRepoEntity.transportBeyond==null?"无":widget.applyRepoEntity.transportBeyond),
                              lastStatusWidget(widget.applyRepoEntity),
                              currentStatusWidget(widget.applyRepoEntity),
                              info(Icons.timer, "提交时间", "${applysp[0]}年${applysp[1]}月${applysp[2]}日"),
                            ],
                          )
                        ],
                      ),
                    ),
                    widget.applyRepoEntity.state==0?Container(
                      width: double.infinity,
                      decoration: BoxDecoration(color: Theme.of(context).primaryColor),
                      child: ButtonBar(
                        children: [
                          user.name == '正主任'?RaisedButton(
                            elevation: 4,
                            child: Text('通过',style: Theme.of(context).textTheme.button,),
                            color: Color(0xFF087f23),
                            onPressed: () => _handleCheck(applicationId, userId, 0),
                          ):null,
                          RaisedButton(
                            elevation: 4,
                            child: Text('撤销',style: Theme.of(context).textTheme.button,),
                            color: Color(0xFF087f23),
                            onPressed: (){
                              showAlertDialog(applicationId, userId);
                            },
                          ),

                        ],
                      ),
                    ):Container(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },);
  }

  void showAlertDialog(int ApplicationId, int userId) {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text('撤销申请',style: TextStyle(color: Colors.green,fontSize: 20),),
            //可滑动
            content: new SingleChildScrollView(
                child: Text("是否确定撤销申请？",style: TextStyle(fontSize: 15),)
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
                  Abolish().doAbolish(ApplicationId, userId).then((value) {
                    print(value.toString());
                    //v.init(widget.userId);
                    BotToast.showText(text:"撤销成功！");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainPage()));
                   // Navigator.of(context).pop("刷新页面");
                  }).catchError((error) {
                    print(error.toString());
                    BotToast.showText(text:"撤销失败，请检查网络！");
                  });
                },
              ),
            ],
          );
        });
  }

  void showAccompanyDialog(String info){
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text('随行人员',style: TextStyle(color: Colors.green,fontSize: 20),),
            //可滑动
            content: new SingleChildScrollView(
                child: Text(info,style: TextStyle(fontSize: 15),)
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text('确定',style: TextStyle(color: Colors.grey),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Widget detailinfo(IconData iconData,String title,String info){
    return InkWell(
        onTap:()=> showAccompanyDialog(info),
        child:Container(
          padding: EdgeInsets.all(10.0),
          height: title=="随行人员"?70.0:50.0,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  //Container(width: 10.0,),
                  Container(width: 20.0,child: Icon(iconData,color: Colors.grey,size: 20,),),
                  Container(width: 10.0,),
                  Container(
                    child: Text('${title}',style: TextStyle(fontSize: 18),),
                  ),
                ],
              ),
              Container(
                  width: 230.0,
                  alignment: Alignment.centerRight,
                  child:AutoSizeText("${info} ",style: TextStyle(color: Colors.grey,fontSize: 18),maxLines: 2,)
              )
            ],
          ),
        )
    );
  }

  Widget info(IconData iconData,String title,String info){
    return Container(
      padding: EdgeInsets.all(10.0),
      height: title=="随行人员"?70.0:50.0,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              //Container(width: 10.0,),
              Container(width: 20.0,child: Icon(iconData,color: Colors.grey,size: 20,),),
              Container(width: 10.0,),
              Container(
                child: Text('${title}',style: TextStyle(fontSize: 18),),
              ),
            ],
          ),
          Container(
              width: 230.0,
              alignment: Alignment.centerRight,
              child:AutoSizeText("${info} ",style: TextStyle(color: Colors.grey,fontSize: 18),maxLines: 2,)
          )
        ],
      ),
    );
  }
  Widget lastStatusWidget(ApplyRepoEntity applyEntity){
    return applyEntity.status!=1?Container(
      padding: EdgeInsets.all(10.0),
      height: 50.0,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              //Container(width: 10.0,),
              Container(width: 20.0,child: Icon(Icons.check,color: Colors.grey,size: 18,),),
              Container(width: 10.0,),
              Container(
                child: Text('上一状态',style: TextStyle(fontSize: 18),),
              ),
            ],
          ),
          applyEntity.status==0?Container(child: Row(
            children: [
              Text("等待",style: TextStyle(color: Colors.grey,fontSize: 18),),
              Text(" ${applyEntity.advise} ",style: TextStyle(color: Theme.of(context).primaryColor,fontSize: 18),),
              Text("审核 ",style: TextStyle(color: Colors.grey,fontSize: 18),),
            ],
          ),):applyEntity.status==2?Container(child: Row(
            children: [
              Text("已通过",style: TextStyle(color: Colors.grey,fontSize: 18),),
              Text(" ${applyEntity.advise} ",style: TextStyle(color: Colors.redAccent,fontSize: 18,),),
              Text("审核 ",style: TextStyle(color: Colors.grey,fontSize: 18),),
            ],
          ),):applyEntity.status==3?Container(child: Row(
            children: [
              Text(" ${applyEntity.advise} ",style: TextStyle(color:  Colors.redAccent,fontSize: 18),),
              Text("审核未通过 ",style: TextStyle(color: Colors.grey,fontSize: 18),),
            ],
          ),):applyEntity.status==4?Container(child: Row(
            children: [
              Text("已通过",style: TextStyle(color: Colors.grey,fontSize: 18),),
              Text(" ${applyEntity.approval} ",style: TextStyle(color:  Colors.redAccent,fontSize: 18),),
              Text("审核 ",style: TextStyle(color: Colors.grey,fontSize: 18),),
            ],
          ),):Container(child: Row(
            children: [
              Text(" ${applyEntity.advise} ",style: TextStyle(color:  Colors.redAccent,fontSize: 18),),
              Text("审核未通过 ",style: TextStyle(color: Colors.grey,fontSize: 18),),
            ],
          ),)
        ],
      ),
    ):Container();
  }
  Widget currentStatusWidget(ApplyRepoEntity applyEntity){
    return Container(
      padding: EdgeInsets.all(10.0),
      height: 50.0,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              //Container(width: 10.0,),
              Container(width: 20.0,child: Icon(Icons.check,color: Colors.grey,size: 18,),),
              Container(width: 10.0,),
              Container(
                child: Text('当前状态',style: TextStyle(fontSize: 18),),
              ),
            ],
          ),
          applyEntity.status==0?Container(child: Row(
            children: [
              Text("等待",style: TextStyle(color: Colors.grey,fontSize: 18),),
              Text(" ${applyEntity.advise} ",style: TextStyle(color: Colors.orange,fontSize: 18),),
              Text("审核 ",style: TextStyle(color: Colors.grey,fontSize: 18),),
            ],
          ),):applyEntity.status==2?Container(child: Row(
            children: [
              Text("等待",style: TextStyle(color: Colors.grey,fontSize: 18),),
              Text(" ${applyEntity.approval} ",style: TextStyle(color:  Colors.orange,fontSize: 18),),
              Text("审核 ",style: TextStyle(color: Colors.grey,fontSize: 18),),
            ],
          ),):applyEntity.status==3?Container(child: Row(
            children: [
              Text("等待",style: TextStyle(color: Colors.grey,fontSize: 18),),
              Text(" ${applyEntity.approval} ",style: TextStyle(color:  Colors.orange,fontSize: 18),),
              Text("审核 ",style: TextStyle(color: Colors.grey,fontSize: 18),),
            ],
          ),):applyEntity.status==4?Container(child: Row(
            children: [
              Text("审核成功 ",style: TextStyle(color: Colors.grey,fontSize: 18),),
            ],
          ),):applyEntity.status==1?Container(child: Row(
            children: [
              Text("已作废 ",style: TextStyle(color: Colors.grey,fontSize: 18),),
            ],
          )):Container(child: Row(
            children: [
              Text("审核失败 ",style: TextStyle(color: Colors.grey,fontSize: 18),),
            ],
          ),)
        ],
      ),
    );
  }

  _handleCheck(int applicationId, int userId, int type)async{
    Abolish().doAggree(applicationId, type, userId).then((value) {
      print(value.toString());
      BotToast.showText(text:"同意申请成功！");
      Navigator.pop(context);
      Navigator.of(context).pop("刷新页面");
    }).catchError((error) {
      print(error.toString());
      BotToast.showText(text:"同意申请失败，请检查网络！");
    });
  }
}

