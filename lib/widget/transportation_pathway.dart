import 'package:flutter/material.dart';

//是否途径湖北选择组件（editor_dialog中使用）
int _radioGroupA = 1;

class TransportationPathway extends StatefulWidget {



  getValue(){
    return _radioGroupA;
  }
  @override
  _TransportationPathwayState createState() => _TransportationPathwayState();

  TransportationPathway(value) {
    _radioGroupA = value;
  }
}

class _TransportationPathwayState extends State<TransportationPathway> {

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
          SizedBox(width: 10.0),
          Text("是否途径湖北",style: TextStyle(
              color: Colors.grey,
              fontSize: 17.0
          ),),
          Radio(
            value: 0,
            groupValue: _radioGroupA,//权组值
            onChanged: _handleRadioValueChanged,
            activeColor: Colors.green,//选中的颜色
          ),
          Text("是",style: TextStyle(
              color: Colors.grey,
              fontSize: 17.0)),
          Radio(
              value: 1,
              groupValue: _radioGroupA,//权组值
              onChanged: _handleRadioValueChanged,
              activeColor: Colors.green//选中的颜色
          ),
          Text("否",style: TextStyle(
              color: Colors.grey,
              fontSize: 17.0))

        ],
      ),
    );
  }

}
