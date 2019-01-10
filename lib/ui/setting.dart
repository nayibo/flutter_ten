import 'dart:convert';
import 'dart:ui';

import 'package:fake_tencent/fake_tencent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tenge/bean/Favorite.dart';
import 'package:flutter_tenge/bean/UserBean.dart';
import 'package:flutter_tenge/constant/data.dart';
import 'package:flutter_tenge/network/NetworkUtils.dart';
import 'package:flutter_tenge/ui/about.dart';
import 'package:flutter_tenge/ui/callback.dart';
import 'package:flutter_tenge/ui/favorite.dart';
import 'package:flutter_tenge/ui/feedback.dart';
import 'package:flutter_tenge/ui/fontsetting.dart';
import 'package:flutter_tenge/utils/FontUtil.dart';
import 'package:flutter_tenge/utils/ShareUtil.dart';
import 'package:flutter_tenge/utils/SharedPreferencesUtil.dart';
import 'package:flutter_tenge/utils/sqflite.dart';

class SettingPage extends StatefulWidget {
  SettingNightModeCallback settingNightModeCallback;

  SettingPage({this.settingNightModeCallback});

  @override
  State<StatefulWidget> createState() {
    return new SettingPageState();
  }
}

class SettingPageState extends State<SettingPage> {
  bool _isLogin = false;
  String _userName = '';
  String _userAvatar = '';

