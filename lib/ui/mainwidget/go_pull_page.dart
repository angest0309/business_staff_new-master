
import 'package:bot_toast/bot_toast.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:registration_staff/data/get_application_repo.dart';
import 'package:registration_staff/dataobj/application_entity.dart';
import 'package:registration_staff/widget/no_go_widget.dart';

import '../../common/check.dart';
import '../../common/date.dart';
import '../../widget/auto_resize_widget.dart';

class GoPullPage extends StatelessWidget {
  const GoPullPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoResizeWidget(child: MainPagea());
  }
}

class MainPagea extends StatefulWidget {
  const MainPagea({Key key}) : super(key: key);

  @override
  _MainPageaState createState() => _MainPageaState();
}

class _MainPageaState extends State<MainPagea> {
  ScrollController _scrollController = new ScrollController();
  List<ApplicationEntity> applicationList = [];

  DateTime nowTime = DateTime.now();
  //时间选择器
  //默认开始时间为一周前
  String startTime = getOldWeekDate();
  String endTime = formatDate(DateTime.now(),[yyyy, "-", mm, "-", dd]);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //初始化数据 获取最近一周行程信息
    GetApplicationRepo().getApplication(start: startTime,end: endTime).then((value) {
      setState(() {
        if(listNoEmpty(value)){
          applicationList = value;
        }
      });
    }).catchError((error){
      BotToast.showText(text: "获取行程失败！");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Container(
            color: Theme.of(context).primaryColor,
            height: 150.0,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: PreferredSize(
              child: AppBar(
                elevation: 0,
                centerTitle: true,
                title: Text('行程清单'),
                backgroundColor: Theme.of(context).primaryColor,
              ),
              preferredSize: Size.fromHeight(40.0),
            ),
            body: Card(
              margin: EdgeInsets.only(top: 30, left: 15.0, right: 15.0, bottom: 30.0),
              color: Colors.white,
              child:Column(
                children: [
                  Container(height:100.0,child: _getTime(),),
                  Expanded(child: _getMainContainer())
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  //时间选择器
  _getTime(){
    return Row(
      children: [
        Container(width: 8.0,),
        Icon(Icons.access_time,color: Colors.grey,),
        Expanded(
          flex: 4,
          child: Row(
            children: [
              Container(width: 5.0,),
              Container(
                height: 45.0,
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: (){
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        currentTime: getOldWeek(),
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
                                fontSize: 16)),
                        onConfirm: (date) {
                          setState(() {
                            startTime = date.toString().substring(
                                0, date.toString().length - 13);
                          });
                        },
                        locale: LocaleType.zh);
                  },
                  child: Text(startTime,style: TextStyle(fontSize: 16.0),),
                ),
              ),
              Container(height: 45,alignment:Alignment.center,child: Text('    ——    '),),
              Container(
                height: 45.0,
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: (){
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
                                fontSize: 16)),
                        onConfirm: (date) {
                          setState(() {
                            endTime = date.toString().substring(
                                0, date.toString().length - 13);
                          });
                        },
                        locale: LocaleType.zh);
                  },
                  child: Text(endTime,style: TextStyle(fontSize: 16.0),),
                ),
              ),
              //Container(width: 10.0,),
            ],
          ),
        ),
        Expanded(child: RaisedButton(
          color: Theme.of(context).primaryColor,
          onPressed: _handlePut,
          child: Text('查询',style:TextStyle(color: Colors.white),),
        ),flex: 1,),
        Container(width: 5.0,)
      ],
    );
  }
  _getMainContainer(){
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: applicationList.length != 0?ListView.builder(
          shrinkWrap: true,
          controller: _scrollController,
          itemCount: applicationList.length,
          itemBuilder: (context,index){
            return _detailInfo(applicationList[applicationList.length-index-1]);
          }
      ):NoGoWidget(),
    );

  }

  _detailInfo(ApplicationEntity one){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              child: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                radius: 6.0,
              ),
              alignment: Alignment.center,
              width: 30.0,
              margin: EdgeInsets.only(left: 8.0,right: 3.0),
            ),
            Text('${one.startTime}  ——',style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.w500),),
            Text('  ${one.endTime}',style: TextStyle(fontSize: 17.0,fontWeight: FontWeight.w500),),
          ],
        ),
        Row(
          children: [
            _getCircle(),
            Expanded(child: Container(
              alignment: Alignment.centerLeft,
              height: 120.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 5.0,),
                  _getLine(Icons.person, one.applicant),
                  _getLine(Icons.assistant_photo_sharp, one.destination),
                  _getTimeLine(one.applyTime)
                ],
              ),
            ))
          ],
        ),
      ],
    );
  }

  _getCircle(){
    return Container(
      width: 30.0,
      height: 100.0,
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 8.0,right: 3.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            backgroundColor: Colors.greenAccent,
            radius: 2,
          ),
          CircleAvatar(
            backgroundColor: Colors.greenAccent,
            radius: 2,
          ),
          CircleAvatar(
            backgroundColor: Colors.greenAccent,
            radius: 2,
          ),
          CircleAvatar(
            backgroundColor: Colors.greenAccent,
            radius: 2,
          ),
          CircleAvatar(
            backgroundColor: Colors.greenAccent,
            radius: 2,
          ),
        ],
      ),
    );
  }
  _getLine(IconData iconData,String info){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(iconData,color: Colors.grey,size: 15.0,),
        Expanded(child: Container(
          //alignment: Alignment.centerLeft,
          margin: EdgeInsets.only(
            left: 3.0,
            top: 1,
          ),
          padding: EdgeInsets.only(top: 0, bottom: 8),
          child:Text("$info ",style:TextStyle(fontSize: 15.0),),
        ))
      ],
    );
  }
  _getTimeLine(String info){
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(
        left: 0.0,
        top: 1,
      ),
      padding: EdgeInsets.only(top: 0, bottom: 8),
      child: Text('申请时间：$info'),
    );
  }

  _handlePut()async{
    await GetApplicationRepo().getApplication(start: startTime,end: endTime).then((value) {
      setState(() {
        if(listNoEmpty(value)){
          applicationList = value;
          BotToast.showText(text: "获取行程成功！");
        }else{
          applicationList = [];
          BotToast.showText(text: "获取行程成功！");
        }
      });
    }).catchError((error){
      BotToast.showText(text: "获取行程失败！");
    });
  }
}
