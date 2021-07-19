import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_staff/common/check.dart';
import 'package:registration_staff/states/user_state_model.dart';

//员工登录弹出框
class LoginDialog extends Dialog {
  TextEditingController _editingController = TextEditingController();

  GlobalKey _formKey = GlobalKey<FormState>();


  UserStateModel stateModel;

  LoginDialog(this.stateModel);

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: SafeArea(//解决特殊屏幕如刘海屏或底部button栏的存在导致组件位置错乱
            child: Center(
          child: Container(
            padding: EdgeInsets.all(10.0),
            margin: EdgeInsets.all(10),
            color: Colors.white,
            width: double.infinity,
            height: 250,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(" 填报登录", style: Theme.of(context).textTheme.title),
                    SizedBox(width: 190.0),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
                Divider(),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    validator: (v) {//validator接受当前textfield的数据
                      return isIdCard(v.trim()) ? null : '身份证号码格式错误';
                    },
                    controller: _editingController,
                    decoration: InputDecoration(//输入装饰设置
                      labelText: '请输入身份证号码',
                      hintText: '您的身份证号码',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
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
                    SizedBox(width: 10.0),
                    Builder(builder: (BuildContext context) {
                      return RaisedButton(
                        child: Text("确定", style: TextStyle(color: Colors.white)),
                        color: Color(0xFF087f23),
                        onPressed: () => _handleLogin(context),
                      );
                    },),
                  ],
                )
              ],
            ),
          ),
        )));
  }

  _handleLogin(BuildContext context) {//登录方法
    if ((_formKey.currentState as FormState).validate()) {
      String id = _editingController.text;
      print('身份证: ' + id);
//      var model = Provider.of<UserStateModel>(context);
      var model = stateModel; //用户状态管理类
      print('model:' + model.toString());
      model.login(id).then((value) {
        print('登陆成功');
        BotToast.showText(text: '登陆成功');
        Navigator.pop(context);
      }).catchError((err) {
        // 登陆失败
        print('登陆失败,' + err.toString());
        BotToast.showText(text: '登陆失败,'+ err.toString());
      });
    }
  }
}
