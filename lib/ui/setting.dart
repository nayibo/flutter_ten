import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_tenge/constant/data.dart';
import 'package:flutter_tenge/ui/about.dart';
import 'package:flutter_tenge/ui/favorite.dart';
import 'package:flutter_tenge/ui/feedback.dart';
import 'package:flutter_tenge/ui/fontsetting.dart';
import 'package:flutter_tenge/utils/FontUtil.dart';
import 'package:flutter_tenge/utils/SharedPreferencesUtil.dart';
//import 'package:flutter_qq/flutter_qq.dart';

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SettingPageState();
  }
}

class SettingPageState extends State<SettingPage> {
//  Future<Null> _handleLogin() async {
//    try {
//      var qqResult = await FlutterQq.login();
//      var output;
//      if (qqResult.code == 0) {
//        if (qqResult.response == null) {
//          output = "登录成功qqResult.response==null";
//          return;
//        }
//        output = "登录成功" + qqResult.response.toString();
//      } else {
//        output = "登录失败" + qqResult.message;
//      }
//      setState(() {
//        _qqOutput = output;
//      });
//    } catch (error) {
//      print("flutter_plugin_qq_example:" + error.toString());
//    }
//  }

  @override
  void initState() {
    super.initState();
    loadFontAsync();
    loadAsync();
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
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
                new Stack(
                  children: <Widget>[
                    new Container(
                        padding: new EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
                        child: new Image.asset('assets/images/avator_login.png',
                            width: 73.0, height: 73.0)),
                    new Image.asset('assets/images/avator_whiteline.png',
                        width: 83.0, height: 83.0),
                  ],
                ),
                new Container(
                  margin: new EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 0.0),
                  child: new Text("点击用QQ登录", style: FontUtil.getUserNameFont()),
                ),
              ],
            )),
        new Container(
          color: Colors.white,
          height: 44,
          child: new RaisedButton(
            color: Colors.white,
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
          color: Colors.white,
          height: 44,
          child: new RaisedButton(
            color: Colors.white,
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
          color: Colors.white,
          height: 44,
          child: new RaisedButton(
            color: Colors.white,
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
          color: Colors.white,
          height: 44,
          child: new RaisedButton(
            color: Colors.white,
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
          color: Colors.white,
          height: 44,
          child: new RaisedButton(
            color: Colors.white,
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
    );
  }

  void loadAsync() async {
    await SpUtil.getInstance();
  }

  void loadFontAsync() async {
    await FontUtil.getInstance();
  }

  _goFavoritePage() {
    Navigator.push(context, new MaterialPageRoute(builder: (context) => new FavoriteListPage()));
  }

  _goAboutPage() {
    Navigator.push(context, new MaterialPageRoute(builder: (context) => new AboutPage()));
  }

  _goFeedbackPage() {
    Navigator.push(context, new MaterialPageRoute(builder: (context) => new FeedbackPage()));
  }

  _goFontSettingPage() {
    Navigator.push(context, new MaterialPageRoute(builder: (context) => new FontSettingPage()));
  }

  _goNightModePage() {

  }
}
