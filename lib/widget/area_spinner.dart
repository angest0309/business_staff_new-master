import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/material.dart';
import 'package:registration_staff/config/const.dart';

//地区选择器
class AreaSpinner extends StatefulWidget {
  String location;
  DataCallback callback;
  String label;

  AreaSpinner(
      {@required this.location, @required this.callback, @required this.label});

  @override
  State<StatefulWidget> createState() {
    return _AreaSpinnerState(callback, location);
  }
}

class _AreaSpinnerState extends State<AreaSpinner> {
  String location;
  DataCallback callback;

  _AreaSpinnerState(this.callback, this.location);

  _showDatePicker(BuildContext context) async {
    Result result = await CityPickers.showCityPicker(context: context,height: 300,locationCode:'440106');//天河区地址码
    if (result == null) return;

    setState(() {
      location = result.provinceName + result.cityName + result.areaName;
    });
    callback(location);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.0,
      width: double.infinity,
      padding: EdgeInsets.all(12.0),
      child: InkWell(
        onTap: () => this._showDatePicker(context),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 5,
                ),
                Icon(
                Icons.location_on,
                color: Colors.grey,
              ),
                SizedBox(
                  width: 30,
                ),
                Text(
                  widget.label,
                  style: TEXT_STYLE_LABEL,
                ),
                SizedBox(
                  width: 50,
                ),
                Text(location,
                  style: TEXT_STYLE_LABEL,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
