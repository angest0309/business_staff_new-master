import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:registration_staff/data/apply_repo.dart';
import 'package:registration_staff/dataobj/apply_entity.dart';
class LearnDropdownButton extends StatefulWidget{
  List list = [];
  LearnDropdownButton(List list){
    this.list = list;
  }
  @override
  State<StatefulWidget> createState() {
    return _LearnDropdownButton(list);
  }
}
class _LearnDropdownButton extends State<LearnDropdownButton>{

  // ApplyEntity applyEntity = new ApplyEntity();
  //
  // @override
  // void initState() {
  //   super.initState();
  //   ApplyRepo().doGetDepHeaderList(1).then((value) {
  //     setState(() {
  //       applyEntity.depHeaderList = value;
  //     });
  //   }).catchError((error) {
  //     print(error);
  //     BotToast.showText(text: '获取部门负责人列表失败，请检查网络');
  //   });
  // }

  List list = [];

  _LearnDropdownButton(List list){
    this.list = list;
    print("222222222222222222222222222222" + list.toString());
  }

  List<DropdownMenuItem> getListData() {
    if(list == null){
      list = ['暂无信息，请检查网络'];
    }
    List<DropdownMenuItem> items = [];
    for(int i = 1; i <=list.length ; i++){
      items.add(new DropdownMenuItem(
        child:new Text('${list[i]}'),
        value: '${i}',
      ));
    }
    return items;
  }
  var value;
  @override
  Widget build(BuildContext context) {
    return new DropdownButton(
      items: getListData(),
      hint:new Text('下拉选择你想要的数据'),//当没有默认值的时候可以设置的提示
      value: value,//下拉菜单选择完之后显示给用户的值
      onChanged: (T){//下拉菜单item点击之后的回调
        setState(() {
          value=T;
        });
      },
      elevation: 24,//设置阴影的高度
      style: new TextStyle(//设置文本框里面文字的样式
          color: Colors.red
      ),
//              isDense: false,//减少按钮的高度。默认情况下，此按钮的高度与其菜单项的高度相同。如果isDense为true，则按钮的高度减少约一半。 这个当按钮嵌入添加的容器中时，非常有用
      iconSize: 50.0,//设置三角标icon的大小
    );
  }
}