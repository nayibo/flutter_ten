import 'package:flutter/material.dart';

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
  _changeOpacity() {
    //调用setState（）  根据opacityLevel当前的值重绘ui
    // 当用户点击按钮时opacityLevel的值会（1.0=>0.0=>1.0=>0.0 ...）切换
    // 所以AnimatedOpacity 会根据opacity传入的值(opacityLevel)进行重绘 Widget
    setState(
            () => opacityLevel = opacityLevel == 0 ? 1.0 : 0.0
    );
  }
  @override
  Widget build(BuildContext context) {
    return new Column(//一个Column布局，主轴为垂直方向，起点在上沿。
      mainAxisAlignment: MainAxisAlignment.spaceAround,//子组件在主轴上均匀分布在容器内，两边留有一半的间隔空间。
      children: [
        new AnimatedOpacity(// 使用一个AnimatedOpacity Widget
            opacity: opacityLevel,
            duration: new Duration(seconds: 1),//过渡时间：1
            child:new Container(
              padding:const EdgeInsets.only(right:20.0,bottom:15.0,left:20.0),//内边距
              child:new Text("和React Native一样，Flutter也提供响应式的视图，Flutter采用不同的方法避免由JavaScript桥接器引起的性能问题，即用名为Dart的程序语言来编译。Dart是用预编译的方式编译多个平台的原生代码，这允许Flutter直接与平台通信，而不需要通过执行上下文切换的JavaScript桥接器。编译为原生代码也可以加快应用程序的启动时间。实际上，Flutter是唯一提供响应式视图而不需要JavaScript桥接器的移动SDK，这就足以让Fluttter变得有趣而值得一试，但Flutter还有一些革命性的东西，即它是如何实现UI组件的？") ,)
        ),
        new RaisedButton(
          child:new Container(
            child: new Text("点我试试"),
          ) ,
          onPressed: _changeOpacity,//添加点击事件
        ),
      ],
    );
  }
}