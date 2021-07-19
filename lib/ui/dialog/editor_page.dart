import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_staff/config/const.dart';
import 'package:registration_staff/dataobj/login_response_entity.dart';
import 'package:registration_staff/states/user_state_model.dart';
import 'package:registration_staff/widget/area_spinner.dart';
import 'package:registration_staff/widget/auto_resize_widget.dart';
import 'package:registration_staff/widget/date_spinner.dart';
import 'package:registration_staff/widget/transportation_means.dart';
import 'package:registration_staff/widget/transportation_pathway.dart';

//编辑职工信息弹出框

class EditorPage extends StatelessWidget {
  TextEditingController _transController;
  BuildContext _outerContext;
  User _user;
  User _saveUser; // 存储修改结果
  EditorPage(this._outerContext, this._user);
  TransportationMeans _transportationMeans;
  TransportationPathway _transportationPathway;

  @override
  Widget build(BuildContext context) {
    _saveUser = _user.copyWith();
    //_transController = TextEditingController(text: _user.transBatch);
    return AutoResizeWidget(
      child: Material(
        child: Container(
          padding: EdgeInsets.all(10.0),
          color: Colors.white,
          width: double.infinity,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(" 编辑信息 ", style: Theme.of(context).textTheme.title),
                  Text("(日期选择通过滑动翻页)"),
                ],
              ),
              Form(
                // 表单
                child: Column(
                  children: <Widget>[
                    // _buildAreaPicker('现居住地点  ', _user.workerCurAdd, (res) {
                    //   print('select:' + res);
                    //   _saveUser.workerCurAdd = res;
                    // }),
                    // Divider(
                    //   color: Colors.black,
                    //   height: 4,
                    // ),
                    // _buildAreaPicker('上居住地点  ', _user.workerLastAdd, (res) {
                    //   print('select:' + res);
                    //   _saveUser.workerLastAdd = res;
                    // }),
                    // Divider(
                    //   color: Colors.black,
                    //   height: 4,
                    // ),
                    // DateSpinner("到现居所时间", _user.workerToaddTime,
                    //         (date) => _saveUser.workerToaddTime=date),
                    // Divider(
                    //   color: Colors.black,
                    //   height: 4,
                    // ),
                    // DateSpinner("到上居所时间", _user.workerToaddLasttime,
                    //         (date) => _saveUser.workerToaddLasttime=date),
                    // Divider(
                    //   color: Colors.black,
                    //   height: 4,
                    // ),
                    //
                    // //交通方式
                    // _transportationMeans = TransportationMeans(_user.isDrive),
                    // _transportationPathway = TransportationPathway(_user.passHubei),
                    // TextFormField(
                    //   controller: _transController,
                    //   decoration: InputDecoration(
                    //     labelText: '返回广州交通班次',
                    //     hintText: '请输入您的交通班次',
                    //     hintStyle: TextStyle(
                    //       color: Colors.grey,
                    //       fontSize: 13,
                    //     ),
                    //     prefixIcon: Icon(Icons.directions_car),
                    //   ),
                    // ),
                    //
                    //
                    // SizedBox(height: 20.0),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: <Widget>[
                    //     RaisedButton(
                    //       child: Text(
                    //         "取消",
                    //         style: TextStyle(color: Colors.white),
                    //       ),
                    //       color: Color(0xFF087f23),
                    //       onPressed: () {
                    //         Navigator.pop(context);
                    //       },
                    //     ),
                    //     SizedBox(width: 100.0),
                    //     RaisedButton(
                    //       child: Text("确定",
                    //           style: TextStyle(color: Colors.white)),
                    //       color: Color(0xFF087f23),
                    //       onPressed: () => _confirm(context),
                    //     ),
                    //   ],
                    // )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }



  _buildDatePicker(String label, String init, DataCallback callback) {
    return Container(
      height: 55.0,
      padding: EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.access_time,
                color: Colors.grey,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                label,
                style: TEXT_STYLE_LABEL,
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildAreaPicker(String label, String init, DataCallback callback) {
    return AreaSpinner(
      location: init,
      callback: callback, label: label,
    );
  }

  // 处理提交信息
  // _confirm(BuildContext context) {
  //   String _trans1 = this._transportationMeans.getValue() == 0?"自驾":"公共交通工具";
  //   String _trans2 = this._transportationPathway.getValue() == 0?"途经湖北":"无途径湖北";
  //   _saveUser.workerTrans = _trans1 + "，" + _transController.text + "，" + _trans2;
  //   UserStateModel stateModel = Provider.of<UserStateModel>(_outerContext, listen: false);
  //   // 提交
  //   stateModel.confirmActivity(_saveUser).then((value) {
  //     BotToast.showText(text: '更新成功');
  //     Navigator.pop(context);
  //   }).catchError((err) {
  //     BotToast.showText(text: '更新失败，'+ err.toString());
  //   });
  // }
}
