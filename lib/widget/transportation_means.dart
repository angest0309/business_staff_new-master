import 'package:flutter/material.dart';

//交通方式选择组件（editor_dialog中使用）

int _radioGroupA = 0;

class TransportationMeans extends StatefulWidget {
  TransportationMeans(int isDrive){
    _radioGroupA = isDrive;
  }


  int getValue(){
    return _radioGroupA;
  }
  @override
  _TransportationMeansState createState() => _TransportationMeansState();
}

class _TransportationMeansState extends State<TransportationMeans> {

  void _handleRadioValueChanged(int value) {
    setState(() {
      _radioGroupA = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          SizedBox(width: 10.0),
          Icon(Icons.directions_car,color: Colors.grey,),
          SizedBox(width: 10,),
          Text("交通方式",style: TextStyle(
            color: Colors.grey,
            fontSize: 17.0
          ),),
          Radio(
            value: 0,
            groupValue: _radioGroupA,//权组值
            onChanged: _handleRadioValueChanged,
            activeColor: Colors.green,//选中的颜色
          ),
          Text("自驾",style: TextStyle(
              color: Colors.grey,
              fontSize: 17.0
          ),),
          Radio(
              value: 1,
              groupValue: _radioGroupA,//权组值
              onChanged: _handleRadioValueChanged,
              activeColor: Colors.green//选中的颜色
          ),
          Text("公共交通工具",style: TextStyle(
            color: Colors.grey,
            fontSize: 17.0
          ),),
        ],
      ),
    );
  }

}
