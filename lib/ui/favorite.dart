import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_tenge/bean/Favorite.dart';
import 'package:flutter_tenge/bean/ListBean.dart';
import 'package:flutter_tenge/constant/common.dart';
import 'package:flutter_tenge/constant/data.dart';
import 'package:flutter_tenge/network/NetworkUtils.dart';
import 'package:flutter_tenge/ui/favoritedetail.dart';
import 'package:flutter_tenge/ui/title.dart';
import 'package:flutter_tenge/utils/DateUtil.dart';
import 'package:flutter_tenge/utils/FontUtil.dart';
import 'package:flutter_tenge/utils/SharedPreferencesUtil.dart';
import 'package:flutter_tenge/utils/sqflite.dart';

Future<List<FavoriteBean>> fetchFavoritesFromDatabase() async {
  var dbHelper = DBHelper();
  return dbHelper.getFavoriteList();
}

Future<List<FavoriteBean>> fetchFavoritesFromServer() async {
  int _userID = SpUtil.getInt(SPConstant.SP_USER_ID);
  Map<String, String> params = new Map();
  params['userId'] = _userID.toString();
  return NetworkUtils.fetchFavoriteList(
      "http://api.shigeten.net/api/user/GetFavoriteList",
      params: params);
}

Future<List<FavoriteBean>> fetchFavorites() async {
  await SpUtil.getInstance();
  bool _isLogin = SpUtil.getBool(SPConstant.SP_QQ_IS_LOGIN);

  if (_isLogin == null) {
    _isLogin = false;
  }

  if (_isLogin) {
    return fetchFavoritesFromServer();
  } else {
    return fetchFavoritesFromDatabase();
  }
}

class FavoriteListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new FavoriteListState();
  }
}

class FavoriteListState extends State<FavoriteListPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: FontUtil.getMainBgColor(),
        body: new Container(
          child: new FutureBuilder<List<FavoriteBean>>(
              builder: (context, snapshot) {
                if (!snapshot.hasError) {
                  if (snapshot.hasData) {
                    return new FavoriteListWidget(data: snapshot.data);
                  } else {
                    return new FavoriteBlank();
                  }
                }

                return new Center(child: new CircularProgressIndicator());
              },
              future: fetchFavorites()),
        ));
  }
}

class FavoriteListWidget extends StatefulWidget {
  List<FavoriteBean> data;

  FavoriteListWidget({this.data});

  @override
  State<StatefulWidget> createState() {
    return new FavoriteListWidgetState();
  }
}

class FavoriteListWidgetState extends State<FavoriteListWidget> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new Column(
        children: <Widget>[
          new TitleBar(
              title: '我的收藏',
              pressed: () {
                Navigator.of(context).pop();
              }),
          new Container(
            height: 65.0,
            alignment: Alignment.center,
            child: new Text.rich(new TextSpan(children: <TextSpan>[
              new TextSpan(
                  text: widget.data.length.toString(),
                  style:
                      new TextStyle(color: Color(0xffea5151), fontSize: 12.0)),
              new TextSpan(
                  text: '个内容被你收藏，愿他们曾伴你好梦',
                  style: new TextStyle(
                      color: FontUtil.getFeedbackFontColor(), fontSize: 12.0))
            ])),
          ),
          new Container(
            height: 0.5,
            color: FontUtil.getLineShixinColor(),
          ),
          new Expanded(
            flex: 1,
            child: new ListView.builder(
                padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                itemCount: widget.data.length,
                itemBuilder: (context, index) {
                  return new FavoriteItem(data: widget.data[index]);
                }),
          ),
        ],
      ),
    );
  }
}

class FavoriteItem extends StatefulWidget {
  FavoriteBean data;

  FavoriteItem({this.data});

  @override
  State<StatefulWidget> createState() {
    return new FavoriteItemState();
  }
}

