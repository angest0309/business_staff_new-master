import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_staff/dataobj/login_response_entity.dart';
import 'package:registration_staff/states/user_state_model.dart';
import 'package:registration_staff/widget/card_item.dart';
import 'package:registration_staff/widget/non_login_widget.dart';

class Staff extends StatefulWidget {
  @override
  _StaffState createState() => _StaffState();
}

class _StaffState extends State<Staff> {
  @override
  Widget build(BuildContext context) {
    return CardItem(
      title: "职工信息",
      child: Consumer<UserStateModel>(
        builder: (BuildContext context, UserStateModel value, Widget child) {
          User user = value.user;
          return value.isLogin? Container(
            width: double.infinity,
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Text("所属机构：${user.workerBelongTo}", overflow: TextOverflow.ellipsis,
                //   style: TextStyle(fontSize: 16),),
                // Row(
                //   children: <Widget>[
                //     Expanded(
                //       flex: 2,
                //       child:Text("职工姓名：${user.workerName}",style: TextStyle(fontSize: 16),),
                //     ),
                //     Expanded(
                //       flex: 1,
                //       child: Text("年龄：${user.workerAge}",style: TextStyle(fontSize: 16),),
                //     ),
                //     Expanded(
                //       flex: 1,
                //       child: Text("性别：${user.wrapperSex}",style: TextStyle(fontSize: 16),),
                //     )
                //   ],
                // ),
                // Text("手机号码：${user.workerPhoneNum}",style: TextStyle(fontSize: 16),),
                // Text("身份证号：${user.workerIdNum}",style: TextStyle(fontSize: 16),)
              ],
            ),
          ): NonLoginWidget();
        },)
    );
  }
}
