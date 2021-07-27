import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:flutterfileselector/flutterfileselector.dart';
import 'package:flutterfileselector/model/drop_down_model.dart';
import 'package:registration_staff/config/const.dart';
import 'package:registration_staff/data/summer_repo.dart';
import 'package:registration_staff/dataobj/file_entity.dart';
import 'package:registration_staff/dataobj/summer_entity.dart';
import 'package:registration_staff/states/user_state_model.dart';
import 'package:registration_staff/widget/File_picker.dart';
import 'package:registration_staff/widget/area_spinner.dart';
import 'package:registration_staff/widget/auto_resize_widget.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';

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


  //添加附件
  String _path = '-';
  bool _pickFileInProgress = false;
  bool _iosPublicDataUTI = true;
  bool _checkByCustomExtension = false;
  bool _checkByMimeType = false;

  final _utiController = TextEditingController(
    text: 'com.sidlatau.example.mwfbak',
  );

  final _extensionController = TextEditingController(
    text: 'mwfbak',
  );

  final _mimeTypeController = TextEditingController(
    text: 'application/pdf image/png',
  );

  SummerEntity summerEntity = new SummerEntity(
    applicationId: 0,
    title: '',
    text: '',
  );
  List<String> fileTypeEnd = [".pdf", ".doc", ".docx",".xls",".xlsx"];

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

  //文件管理
  _pickDocument() async {
    String result;
    try {
      setState(() {
        _path = '-';
        _pickFileInProgress = true;
        print(_path);
      });

      FlutterDocumentPickerParams params = FlutterDocumentPickerParams(
        allowedFileExtensions: _checkByCustomExtension
            ? _extensionController.text
            .split(' ')
            .where((x) => x.isNotEmpty)
            .toList()
            : null,
        allowedUtiTypes: _iosPublicDataUTI
            ? null
            : _utiController.text
            .split(' ')
            .where((x) => x.isNotEmpty)
            .toList(),
        allowedMimeTypes: _checkByMimeType
            ? _mimeTypeController.text
            .split(' ')
            .where((x) => x.isNotEmpty)
            .toList()
            : null,
      );

      result = await FlutterDocumentPicker.openDocument(params: params);
    } catch (e) {
      print(e);
      result = 'Error: $e';
    } finally {
      setState(() {
        _pickFileInProgress = false;
      });
    }

    setState(() {
      _path = result;
    });
  }

  _buildIOSParams() {
    return ParamsCard(
      title: 'iOS Params',
      children: <Widget>[
        Text(
          'Example app is configured to pick custom document type with extension ".mwfbak"',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        Param(
          isEnabled: !_iosPublicDataUTI,
          description:
          'Allow pick all documents("public.data" UTI will be used).',
          controller: _utiController,
          onEnabledChanged: (value) {
            setState(() {
              _iosPublicDataUTI = value;
            });
          },
          textLabel: 'Uniform Type Identifier to pick:',
        ),
      ],
    );
  }

  _buildAndroidParams() {
    return ParamsCard(
      title: 'Android Params',
      children: <Widget>[
        Param(
          isEnabled: _checkByMimeType,
          description: 'Filter files by MIME type',
          controller: _mimeTypeController,
          onEnabledChanged: (value) {
            setState(() {
              _checkByMimeType = value;
            });
          },
          textLabel: 'Allowed MIME types (separated by space):',
        ),
      ],
    );
  }

  _buildCommonParams() {
    return ParamsCard(
      title: 'Common Params',
      children: <Widget>[
        Param(
          isEnabled: _checkByCustomExtension,
          description:
          'Check file by extension - if picked file does not have wantent extension - return "extension_mismatch" error',
          controller: _extensionController,
          onEnabledChanged: (value) {
            setState(() {
              _checkByCustomExtension = value;
            });
          },
          textLabel: 'File extensions (separated by space):',
        ),
      ],
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
                // Row(
                //   mainAxisSize: MainAxisSize.max,
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: <Widget>[
                //     SizedBox(
                //       width: 5,
                //     ),
                //     Icon(
                //       Icons.format_list_numbered,
                //       color: Colors.grey,
                //     ),
                //     SizedBox(
                //       width: 30,
                //     ),
                //     Text(
                //       '出差总结附件',
                //       style: TEXT_STYLE_LABEL,
                //     ),
                //     SizedBox(
                //       width: 80,
                //     ),
                //     FlatButton(
                //       onPressed: _pickFileInProgress ? null : _pickDocument,
                //       child: Row(
                //         children: [
                //           Text('添加附件',style: TextStyle(
                //                        color: Colors.red,
                //                        fontSize: 20,),),
                //           SizedBox(width: 5,),
                //           Icon(Icons.open_in_new,color: Colors.red,),
                //         ],
                //       ),
                //     ),
                //     // Row(
                //     //   mainAxisSize: MainAxisSize.max,
                //     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     //   children: <Widget>[
                //     //     Text('添加附件',
                //     //         style: TextStyle(
                //     //           color: Colors.grey,
                //     //           fontSize: 20,
                //     //         )),
                //     //     IconButton(
                //     //       icon: Icon(Icons.open_in_new),
                //     //       color: Colors.red,
                //     //       onPressed: _pickFileInProgress ? null : _pickDocument,
                //     //     )
                //     //   ],
                //     // ),
                //   ],
                // ),
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
//                 Text('文件路径为'+'$_path'),
//                 SizedBox(height: 10,),
//                 Expanded(
//                   child: Container(
//                     child: Column(
//                       children: [
//                         Text(
//                             '序号          附件标题         附件类型          操作  ',
//                           style: TextStyle(fontSize: 18.0),
//                         ),
//                         Container(
//                           height: 150.0,
//                           // child:ListView(
//                           //   scrollDirection: Axis.vertical,
//                           //   itemExtent: 40,
//                           //   children: [
//                           //     ListTile(leading: Icon(Icons.insert_drive_file),title: Text('word1'),),
//                           //     ListTile(leading: Icon(Icons.insert_drive_file),title: Text('word2'),),
//                           //     ListTile(leading: Icon(Icons.insert_drive_file),title: Text('word3'),),
//                           //     ListTile(leading: Icon(Icons.insert_drive_file),title: Text('word4'),),
//                           //     ListTile(leading: Icon(Icons.insert_drive_file),title: Text('word5'),),
//                           //     ListTile(leading: Icon(Icons.insert_drive_file),title: Text('word6'),),
//                           //   ],
//                           // ),
//                           child: new ListView.separated(
//                               itemBuilder:(context,item){
//                                 //return buildListData(context, titleItems[item], iconItems[item]);
//                                 return buildListData(context, fileLists[item]);
//                               },
//                               separatorBuilder: (BuildContext context,int index)=>new Divider(),
//                               itemCount: fileLists.length,
//                           ),
//                         ),
//
//                       ],
//                     ),
//                   ),
//                 ),
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
      title: new Text( number +'                  '+title +'                  '+type),
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
List<fileEntity> fileLists = <fileEntity>[
  new fileEntity( '1' ,'word1','doc'),
  new fileEntity( '2' ,'word2','doc'),
  new fileEntity( '3' ,'word3','doc'),
  new fileEntity( '4' ,'word4','doc'),
  new fileEntity( '5' ,'word5','doc'),
  new fileEntity( '6' ,'word6','doc'),
  new fileEntity( '7' ,'word7','doc'),
];

