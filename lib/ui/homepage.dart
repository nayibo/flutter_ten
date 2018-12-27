import 'package:flutter/material.dart';
import 'package:flutter_tenge/constant/common.dart';
import 'package:flutter_tenge/ui/bottom.dart';
import 'package:flutter_tenge/ui/contentPage.dart';
import 'package:flutter_tenge/ui/setting.dart';
import 'package:flutter_tenge/utils/FontUtil.dart';
import 'package:flutter_tenge/widget/AllowMultipleGestureRecognizer.dart';

//import 'package:flutter_qq/flutter_qq.dart';
import 'package:fluwx/fluwx.dart' as fluwx;

class Homepage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomepageState();
  }
}

class HomepageState extends State<Homepage> {
  var _pageController = new PageController(initialPage: 0);
  HomepageBottomBar homepageBottomBar;

  @override
  void initState() {
    super.initState();
    homepageBottomBar = new HomepageBottomBar(clickCallback: (index) {
      _pageController.jumpToPage(index);
    });
//    FlutterQq.registerQQ('1104005798');
    fluwx.register(
        appId: 'wx066029c349d9494b', doOnAndroid: true, doOnIOS: true);
    loadFontAsync();
  }

  void loadFontAsync() async {
    await FontUtil.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Container(
            color: Colors.white,
            child: new Stack(
              children: <Widget>[
                new PageView(
                    children: [
                      new ContentPage(
                          type: CommonConstant.PAGE_CRITIC,
                          scrollCallback: (double level) {
                            homepageBottomBar.refresh(level);
                          }),
                      new ContentPage(
                          type: CommonConstant.PAGE_NOVEL,
                          scrollCallback: (double level) {
                            homepageBottomBar.refresh(level);
                          }),
                      new ContentPage(
                          type: CommonConstant.PAGE_DIAGRAM,
                          scrollCallback: (double level) {
                            homepageBottomBar.refresh(level);
                          }),
                      new SettingPage(),
                    ],
                    controller: _pageController,
                    physics: new NeverScrollableScrollPhysics()),
                homepageBottomBar,
              ],
            )));
  }
}
