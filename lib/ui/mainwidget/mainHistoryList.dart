import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_staff/config/config.dart';
import 'package:registration_staff/config/const.dart';
import 'package:registration_staff/dataobj/apply_repo_entity.dart';
import 'package:registration_staff/states/apply_state_model.dart';
import 'package:registration_staff/states/user_state_model.dart';
import 'package:registration_staff/widget/card_item.dart';
import 'package:registration_staff/widget/no_data.dart';
import 'package:registration_staff/widget/non_login_widget.dart';

import 'detail.dart';

/// 历史记录
class MainHistoryList extends StatefulWidget {
  @override
  _MainHistoryListState createState() {
    return _MainHistoryListState();
  }
}



class _MainHistoryListState extends State<MainHistoryList> {

  @override
  Widget build(BuildContext context) {
   /* return CardItem(
        title: MAIN_BUSINESS_HISTORY,
        child: Consumer<UserStateModel>(
        builder: (BuildContext context,UserStateModel value,Widget child){
         return  value.isLogin?
          ChangeNotifierProvider<ApplyStateModel>(
            create: (BuildContext context) =>
            ApplyStateModel()..init(value.user.id),
            child: Consumer<ApplyStateModel>(
              builder:
                  (BuildContext context, ApplyStateModel value, Widget child) {
                return CheckInfor(value.allList,value.hasAll,
                    value.waitList,value.hasWait,
                    value.acceptList,value.hasAccept,
                    value.cancelList,value.hasCancel,value.state);
              },
            ),
          ):NonLoginWidget();
        },
        ));*/
    return CardItem(
        title: MAIN_BUSINESS_HISTORY,
        child: Consumer<UserStateModel>(
          builder: (BuildContext context,UserStateModel uvalue,Widget child){
            return  uvalue.isLogin?
            Consumer<ApplyStateModel>(
              builder:
                  (BuildContext context, ApplyStateModel value, Widget child) {
                return CheckInfor(value.allList,value.hasAll,
                    value.waitList,value.hasWait,
                    value.acceptList,value.hasAccept,
                    value.cancelList,value.hasCancel,value.state);
              },
            ):NonLoginWidget();
          },
        ));
  }
}
class CheckInfor extends StatefulWidget{
  List<ApplyRepoEntity> allList = new List<ApplyRepoEntity>();
  List<ApplyRepoEntity> waitList= new List<ApplyRepoEntity>();
  List<ApplyRepoEntity> acceptList= new List<ApplyRepoEntity>();
  List<ApplyRepoEntity> cancelList= new List<ApplyRepoEntity>();

  bool hasAll;
  bool hasWait;
  bool hasAccept;
  bool hasCancel;
  bool state;
  CheckInfor(this.allList,this.hasAll,this.waitList,this.hasWait,
      this.acceptList,this.hasAccept,this.cancelList,this.hasCancel,this.state);
  @override
  State<StatefulWidget> createState() {
    return _CheckInforState();
  }
}
class _CheckInforState extends State<CheckInfor>{



