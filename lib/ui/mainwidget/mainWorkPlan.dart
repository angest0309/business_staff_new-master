import 'package:flutter/material.dart';
import 'package:registration_staff/config/api.dart';
import 'package:registration_staff/config/const.dart';
import 'package:registration_staff/data/news_repo.dart';
import 'package:registration_staff/dataobj/news_entity.dart';
import 'package:registration_staff/widget/card_item.dart';
import 'package:url_launcher/url_launcher.dart';

class MainWorkPlan extends StatefulWidget {
  @override
  _MainWorkPlanState createState() => _MainWorkPlanState();
}

class _MainWorkPlanState extends State<MainWorkPlan> {

  @override
  Widget build(BuildContext context) {
    return CardItem(
        title: MAIN_PLAN,
        child: GestureDetector(
          onTap: () => openLink(),
          child: Container(
            width: double.infinity,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              'todo 工作计划',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 16),
                              softWrap: true,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
        );
  }

  openLink() {
    launch(API.BOOK_URL);
  }
}

class _NewsItem extends StatelessWidget {
  NewsEntity news;

  _NewsItem(this.news);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 2),
      child: GestureDetector(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Text(
                news.title,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: 2,
            ),
            Flexible(
              flex: 0,
              child: Text(
                news.time,
              ),
            )
          ],
        ),
        onTap: () async {
          await launch(news.url);
        },
      ),
    );
  }
}
