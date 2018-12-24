import 'package:flutter/material.dart';
import 'package:flutter_tenge/constant/common.dart';
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
  int _page = 0;
  var _pageController = new PageController(initialPage: 0);
  double _opacityLevel = 1.0;

  @override
  void initState() {
    super.initState();
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
                _changeOpacity(0.0);
              }
              if (details.globalPosition.dy - _dyStart > 0.0) {
                //down
                _changeOpacity(1.0);
              }
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
                    new ContentPage(type: CommonConstant.PAGE_CRITIC),
                    new ContentPage(type: CommonConstant.PAGE_NOVEL),
                    new ContentPage(type: CommonConstant.PAGE_DIAGRAM),
                    new SettingPage(),
                  ],
                  onPageChanged: _onPageChanged,
                  controller: _pageController,
                  physics: new NeverScrollableScrollPhysics()),
              new Container(
                  alignment: new Alignment(0.0, 1.0),
                  child: new AnimatedOpacity(
                      opacity: _opacityLevel,
                      duration: new Duration(milliseconds: 500),
                      child: new Container(
                        child: new Theme(
                          data: Theme.of(context).copyWith(
                              // sets the background color of the `BottomNavigationBar`
                              canvasColor:
                                  FontUtil.getBottomBarBackgroundColor(),
                              // sets the active color of the `BottomNavigationBar` if `Brightness` is light
                              primaryColor: Colors.red,
                              textTheme: Theme.of(context).textTheme.copyWith(
                                  caption:
                                      new TextStyle(color: Colors.yellow))),
                          // sets the inactive color of the `BottomNavigationBar`
                          child: new BottomNavigationBar(
                            type: BottomNavigationBarType.fixed,
                            items: [
                              new BottomNavigationBarItem(
                                  icon: new Image.asset(
                                      FontUtil.getBottomBarIcon(
                                          CommonConstant.PAGE_CRITIC),
                                      height: 35.0),
                                  activeIcon: new Image.asset(
                                      FontUtil.getBottomBarActiveIcon(
                                          CommonConstant.PAGE_CRITIC),
                                      height: 35.0),
                                  title: Container(height: 0.0)),
                              new BottomNavigationBarItem(
                                  icon: new Image.asset(
                                      FontUtil.getBottomBarIcon(
                                          CommonConstant.PAGE_DIAGRAM),
                                      height: 35.0),
                                  activeIcon: new Image.asset(
                                      FontUtil.getBottomBarActiveIcon(
                                          CommonConstant.PAGE_DIAGRAM),
                                      height: 35.0),
                                  title: Container(height: 0.0)),
                              new BottomNavigationBarItem(
                                  icon: new Image.asset(
                                      FontUtil.getBottomBarIcon(
                                          CommonConstant.PAGE_NOVEL),
                                      height: 35.0),
                                  activeIcon: new Image.asset(
                                      FontUtil.getBottomBarActiveIcon(
                                          CommonConstant.PAGE_NOVEL),
                                      height: 35.0),
                                  title: Container(height: 0.0)),
                              new BottomNavigationBarItem(
                                  icon: new Image.asset(
                                      FontUtil.getBottomBarIcon(
                                          CommonConstant.PAGE_PERSONAL),
                                      height: 35.0),
                                  activeIcon: new Image.asset(
                                      FontUtil.getBottomBarActiveIcon(
                                          CommonConstant.PAGE_PERSONAL),
                                      height: 35.0),
                                  title: Container(height: 0.0)),
                            ],
                            currentIndex: _page,
                            onTap: (int index) {
                              _pageController.jumpToPage(index);
                              _onPageChanged(index);
                            },
                          ),
                        ),
                      ))),
            ],
          )),
    ));
  }

  void _onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  _changeOpacity(double level) {
    setState(() => _opacityLevel = level);
  }
}
