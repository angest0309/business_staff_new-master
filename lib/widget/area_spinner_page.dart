import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:registration_staff/config/const.dart';
import 'package:registration_staff/widget/area_spinner.dart';

class AreaSpinnerPage extends StatefulWidget {
  DataCallback callback;
  AreaSpinnerPage({@required this.callback});
  @override
  _AreaSpinnerPageState createState() => _AreaSpinnerPageState(callback);
}

class _AreaSpinnerPageState extends State<AreaSpinnerPage> {
  DataCallback callback;
  _AreaSpinnerPageState(this.callback);
  List areas = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// 选择器 -- 目的地
        _buildAreaPicker('目的地  ', "广东省广州市天河区", (res) {
          print('目的地 select:' + res);
          areas.add(res);
        }),
        Divider(
          color: Colors.black,
          height: 4,
        ),

        /// 选择器 -- 途径地
        _buildAreaPicker('途径地  ', "广东省广州市天河区", (res) {
          print('目的地 select:' + res);
          areas.add(res);
        }),
        Divider(
          color: Colors.black,
          height: 4,
        ),

        FlatButton(onPressed: (){
          callback(areas.toString());
          Navigator.of(context).pop();
        }, child: Text("确定"))
      ],
    );
  }

  //地区选择器
  _buildAreaPicker(String label, String init, DataCallback callback) {
    return AreaSpinner(
      location: init,
      callback: callback,
      label: label,
    );
  }
}
