

import 'package:flutter/material.dart';

class NoGoWidget extends StatelessWidget {
  double width;
  double height;

  NoGoWidget({this.width, this.height});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      width: width?? double.infinity,
      height: height?? 120,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.warning, color: Theme.of(context).primaryColor,),
            SizedBox(width: 10,),
            Text('该时间跨度下暂无行程！', style: Theme.of(context).textTheme.subtitle2,)
          ],
        ),
      ),
    );
  }

}