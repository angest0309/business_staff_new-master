import 'package:city_pickers/city_pickers.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:registration_staff/config/const.dart';

/// 返回时间格式'2019-10-10'
class Datewidget extends StatefulWidget {
  DataCallback callback; /// 定义da一个回调函数，返回选择结果
  Datewidget(this.callback);

  @override
  _DatewidgetState createState() => _DatewidgetState();
}

class _DatewidgetState extends State<Datewidget> {

  DateTime _nowDate = DateTime.now();

  _showDatePicker () async{
    var result = await showDatePicker(
        context:context,
        initialDate: this._nowDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100)
    );
    if(result != null){//点取消有bug：判断result值是否为空即可解决
      setState(() {
        this._nowDate = result;
      });
    }
    /// 回调返回结果
    //widget.callback(DateTimeForMater.formatDate(result));
    widget.callback(formatDate(result,[yyyy,"-",mm,"-",dd,""]));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: <Widget>[
          Text("${formatDate(this._nowDate, [yyyy,"年",mm,"月",dd,"日"])}",style: TextStyle(fontSize: 20.0),),
          Icon(Icons.arrow_drop_down,color: Colors.grey,)
        ],
      ),
      onTap: this._showDatePicker,
    );
  }
}