  List<int> mList;
  List<ExpandStateBean> expandStateList;
  _CheckInforState(){
    mList = new List();
    expandStateList = new List();
    for(int i=0;i<4;i++){
      mList.add(i);
      expandStateList.add(ExpandStateBean(i, false));
    }

  }
  _setCurrentIndex(int index,isExpand){
    setState(() {
      //遍历可展开状态列表
      expandStateList.forEach((item){
        if(item.index==index){
          item.isOpen=!isExpand;
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {

    return ExpansionPanelList(
      expansionCallback: (index,bol){
        _setCurrentIndex(index, bol);
      },
      children: mList.map((index){
        //返回一个组成的ExpansionPanel
        return ExpansionPanel(
            headerBuilder: (context,isExpanded){
              return GestureDetector(
                child: title(index, index==0?(widget.hasAll?widget.allList.length:0):
                index==1?(widget.hasWait?widget.waitList.length:0):
                index==2?(widget.hasAccept?widget.acceptList.length:0):
                (widget.hasCancel?widget.cancelList.length:0)),
                onTap: (){
                  //调用内部方法
                  _setCurrentIndex(index, expandStateList[index].isOpen);
                },
              );
            },
            body: Container(
                child:widget.state? Two(index, index==0?widget.allList:index==1?widget.waitList:
                index==2?widget.acceptList:widget.cancelList):Container()
            ),
            isExpanded: expandStateList[index].isOpen
        );
      }).toList(),
    );

  }

}
//list中item状态自定义类
class ExpandStateBean{
  var isOpen;   //item是否打开
  var index;    //item中的索引
  ExpandStateBean(this.index,this.isOpen);
}

Widget title(int index,int num){
  return Padding(
    padding: EdgeInsets.all(5.0),
    child: Stack(
      children: [
        Container(
          child: ListTile(
            title: Text(index == 0?"全部":index == 1? "审核退回":index == 2?"审核通过":"作废申请",
              style: new TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700
              ),),
          ),
        ),
        index == 0?Container():Positioned(
            left: 80.0,
            top: 10.0,
            child: num>0?Container(
              padding: EdgeInsets.only(left: 1.0,right: 1.0,top: 2.0,bottom: 2.0),
              width: 16,
              height: 16,
              child: Center(
                  child: Text(num.toString(),
                    style: TextStyle(
                        fontSize: 10.0, color: Colors.red ),)
              ),
              decoration: BoxDecoration(
                border: new Border.all(color: Colors.red, width: 1.0), // 边色与边宽度
                color: Colors.white, // 底色
                //        borderRadius: new BorderRadius.circular((20.0)), // 圆角度
                borderRadius: new BorderRadius.circular((20.0)),
              ),
            ):Text("")
        )
      ],
    ),
  );
}


Widget applyListWidget(BuildContext context,int index,List applyList){
  if(applyList.length==0)
    return NonDataWidget();
  else{
    List<Widget> _list = new List();
    for(int i=0;i<applyList.length;i++){
      _list.add(Container(
        padding: EdgeInsets.only(left: 20.0,right: 10.0),
        child:applyOneWidge(context,index, applyList[i]) ,
      ));
    }
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true ,
      children:_list,
    );
  }
}
Widget applyOneWidge(BuildContext context,int index,ApplyRepoEntity applyRepoEntity){
  String start = applyRepoEntity.startTime.substring(0,10);
  List startsp = start.split("-");
  String end = applyRepoEntity.endTime.substring(0,10);
  List endsp = end.split("-");
  return InkWell(
    onTap: (){
      showDetaliDialog(context, applyRepoEntity);
    },
    highlightColor: Colors.green,
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(5.0),
          height: 80.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
             Column(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 index==0?Row(
                   children: [
                     Text('${applyRepoEntity.reason}   ',
                         style: TextStyle(fontSize:16.0,color: applyRepoEntity.state ==0?Colors.orange:
                         applyRepoEntity.state == 2?Colors.green:applyRepoEntity.state == 1?Colors.redAccent:Colors.blueAccent)),
                     Text(applyRepoEntity.state==0?"(待审核)":
                     applyRepoEntity.state ==2?"(已通过)":applyRepoEntity.state == 1?"(未通过)":"（已作废)",
                         style: TextStyle(color:  applyRepoEntity.state ==0?Colors.orange:
                         applyRepoEntity.state == 2?Colors.green:applyRepoEntity.state == 1?Colors.redAccent:Colors.blueAccent))
                   ],
                 ):Text('${applyRepoEntity.reason}',style: TextStyle(fontSize: 16.0),),
                 Text('${applyRepoEntity.departure} —— ${applyRepoEntity.destination}',style: TextStyle(color: Colors.grey,fontSize: 15.0),),
                 Text('${startsp[0]}年${startsp[1]}月${startsp[2]}日 —— ${endsp[0]}年${endsp[1]}月${endsp[2]}日',style: TextStyle(color: Colors.grey,fontSize: 15.0))
               ],
             ),
              Icon(Icons.keyboard_arrow_right,color: Colors.grey[300],)
            ],
          ),
        ),
        Container(height: 1.0,color:Colors.grey[100],)
      ],
    ),
  );
}
showDetaliDialog(BuildContext context,ApplyRepoEntity applyRepoEntity) async{
  UserStateModel userStateModel = Provider.of<UserStateModel>(context, listen: false);
  ApplyStateModel applyStateModel = Provider.of<ApplyStateModel>(context, listen: false);
  int userId = userStateModel.user.id;
  Navigator.push(context,
      MaterialPageRoute(builder: (context) => DetailPage(userId,applyStateModel,applyRepoEntity)));
}
//二级展开列表
class Two extends StatefulWidget {
  int order;
  List<ApplyRepoEntity> applyList;
  //近三天
  List<ApplyRepoEntity> before = new List<ApplyRepoEntity>();
  //其他
  List<ApplyRepoEntity> after = new List<ApplyRepoEntity>();
  Two(int order,List<ApplyRepoEntity> applyList){
    this.order = order;
    this.applyList = applyList;
    for(int i = applyList.length-1;i>=0;i--){
      String applyTime = this.applyList[i].applyTime.substring(0,10);
      List time = applyTime.split("-");
      if(isOver(time[0], time[1], time[2])){
        after.add(this.applyList[i]);
      }
      else
        before.add(this.applyList[i]);
    }
  }
  @override
  _TwoState createState() => _TwoState();
}

class _TwoState extends State<Two> {

  List<int> mList;
  List<ExpandStateBean> expandStateList;
  _TwoState(){
    mList = new List();
    expandStateList = new List();
    for(int i=0;i<2;i++){
      mList.add(i);
      expandStateList.add(ExpandStateBean(i, false));
    }
  }
  _setCurrentIndex(int index,isExpand){
    setState(() {
      //遍历可展开状态列表
      expandStateList.forEach((item){
        if(item.index==index){
          item.isOpen=!isExpand;
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: (index,bol){
        _setCurrentIndex(index, bol);
      },
      children: mList.map((index){
        //返回一个组成的ExpansionPanel
        return ExpansionPanel(
            headerBuilder: (context,isExpanded){
              return GestureDetector(
                child: Container(
                  padding: EdgeInsets.only(left: 20.0),
                  child: ListTile(
                    title: Text(index == 0?"近三天":"更早",style: TextStyle(
                        fontSize: 16,
                        fontWeight:FontWeight.w600
                    ),),
                  ),),
                onTap: (){
                  //调用内部方法
                  _setCurrentIndex(index, expandStateList[index].isOpen);
                },
              );
            },
            body: Container(
                child:applyListWidget(context,widget.order, index==0?widget.before:widget.after)
            ),
            isExpanded: expandStateList[index].isOpen
        );
      }).toList(),
    );
  }
}
