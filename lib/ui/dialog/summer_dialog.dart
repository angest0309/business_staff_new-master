import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:registration_staff/config/const.dart';
import 'package:registration_staff/data/summer_repo.dart';
import 'package:registration_staff/dataobj/file_entity.dart';
import 'package:registration_staff/dataobj/summer_entity.dart';
import 'package:registration_staff/states/user_state_model.dart';
import 'package:registration_staff/widget/area_spinner.dart';
import 'package:registration_staff/widget/auto_resize_widget.dart';

import '../mainpage.dart';

// ignore: must_be_immutable
class SummerPage extends StatelessWidget {
  SummerEntity summerEntity;
  UserStateModel state;
  int applicationId;
  SummerPage(this.summerEntity, this.state, this.applicationId);

  //文件列表

  @override
  Widget build(BuildContext context) {
    return AutoResizeWidget(
      child: SummerWidget(summerEntity, state, applicationId),
    );
  }
}

// ignore: must_be_immutable
class SummerWidget extends StatefulWidget {
  SummerEntity summerEntity;
  UserStateModel state;
  int applicationId;
  SummerWidget(this.summerEntity, this.state, this.applicationId);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SummerState(state, applicationId);
  }
}

class SummerState extends State<SummerWidget> {
  UserStateModel state;
  int applicationId;
  SummerState(this.state, this.applicationId);
  var _value;

  SummerEntity summerEntity = new SummerEntity(
    applicationId: 0,
    title: '',
    text: '',
  );

  TextEditingController _titleController = TextEditingController();
  TextEditingController _textController = TextEditingController();

  TextStyle labelStyle = TextStyle(color: Colors.black, fontSize: 18);//文字格式