  @override
  void initState() {
    _initLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: FontUtil.getMainBgColor(),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          new Container(
              color: FontUtil.getLoginBackgroundColor(),
              height: 156.0 + MediaQueryData.fromWindow(window).padding.top,
              width: window.physicalSize.width / window.devicePixelRatio,
              padding: new EdgeInsets.fromLTRB(
                  0.0, MediaQueryData.fromWindow(window).padding.top, 0.0, 0.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new IconButton(
                      iconSize: 83.0,
                      icon: new Stack(
                        children: <Widget>[
                          new Container(
                              padding:
                                  new EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                              child: getUserAvatar()),
                          new Image.asset(FontUtil.getWhiteLine(),
                              width: 83.0, height: 83.0),
                        ],
                      ),
                      onPressed: _avatarClick),
                  new Container(
                    margin: new EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 0.0),
                    child:
                        new Text(_userName, style: FontUtil.getUserNameFont()),
                  ),
                ],
              )),
          new Container(
            color: FontUtil.getMainBgColor(),
            height: 44,
            child: new RaisedButton(
              color: FontUtil.getMainBgColor(),
              elevation: 0,
              highlightElevation: 0,
              disabledElevation: 0,
              onPressed: _goFavoritePage,
              child: new Row(
                children: <Widget>[
                  new Expanded(
                      child: new Row(
                    children: <Widget>[
                      new Image.asset(FontUtil.getFavoriteIcon(),
                          height: 18.0, width: 18.0),
                      new Container(
                          margin: new EdgeInsets.fromLTRB(6.0, 0.0, 0.0, 0.0),
                          child: new Text(
                            '我的收藏',
                            style: FontUtil.getSettingItemFont(),
                          )),
                    ],
                  )),
                  new Image.asset(FontUtil.getSettingArrowIcon()),
                ],
              ),
            ),
          ),
          new Container(
            margin: new EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
            color: FontUtil.getLineShixinColor(),
            height: 0.5,
          ),
          new Container(
            color: FontUtil.getMainBgColor(),
            height: 44,
            child: new RaisedButton(
              color: FontUtil.getMainBgColor(),
              elevation: 0,
              highlightElevation: 0,
              disabledElevation: 0,
              onPressed: _goFontSettingPage,
              child: new Row(
                children: <Widget>[
                  new Expanded(
                      child: new Row(
                    children: <Widget>[
                      new Image.asset(FontUtil.getFontIcon(),
                          height: 18.0, width: 18.0),
                      new Container(
                          margin: new EdgeInsets.fromLTRB(6.0, 0.0, 0.0, 0.0),
                          child: new Text(
                            '字体设置',
                            style: FontUtil.getSettingItemFont(),
                          )),
                    ],
                  )),
                  new Image.asset(FontUtil.getSettingArrowIcon()),
                ],
              ),
            ),
          ),
          new Container(
            margin: new EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
            color: FontUtil.getLineShixinColor(),
            height: 0.5,
          ),
          new Container(
            color: FontUtil.getMainBgColor(),
            height: 44,
            child: new RaisedButton(
              color: FontUtil.getMainBgColor(),
              elevation: 0,
              highlightElevation: 0,
              disabledElevation: 0,
              onPressed: _goAboutPage,
              child: new Row(
                children: <Widget>[
                  new Expanded(
                      child: new Row(
                    children: <Widget>[
                      new Image.asset(FontUtil.getAboutUsIcon(),
                          height: 18.0, width: 18.0),
                      new Container(
                          margin: new EdgeInsets.fromLTRB(6.0, 0.0, 0.0, 0.0),
                          child: new Text(
                            '关于十个',
                            style: FontUtil.getSettingItemFont(),
                          )),
                    ],
                  )),
                  new Image.asset(FontUtil.getSettingArrowIcon()),
                ],
              ),
            ),
          ),
          new Container(
            margin: new EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
            color: FontUtil.getLineShixinColor(),
            height: 0.5,
          ),
          new Container(
            color: FontUtil.getMainBgColor(),
            height: 44,
            child: new RaisedButton(
              color: FontUtil.getMainBgColor(),
              elevation: 0,
              highlightElevation: 0,
              disabledElevation: 0,
              onPressed: _goFeedbackPage,
              child: new Row(
                children: <Widget>[
                  new Expanded(
                      child: new Row(
                    children: <Widget>[
                      new Image.asset(FontUtil.getFeedbackIcon(),
                          height: 18.0, width: 18.0),
                      new Container(
                          margin: new EdgeInsets.fromLTRB(6.0, 0.0, 0.0, 0.0),
                          child: new Text(
                            '意见反馈',
                            style: FontUtil.getSettingItemFont(),
                          )),
                    ],
                  )),
                  new Image.asset(FontUtil.getSettingArrowIcon()),
                ],
              ),
            ),
          ),
          new Container(
            margin: new EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
            color: FontUtil.getLineShixinColor(),
            height: 0.5,
          ),
          new Container(
            color: FontUtil.getMainBgColor(),
            height: 44,
            child: new RaisedButton(
              color: FontUtil.getMainBgColor(),
              elevation: 0,
              highlightElevation: 0,
              disabledElevation: 0,
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPressed: _goNightModePage,
              child: new Row(
                children: <Widget>[
                  new Expanded(
                      child: new Row(
                    children: <Widget>[
                      new Image.asset(FontUtil.getNightModeIcon(),
                          height: 18.0, width: 18.0),
                      new Container(
                          margin: new EdgeInsets.fromLTRB(6.0, 0.0, 0.0, 0.0),
                          child: new Text(
                            '夜间模式',
                            style: FontUtil.getSettingItemFont(),
                          )),
                    ],
                  )),
                  new Switch(
                    value: FontUtil.getNightMode(),
                    onChanged: (bool value) {
                      setState(() {
                        FontUtil.setNightModel(value);
                        if (widget.settingNightModeCallback != null) {
                          widget.settingNightModeCallback();
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          new Container(
            margin: new EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
            color: FontUtil.getLineShixinColor(),
            height: 0.5,
          ),
        ],
      ),
    );
  }

  _goFavoritePage() {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new FavoriteListPage()));
  }

  _goAboutPage() {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => new AboutPage()));
  }

  _goFeedbackPage() {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new FeedbackPage()));
  }

  _goFontSettingPage() {
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new FontSettingPage()));
  }

  _goNightModePage() {}

  _avatarClick() {
    if (!_isLogin) {
      QQShareUtil.getInstance();
      QQShareUtil.login(_listenLogin);
    } else {
      _logoutClick();
    }
  }

  _logoutClick() {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
                title: new Text("退出登录"),
                content: new Text("退出登录后不能多端同步了诶"),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text("取消"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  new FlatButton(
                    child: new Text("退出"),
                    onPressed: () {
                      _logout();
                      Navigator.of(context).pop();
                    },
                  )
                ]));
  }

  _logout() async {
    _isLogin = false;
    await SpUtil.getInstance();
    await SpUtil.putBool(SPConstant.SP_QQ_IS_LOGIN, false);
    await SpUtil.putString(SPConstant.SP_QQ_OPEN_ID, null);
    await SpUtil.putString(SPConstant.SP_QQ_ACCESS_TOKEN, null);
    await SpUtil.putInt(SPConstant.SP_QQ_EXPIRES_TIME_SEC, null);
    _initLogin();
  }

  void _listenLogin(FakeTencentLoginResp resp) {
    String content =
        'setting login: ${resp.openId} - ${resp.accessToken}- ${resp.expirationDate}';
    print('setting 登录 ' + content);
    setLoginInfo(resp);
  }

  void _listenUserInfo(FakeTencentUserInfoResp resp) {
    setState(() {
      print('listen user info ' +
          resp.nickName.toString() +
          resp.headImgUrl().toString());
      _userName = resp.nickName;
      _userAvatar = resp.headImgUrl();
    });
  }

  Future<void> setLoginInfo(FakeTencentLoginResp resp) async {
    _isLogin = true;
    await SpUtil.getInstance();
    await SpUtil.putBool(SPConstant.SP_QQ_IS_LOGIN, true);
    await SpUtil.putString(SPConstant.SP_QQ_OPEN_ID, resp.openId);
    await SpUtil.putString(SPConstant.SP_QQ_ACCESS_TOKEN, resp.accessToken);
    await SpUtil.putInt(SPConstant.SP_QQ_EXPIRES_TIME_SEC, resp.expirationDate);
    QQShareUtil.getUserInfo(_listenUserInfo);
    _loginTenGe(resp.openId);
  }

  Widget getUserAvatar() {
    if (_isLogin) {
      return new Container(
          height: 73.0,
          width: 73.0,
          child: new CircleAvatar(
            backgroundColor: FontUtil.getMainBgColor(),
            backgroundImage: new NetworkImage(_userAvatar),
          ));
    } else {
      return new Image.asset(FontUtil.getLoginAvatarIcon(),
          width: 73.0, height: 73.0);
    }
  }

  _initLogin() {
    _isLogin = SpUtil.getBool(SPConstant.SP_QQ_IS_LOGIN);

    if (_isLogin == null) {
      _isLogin = false;
    }
    print('init islogin: ' + _isLogin.toString());
    if (_isLogin) {
      QQShareUtil.getInstance();
      QQShareUtil.getUserInfo(_listenUserInfo);
    } else {
      setState(() {
        _userName = '点击用QQ登录';
      });
    }
  }

  _loginTenGe(String openID) async {
    if (openID == null) {
      return;
    }
    Map<String, String> params = new Map();
    params['openId'] = openID;
    params['type'] = '0';
    NetworkUtils.get(
        "http://api.shigeten.net/api/user/Login",
        (data) {
          if (data != null) {
            print('userid: ' + data.toString());
            UserBean userBean = new UserBean.fromJson(data);
            SpUtil.putInt(SPConstant.SP_USER_ID, userBean.userId);
            _syncFavoriteList(userBean.userId);
          }
        },
        params: params,
        errorCallback: (e) {
          print("_getCritic network error: $e");
        });
  }

  _syncFavoriteList(int userID) async {
    fetchFavoritesFromDatabase().then(((List<FavoriteBean> favList) {
      for (int i = 0; i < favList.length; i++) {
        favList[i].userId = userID;
      }
      print('list data: ' + json.encode(favList));
      NetworkUtils.post(
          "http://api.shigeten.net/api/user/AddFavorite",
          (data) {
            if (data != null) {
              if (data['result']) {
                var dbHelper = DBHelper();
                return dbHelper.deleteAllFavorite();
              }
            }
          },
          body: json.encode(favList),
          errorCallback: (e) {
            print("_getCritic network error: $e");
          });
    }));
  }

  Future<List<FavoriteBean>> fetchFavoritesFromDatabase() async {
    var dbHelper = DBHelper();
    return dbHelper.getFavoriteList();
  }
}