class FavoriteItemState extends State<FavoriteItem> {
  @override
  Widget build(BuildContext context) {
    return new Container(
        child: new RaisedButton(
      color: FontUtil.getMainBgColor(),
      elevation: 0,
      highlightElevation: 0,
      disabledElevation: 0,
      onPressed: _goDetail,
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            margin: new EdgeInsets.fromLTRB(0.0, 18.0, 0.0, 0.0),
            height: 38.0,
            width: 38.0,
            color: FontUtil.getArticleBgColor(widget.data.type),
            child: new Column(
              children: <Widget>[
                new Container(
                  margin: new EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                  alignment: Alignment.topCenter,
                  child: new Text(_getFavoriteTypeString(),
                      style: new TextStyle(
                          fontSize: 10.0,
                          color: FontUtil.getFavoriteDateTvColor())),
                ),
                new Container(
                  margin: new EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 0.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Text(_getFavoriteDate(),
                          style: new TextStyle(
                              fontSize: 12.0,
                              color: FontUtil.getFavoriteDateTvColor())),
                      new Text(_getFavoriteMonth(),
                          style: new TextStyle(
                              fontSize: 9.0,
                              color: FontUtil.getFavoriteDateTvColor())),
                    ],
                  ),
                ),
              ],
            ),
          ),
          new Expanded(
              flex: 1,
              child: new Container(
                margin: new EdgeInsets.fromLTRB(10.0, 18.0, 10.0, 0.0),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(widget.data.title,
                        style: new TextStyle(
                            fontSize: 16.0,
                            color: FontUtil.getFavoriteTitleColor())),
                    new Container(
                      margin: new EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                      child: new Text(widget.data.summary,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: new TextStyle(
                              fontSize: 14.0,
                              color: FontUtil.getFavoriteSummaryColor())),
                    ),
                    new Container(
                      margin: new EdgeInsets.fromLTRB(0.0, 18.0, 0.0, 0.0),
                      color: FontUtil.getLineShixinColor(),
                      height: 0.5,
                    )
                  ],
                ),
              ))
        ],
      ),
    ));
  }

  String _getFavoriteTypeString() {
    switch (widget.data.type) {
      case CommonConstant.TYPE_FILM_CRITIC:
        return '影评';
        break;
      case CommonConstant.TYPE_NOVEL:
        return '文章';
        break;
      case CommonConstant.TYPE_BEAUTY_DIAGRAM:
        return '美图';
        break;
      default:
        return '影评';
        break;
    }
  }

  String _getFavoriteDate() {
    DateTime dateTime = DateUtil.getDateTimeByMs(
        DateUtil.formatCSharpMiliSecondtoMiliSecond(widget.data.publishtime));
    int day = dateTime.day;
    if (day < 10) {
      return '0' + dateTime.day.toString();
    }
    return dateTime.day.toString();
  }

  String _getFavoriteMonth() {
    DateTime dateTime = DateUtil.getDateTimeByMs(
        DateUtil.formatCSharpMiliSecondtoMiliSecond(widget.data.publishtime));
    int month = dateTime.month;
    if (month < 10) {
      return '/0' + dateTime.month.toString();
    }
    return '/' + dateTime.month.toString();
  }

  _goDetail() {
    ListItem item = new ListItem();
    item.id = widget.data.id;
    item.type = widget.data.type;
    item.title = widget.data.title;
    item.summary = widget.data.summary;
    item.publishtime = widget.data.publishtime;

    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new FavoriteDetailPage(listItem: item)));
  }
}

class FavoriteBlank extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Container(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Image.asset(
              'assets/images/icon_favorite_tip.png',
              height: 138.0 / window.devicePixelRatio,
              width: 138.0 / window.devicePixelRatio,
            ),
            new Container(
              margin: new EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
              child: new Text(
                '点击文章右下角红色图标\n即可找到收藏按钮',
                style:
                    new TextStyle(fontSize: 16.0, color: new Color(0xFF949494)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
