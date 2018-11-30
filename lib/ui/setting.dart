import 'package:flutter/material.dart';
import 'package:flutter_qq/flutter_qq.dart';

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new LogoFadeState();
  }
}

class SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new Image.network(
          'http://e.hiphotos.baidu.com/image/pic/item/4b90f603738da9773ded4541bd51f8198718e39e.jpg'),
    );
  }
}

class LogoFadeState extends State<SettingPage> {
  // 初始opacityLevel为1.0为可见状态，为0.0时不可见
  double opacityLevel = 1.0;
  var _qqOutput = "empty";

  _changeOpacity() {
    //调用setState（）  根据opacityLevel当前的值重绘ui
    // 当用户点击按钮时opacityLevel的值会（1.0=>0.0=>1.0=>0.0 ...）切换
    // 所以AnimatedOpacity 会根据opacity传入的值(opacityLevel)进行重绘 Widget
    setState(() => opacityLevel = opacityLevel == 0 ? 1.0 : 0.0);
  }

  Future<Null> _handleLogin() async {
    try {
      var qqResult = await FlutterQq.login();
      var output;
      if (qqResult.code == 0) {
        if (qqResult.response == null) {
          output = "登录成功qqResult.response==null";
          return;
        }
        output = "登录成功" + qqResult.response.toString();
      } else {
        output = "登录失败" + qqResult.message;
      }
      setState(() {
        _qqOutput = output;
      });
    } catch (error) {
      print("flutter_plugin_qq_example:" + error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    FlutterQq.registerQQ('1104005798');
    return new Column(
      //一个Column布局，主轴为垂直方向，起点在上沿。
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      //子组件在主轴上均匀分布在容器内，两边留有一半的间隔空间。
      children: [
        new AnimatedOpacity(
            // 使用一个AnimatedOpacity Widget
            opacity: opacityLevel,
            duration: new Duration(seconds: 1), //过渡时间：1
            child: new Container(
              padding: const EdgeInsets.only(
                  right: 20.0, bottom: 15.0, left: 20.0), //内边距
              child: new Text(_qqOutput),
            )),
        new RaisedButton(
          child: new Container(
            child: new Text("点我试试"),
          ),
          onPressed: _changeOpacity, //添加点击事件
        ),
        new RaisedButton(
          child: new Text('login'),
          onPressed: _handleLogin,
        )
      ],
    );
  }
}
