import 'package:auto_size_text/auto_size_text.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_staff/config/api.dart';
import 'package:registration_staff/data/export_repo.dart';
import 'package:registration_staff/dataobj/apply_repo_entity.dart';
import 'package:registration_staff/dataobj/summer_entity.dart';
import 'package:registration_staff/states/apply_state_model.dart';
import 'package:registration_staff/states/user_state_model.dart';
import 'package:registration_staff/widget/auto_resize_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:registration_staff/ui/dialog/summer_dialog.dart';

class DetailPage extends StatefulWidget {
  int userId;
  ApplyStateModel applyStateModel;
  ApplyRepoEntity applyRepoEntity;
  SummerEntity summerEntity;

  DetailPage(this.userId, this.applyStateModel, this.applyRepoEntity);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserStateModel>(
      builder: (BuildContext context, UserStateModel value, Widget child) {
        UserStateModel state =
        Provider.of<UserStateModel>(context, listen: false);
        String start = widget.applyRepoEntity.startTime.substring(0, 10);
        List startsp = start.split("-");
        String end = widget.applyRepoEntity.endTime.substring(0, 10);
        List endsp = end.split("-");
        String apply = widget.applyRepoEntity.applyTime.substring(0, 10);
        List applysp = apply.split("-");

        return WillPopScope(
          onWillPop: () async {
            print("点击返回键");
            Navigator.pop(context);
            return true;
          },
          child: AutoResizeWidget(
            child: Scaffold(
              //type:MaterialType.transparency,
              body: SizedBox(
                child: Container(
                  margin: EdgeInsets.only(top: 20.0),
                  padding: EdgeInsets.all(10.0),
                  color: Colors.white,
                  width: double.infinity,
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            widget.applyRepoEntity.state == 0
                                ? '待审核'
                                : widget.applyRepoEntity.state == 2
                                    ? "已通过"
                                    : "未通过",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w700),
                          ),
                          //如果是已通过状态，可导出申请表
                          widget.applyRepoEntity.state == 2
                              ? RaisedButton(
                                  child: Text(
                                    '导出',
                                    style: Theme.of(context).textTheme.button,
                                  ),
                                  color: Color(0xFF087f23),
                                  onPressed: () {
                                    RxportPDF()
                                        .doExport(widget.applyRepoEntity.id)
                                        .then((value) {
                                      _launchURL(value.toString());
                                    }).catchError((error) {
                                      BotToast.showText(text: "导出申请表失败，请检查网络！");
                                    });
                                  })
                              : Container(),
                          widget.applyRepoEntity.state == 2
                              ? RaisedButton(
                              child: Text(
                                '总结',
                                style: Theme.of(context).textTheme.button,
                              ),
                              color: Color(0xFF087f23),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SummerPage(widget.summerEntity, state, widget.applyRepoEntity.id)
                                    )
                                );
                              },)
                              : Container(),
                          IconButton(
                            icon: Icon(Icons.close),
                            color: Theme.of(context).primaryColor,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                info(Icons.person, "申请人",
                                    widget.applyRepoEntity.applicant),
                                info(Icons.star, "出差原因",
                                    widget.applyRepoEntity.reason),
                                info(Icons.person, "随行人员",
                                    widget.applyRepoEntity.accompany),
                                info(Icons.attach_money, "经费来源",
                                    widget.applyRepoEntity.fundsFrom),
                                info(Icons.timer, "出发时间",
                                    "${startsp[0]}年${startsp[1]}月${startsp[2]}日"),
                                info(Icons.timer, "结束时间",
                                    "${endsp[0]}年${endsp[1]}月${endsp[2]}日"),
                                info(Icons.place, "出发地",
                                    widget.applyRepoEntity.departure),
                                info(Icons.place, "目的地",
                                    widget.applyRepoEntity.destination),
                                info(
                                    Icons.directions_bus,
                                    "交通方式",
                                    widget.applyRepoEntity.transport == null
                                        ? "无"
                                        : widget.applyRepoEntity.transport),
                                info(
                                    Icons.directions_bus,
                                    "超标原因",
                                    widget.applyRepoEntity.transportBeyond ==
                                            null
                                        ? "无"
                                        : widget
                                            .applyRepoEntity.transportBeyond),
                                lastStatusWidget(widget.applyRepoEntity),
                                currentStatusWidget(widget.applyRepoEntity),
                                info(Icons.timer, "提交时间",
                                    "${applysp[0]}年${applysp[1]}月${applysp[2]}日"),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _launchURL(String pdfUrl) async {
    var url = API.reqUrl + pdfUrl;
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget info(IconData iconData, String title, String info) {
    return Container(
      //padding: EdgeInsets.all(10.0),
      height: 50.0,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              //Container(width: 10.0,),
              Container(
                width: 20.0,
                child: Icon(
                  iconData,
                  color: Colors.grey,
                  size: 20,
                ),
              ),
              Container(
                width: 10.0,
              ),
              Container(
                child: Text(
                  '${title}',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Container(
                width: 10.0,
              ),
            ],
          ),
          Container(
              width: 230.0,
              alignment: Alignment.centerRight,
              child: AutoSizeText(
                "${info} ",
                style: TextStyle(color: Colors.grey, fontSize: 18),
                maxLines: 2,
              ))
        ],
      ),
    );
  }

  Widget lastStatusWidget(ApplyRepoEntity applyEntity) {
    return applyEntity.status != 1
        ? Container(
            //padding: EdgeInsets.all(10.0),
            height: 50.0,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    //Container(width: 10.0,),
                    Container(
                      width: 20.0,
                      child: Icon(
                        Icons.check,
                        color: Colors.grey,
                        size: 18,
                      ),
                    ),
                    Container(
                      width: 10.0,
                    ),
                    Container(
                      child: Text(
                        '上一状态',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
                applyEntity.status == 0
                    ? Container(
                        child: Row(
                          children: [
                            Text(
                              "等待",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 18),
                            ),
                            Text(
                              " ${applyEntity.advise} ",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 18),
                            ),
                            Text(
                              "审核 ",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 18),
                            ),
                          ],
                        ),
                      )
                    : applyEntity.status == 2
                        ? Container(
                            child: Row(
                              children: [
                                Text(
                                  "已通过",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 18),
                                ),
                                Text(
                                  " ${applyEntity.advise} ",
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  "审核 ",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 18),
                                ),
                              ],
                            ),
                          )
                        : applyEntity.status == 3
                            ? Container(
                                child: Row(
                                  children: [
                                    Text(
                                      " ${applyEntity.advise} ",
                                      style: TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 18),
                                    ),
                                    Text(
                                      "审核未通过 ",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 18),
                                    ),
                                  ],
                                ),
                              )
                            : applyEntity.status == 4
                                ? Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          "已通过",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 18),
                                        ),
                                        Text(
                                          " ${applyEntity.approval} ",
                                          style: TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          "审核 ",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          " ${applyEntity.advise} ",
                                          style: TextStyle(
                                              color: Colors.redAccent,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          "审核未通过 ",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  )
              ],
            ),
          )
        : Container();
  }

  Widget currentStatusWidget(ApplyRepoEntity applyEntity) {
    return Container(
      //padding: EdgeInsets.all(10.0),
      height: 50.0,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              //Container(width: 10.0,),
              Container(
                width: 20.0,
                child: Icon(
                  Icons.check,
                  color: Colors.grey,
                  size: 18,
                ),
              ),
              Container(
                width: 10.0,
              ),
              Container(
                child: Text(
                  '当前状态',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
          applyEntity.status == 0
              ? Container(
                  child: Row(
                    children: [
                      Text(
                        "等待",
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                      Text(
                        " ${applyEntity.advise} ",
                        style: TextStyle(color: Colors.orange, fontSize: 18),
                      ),
                      Text(
                        "审核 ",
                        style: TextStyle(color: Colors.grey, fontSize: 18),
                      ),
                    ],
                  ),
                )
              : applyEntity.status == 2
                  ? Container(
                      child: Row(
                        children: [
                          Text(
                            "等待",
                            style: TextStyle(color: Colors.grey, fontSize: 18),
                          ),
                          Text(
                            " ${applyEntity.approval} ",
                            style:
                                TextStyle(color: Colors.orange, fontSize: 18),
                          ),
                          Text(
                            "审核 ",
                            style: TextStyle(color: Colors.grey, fontSize: 18),
                          ),
                        ],
                      ),
                    )
                  : applyEntity.status == 3
                      ? Container(
                          child: Row(
                            children: [
                              Text(
                                "等待",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                              Text(
                                " ${applyEntity.approval} ",
                                style: TextStyle(
                                    color: Colors.orange, fontSize: 18),
                              ),
                              Text(
                                "审核 ",
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 18),
                              ),
                            ],
                          ),
                        )
                      : applyEntity.status == 4
                          ? Container(
                              child: Row(
                                children: [
                                  Text(
                                    "审核成功 ",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 18),
                                  ),
                                ],
                              ),
                            )
                          : applyEntity.status == 1
                              ? Container(
                                  child: Row(
                                  children: [
                                    Text(
                                      "已作废 ",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 18),
                                    ),
                                  ],
                                ))
                              : Container(
                                  child: Row(
                                    children: [
                                      Text(
                                        "审核失败 ",
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 18),
                                      ),
                                    ],
                                  ),
                                )
        ],
      ),
    );
  }
}
