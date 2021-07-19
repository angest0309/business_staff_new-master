import 'package:city_pickers/city_pickers.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:registration_staff/config/const.dart';

/// 列表选择器，带label
class SelectorWidget extends StatefulWidget {
  DataCallback callback;
  String init;
  String label;
  Map<String, String> data;

  SelectorWidget({this.label = '', this.init = '',@required this.callback,@required this.data, Key key})
      : super(key: key);

  @override
  _SelectorWidgetState createState() => _SelectorWidgetState(label, init, callback, data);
}

class _SelectorWidgetState extends State<SelectorWidget> {
  DataCallback callback;
  String _selected;
  String label;
  Map<String, String> data;

  _SelectorWidgetState(this.label, this._selected, this.callback, this.data);

  _showDatePicker() async {
    Result result = await CityPickers.showCityPicker(
        context: context, showType: ShowType.p, provincesData: data, citiesData: Map());
    if (result != null) {
      setState(() {
        _selected = result.provinceName;
      });
      callback(result.provinceId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.0,
      padding: EdgeInsets.all(12.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.assistant_photo,
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
              InkWell(
                child: Row(
                  children: <Widget>[
                    Text(
                      _selected,
                      style: TEXT_STYLE_LABEL,
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Colors.grey,
                    )
                  ],
                ),
                onTap: this._showDatePicker,
              ),
            ],
          ),
          Divider(
            color: Colors.black,
            height: 4,
          ),
        ],
      ),
    );
  }
}
