import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_staff/config/const.dart';
import 'package:registration_staff/data/apply_repo.dart';
import 'package:registration_staff/data/storage_manager.dart';
import 'package:registration_staff/data/summer_repo.dart';
import 'package:registration_staff/dataobj/apply_entity.dart';
import 'package:registration_staff/dataobj/apply_repo_entity.dart';
import 'package:registration_staff/dataobj/summer_entity.dart';
import 'package:registration_staff/states/user_state_model.dart';
import 'package:registration_staff/ui/mainwidget/detail_businessList.dart';
import 'package:registration_staff/widget/card_item.dart';
import 'package:registration_staff/widget/non_login_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'detail_summerList.dart';

/// 出差申请清单
class MainSummerList extends StatefulWidget {
  @override
  _MainSummerListState createState() => _MainSummerListState();
}

class _MainSummerListState extends State<MainSummerList> {
  List hisList = []; //出差总结清单列表
  int id; //UserId
  SummerEntity summerEntity = new SummerEntity(); //总结清单数据结构
  List summerEntityList = []; //总结清单列表

  @override
  void initState() {
    super.initState();
    initData();
  }

  //获取总结清单列表
  Future initData() async {
    hisList = [];
    SharedPreferences sp = await SharedPreferences.getInstance();
    String id0 = sp.getString(SpKey.KTY_ID_NUM);
    setState(() {
      this.id = int.parse(id0);
    });

    //总结清单接口
    SummerRepo().doGetSummerList(id).then((value) {
      setState(() {
        hisList = value;
      });
    }).catchError((error) {
      print("获取总结申请清单出错： " + error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserStateModel>(
        builder: (BuildContext context, UserStateModel value, Widget child) {
          Widget buildWidget() {
            if (!value.summerList.isEmpty) {
              this.hisList = value.summerList;
            } else {
              //测试 print("空");
            }
            List<Widget> tiles = []; //先建一个数组用于存放循环生成的widget
            Widget content; //单独一个widget组件，用于返回需要生成的内容widget
            for (var item in value.summerList.isEmpty ? hisList : value.summerList) {
              tiles.add(new FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailSummerPage(
                                id, SummerEntity.fromJson(item)))).then((data) {
                      initData(); //pop后重新获取数据更新hisList
                      value.hisList = hisList;
                    });
                  },
                  child: Column(
                    children: [
                      Divider(
                        color: Colors.grey,
                        height: 2,
                      ),
                      ListTile(
                          title: Column(
                            children: [
                              Text(
                                "标题：" + item["title"].toString(),
                                style: TextStyle(fontSize: 13),
                              ),
                              Text(
                                "文本：" + item["text"].toString(),
                                style: TextStyle(fontSize: 13),
                              )
                            ],
                          ),
                          trailing: Icon(Icons.chevron_right)
                      ),
                      Divider(
                        color: Colors.grey,
                        height: 2,
                      ),
                      SizedBox(
                        height: 5,
                      )
                    ],
                  )));
            }
            content = new Column(children: tiles);
            return content;
          }

          Widget listWidget = buildWidget();
          return CardItem(
              title: value.user == null? "出差总结": value.user.name + "的出差总结",
              child: Consumer<UserStateModel>(
                builder:
                    (BuildContext context, UserStateModel value, Widget child) {
                  return Container(
                      padding: EdgeInsets.all(10.0),
                      width: double.infinity,
                      child: value.isLogin ? listWidget : NonLoginWidget());
                },
              ));
        });
  }

}
