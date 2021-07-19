import 'package:flutter/material.dart';

class AutoResizeWidget extends StatelessWidget {
  Widget child;

  AutoResizeWidget({@required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, box) {
          var queryData = MediaQuery.of(context);
          double screenWidth = queryData.size.width;
          bool isDesktop = screenWidth > 750;
          print('screenWidth:' + screenWidth.toString());
          return Align(
            alignment: Alignment.topCenter,
            child: Container(
                width: isDesktop? screenWidth/2: screenWidth,
                height: double.infinity,
                child: child
            ),
          );
        });
  }
}

