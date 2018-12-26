import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_tenge/constant/sp.dart';
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
  bool _nightMode = false;

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
            height: 156.0,
            width: window.physicalSize.width / window.devicePixelRatio,
            margin: new EdgeInsets.fromLTRB(
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
            onPressed: _goFavoritePage,
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
            onPressed: _goFavoritePage,
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
            onPressed: _goFavoritePage,
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
            onPressed: _goFavoritePage,
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
                  value: _nightMode,
                  onChanged: (bool value) {
                    setState(() {
                      _nightMode = value;
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

  _setFont(int flag) async {
    await SpUtil.getInstance();
    SpUtil.putInt(SPConstant.SP_FONT, flag);
  }

  _setNightMode(bool flag) async {
    await SpUtil.getInstance();
    SpUtil.putBool(SPConstant.SP_NIGHT_MODE, flag);
  }

  void loadAsync() async {
    await SpUtil.getInstance();
  }

  void loadFontAsync() async {
    await FontUtil.getInstance();
  }

  _goFavoritePage() {}
}