  Widget unit(String title, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          labelText: title,
          hintText: '请输入出差总结的标题',
          labelStyle: labelStyle,
          hintStyle: TextStyle(
            color: Colors.grey,
            fontSize: 13,
          ),
          prefixIcon: Container(
            padding: EdgeInsets.all(17.0),
            alignment: Alignment.centerLeft,
            child: Icon(Icons.person),
            width: 70,
            height: 50,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      type: MaterialType.transparency,
      child: SizedBox(
        child: Container(
            padding: EdgeInsets.all(10.0),
            color: Colors.white,
            width: double.infinity,
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('   ' + BUTTON_BUSINESS_SUMMER,
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
                unit("标题", _titleController),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    Center(
                      child: Container(
                        child: Text('内容', style: labelStyle),
                      ),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                    Expanded(
                      child: Container(
                        height: 200,
                        padding: EdgeInsets.only(left: 5),
                        decoration: new BoxDecoration(
                            border: new Border.all(
                                color: Colors.green, width: 1),
                            color: Colors.white,
                            borderRadius: new BorderRadius.circular((20.0))),
                        child: TextFormField(
                          controller: _textController,
                          maxLines: null,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '输入限制400字',
                          ),
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(400)
                          ],
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 30)),
                  ],
                ),
                Container(
                  height: 20,
                ),
                Divider(
                  height: 5,
                  color: Colors.black,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.format_list_numbered,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      '出差总结附件',
                      style: TEXT_STYLE_LABEL,
                    ),
                    SizedBox(
                      width: 80,
                    ),
                    InkWell(
                      child: Text(
                        "添加附件",
                        style: TextStyle(color: Colors.red,fontSize: 18.0),
                      ),
                      onTap: () {
                        //添加附件弹窗
                        //addFile();
                      },
                    ),
                  ],
                ),
//                Divider(),
//                Container(
//                    child: Row(children: [
//                  Text('标签选择'),
//                  Expanded(
//                    child: Text(''),
//                  ),
//                  DropdownButton(
//                      items: [
//                        DropdownMenuItem(
//                          child: Text('娱乐'),
//                          value: 1,
//                        ),
//                        DropdownMenuItem(
//                          child: Text('工作'),
//                          value: 2,
//                        )
//                      ],
//                      hint: Text('请选择'),
//                      icon: Icon(Icons.arrow_forward_ios),
//                      underline: Container(
//                        height: 0,
//                      ),
//                      value: _value,
//                      onChanged: (value) => setState(() => _value = value)),
//                  Padding(padding: EdgeInsets.only(left: 10)),
//                ])),
//                Divider(),
//                Container(
//                  child: Column(children: [
//                    Row(
//                      children: [
//                        Text(
//                          '上传图片(最多可上传六张图片)',
//                          textAlign: TextAlign.left,
//                        )
//                      ],
//                    ),
//                  ]),
//                ),
                SizedBox(height: 10,),
                Expanded(
                  child: Container(
                    child: Column(
                      children: [
                        Text(
                            '序号          附件标题         附件类型          操作  ',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        Container(
                          height: 170.0,
                          // child:ListView(
                          //   scrollDirection: Axis.vertical,
                          //   itemExtent: 40,
                          //   children: [
                          //     ListTile(leading: Icon(Icons.insert_drive_file),title: Text('word1'),),
                          //     ListTile(leading: Icon(Icons.insert_drive_file),title: Text('word2'),),
                          //     ListTile(leading: Icon(Icons.insert_drive_file),title: Text('word3'),),
                          //     ListTile(leading: Icon(Icons.insert_drive_file),title: Text('word4'),),
                          //     ListTile(leading: Icon(Icons.insert_drive_file),title: Text('word5'),),
                          //     ListTile(leading: Icon(Icons.insert_drive_file),title: Text('word6'),),
                          //   ],
                          // ),
                          child: new ListView.separated(
                              itemBuilder:(context,item){
                                //return buildListData(context, titleItems[item], iconItems[item]);
                                return buildListData(context, fileLists[item]);
                              },
                              separatorBuilder: (BuildContext context,int index)=>new Divider(height: 5.0,color: Colors.black,),
                              itemCount: fileLists.length,
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
                // SizedBox(height: 10.0),
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
                        Navigator.of(context).pop();
                      },
                    ),
                    SizedBox(width: 80.0),
                    Builder(
                      builder: (BuildContext context) {
                        return RaisedButton(
                          child:
                              Text("提交", style: TextStyle(color: Colors.white)),
                          color: Color(0xFF087f23),
                          onPressed: (){
                            showAlertDialog();
                          },

                        );
                      },
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }

  Widget buildListData(BuildContext context,fileEntity fileItem)
  {
    String number = fileItem.number;
    String title = fileItem.title;
    String type = fileItem.type;
    return new ListTile(
      contentPadding: EdgeInsets.all(0.0),
      title: new Text('       ' + number +'                '+title +'                  '+'.'+ type),
    );
  }

  // Widget buildListData(BuildContext context,String titleItem , Icon iconItem ){
  //   return new ListTile(
  //     leading: iconItem,
  //     title: new Text(
  //       titleItem,
  //       style: TextStyle(fontSize: 15.0),
  //     ),
  //     onTap: (){
  //
  //     },
  //   );
  // }

  //撤销总结
  _cancelSummer() async{

  }
  _cancel() async {
    _cancelSummer();
  }

  //提交总结，参考制造撤销
  _handleSummer() async {
    summerEntity.title = _titleController.text;
    summerEntity.text = _textController.text;
    summerEntity.applicationId = applicationId;

    print("测试bug   !!!!  applicationId: " + summerEntity.applicationId.toString());
    print("title" + summerEntity.title);
    print("text" + summerEntity.text);

    SummerRepo().doSummer(summerEntity).then((value) {
      BotToast.showText(text: '提交总结成功！');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MainPage()));
    }).catchError((error) {
      BotToast.showText(text: error.toString());
    });
  }

  _apply() async {
    await _handleSummer();
  }



  void showAlertDialog() {
    showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text(
              '提交总结',
              style: TextStyle(color: Colors.green, fontSize: 20),
            ),
            //可滑动
            content: new SingleChildScrollView(
                child: Text(
              "是否确定提交总结？",
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

//文件列表数据源
// 数据源
List<String> titleItems = <String>[
  'keyboard', 'print',
  'router', 'pages',
  'zoom_out_map', 'zoom_out',
  'youtube_searched_for', 'wifi_tethering',
  'wifi_lock', 'widgets',
  'weekend', 'web',
  '图accessible', 'ac_unit',
];

List<Icon> iconItems = <Icon>[
  new Icon(Icons.keyboard), new Icon(Icons.print),
  new Icon(Icons.router), new Icon(Icons.pages),
  new Icon(Icons.zoom_out_map), new Icon(Icons.zoom_out),
  new Icon(Icons.youtube_searched_for), new Icon(Icons.wifi_tethering),
  new Icon(Icons.wifi_lock), new Icon(Icons.widgets),
  new Icon(Icons.weekend), new Icon(Icons.web),
  new Icon(Icons.accessible), new Icon(Icons.ac_unit),
];

List<fileEntity> fileLists = <fileEntity>[
  new fileEntity( '1' ,'word1','doc'),
  new fileEntity( '2' ,'word2','doc'),
  new fileEntity( '3' ,'word3','doc'),
  new fileEntity( '4' ,'word4','doc'),
  new fileEntity( '5' ,'word5','doc'),
  new fileEntity( '6' ,'word6','doc'),
  new fileEntity( '7' ,'word7','doc'),
  new fileEntity( '8' ,'word8','doc'),
  new fileEntity( '9' ,'word9','doc'),
  new fileEntity( '10' ,'word10','doc'),
];

