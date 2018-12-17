import 'package:flutter/material.dart';
import 'package:flutter_qq/flutter_qq.dart';
import 'package:tenge_flutter/ui/critic.dart';
import 'package:tenge_flutter/ui/diagram.dart';
import 'package:tenge_flutter/ui/novel.dart';
import 'package:tenge_flutter/ui/setting.dart';
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
    FlutterQq.registerQQ('1104005798');
    fluwx.register(
        appId: 'wx066029c349d9494b', doOnAndroid: true, doOnIOS: true);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        body: new GestureDetector(
          onVerticalDragDown: (DragDownDetails details) {
            if (details.globalPosition.direction > 1.0) {
              //up
              _changeOpacity(0.0);
            } else {
              //down
              _changeOpacity(1.0);
            }
          },
          child: new Container(
              child: new Stack(
            children: <Widget>[
              new PageView(
                  children: [
                    new CriticPage(),
                    new NovelPage(),
                    new DiagramPage(),
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
                        height: 58.0,
                        child: new BottomNavigationBar(
                          items: [
                            new BottomNavigationBarItem(
                                icon: new Icon(Icons.add),
                                title: new Text('critic'),
                                backgroundColor: Colors.green),
                            new BottomNavigationBarItem(
                                icon: new Icon(Icons.add),
                                title: new Text('novel'),
                                backgroundColor: Colors.red),
                            new BottomNavigationBarItem(
                                icon: new Icon(Icons.add),
                                title: new Text('diagram'),
                                backgroundColor: Colors.green),
                            new BottomNavigationBarItem(
                                icon: new Icon(Icons.add),
                                title: new Text('setting'),
                                backgroundColor: Colors.red),
                          ],
                          currentIndex: _page,
                          onTap: (int index) {
                            _pageController.jumpToPage(index);
                            _onPageChanged(index);
                          },
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
