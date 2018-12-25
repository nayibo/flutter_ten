import 'package:flutter/material.dart';
import 'package:flutter_tenge/constant/common.dart';
import 'package:flutter_tenge/ui/bottom.dart';
import 'package:flutter_tenge/ui/contentPage.dart';
import 'package:flutter_tenge/ui/critic.dart';
import 'package:flutter_tenge/ui/diagram.dart';
import 'package:flutter_tenge/ui/novel.dart';
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
    double _dyStart = null;
    return new Scaffold(
        body: new RawGestureDetector(
      behavior: HitTestBehavior.opaque,
      gestures: {
        AllowMultipleGestureRecognizer: GestureRecognizerFactoryWithHandlers<
            AllowMultipleGestureRecognizer>(
          () => AllowMultipleGestureRecognizer(),
          (AllowMultipleGestureRecognizer instance) {
            instance.onStart = (DragStartDetails details) {
              _dyStart = details.globalPosition.dy;
            };
            instance.onUpdate = (DragUpdateDetails details) {
              if (_dyStart == null) {
                _dyStart = details.globalPosition.dy;
              }
              if (details.globalPosition.dy - _dyStart < 0.0) {
                //up
                homepageBottomBar.refresh(0.0);
              }
              if (details.globalPosition.dy - _dyStart > 0.0) {
                //down
                homepageBottomBar.refresh(1.0);
              }
//              print("dy: " + (details.globalPosition.dy - _dyStart).toString() + " distance: " + details.globalPosition.distanceSquared.toString());
              _dyStart = details.globalPosition.dy;
            };
          },
        )
      },
      child: new Container(
          color: Colors.white,
          child: new Stack(
            children: <Widget>[
              new PageView(
                  children: [
                    new ContentPage(
                        type: CommonConstant.PAGE_CRITIC,
                        scrollToBottomCallback: () {
                          homepageBottomBar.refresh(1.0);
                        }),
                    new ContentPage(
                        type: CommonConstant.PAGE_NOVEL,
                        scrollToBottomCallback: () {
                          homepageBottomBar.refresh(1.0);
                        }),
                    new ContentPage(
                        type: CommonConstant.PAGE_DIAGRAM,
                        scrollToBottomCallback: () {
                          homepageBottomBar.refresh(1.0);
                        }),
                    new SettingPage(),
                  ],
                  controller: _pageController,
                  physics: new NeverScrollableScrollPhysics()),
              homepageBottomBar,
            ],
          )),
    ));
  }
}
