import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_tenge/bean/Favorite.dart';
import 'package:flutter_tenge/ui/homepage.dart';
import 'package:flutter_tenge/utils/FavoriteUtil.dart';
import 'package:flutter_tenge/utils/FontUtil.dart';
import 'package:umeng_analytics/umeng_analytics.dart';

class WelcomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new WelcomePageState();
  }
}

class WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _controller;
  double _alignmentX = 2.5;

  @override
  void initState() {
    super.initState();
    UmengAnalytics.init('551380b9fd98c539bf000c37',
        policy: Policy.BATCH, encrypt: true, reportCrash: false);

    FavoriteUtil.getInstance()
        .fetchFavorites()
        .then((List<FavoriteBean> favList) {
      print("welcome favlist: " + favList.length.toString());
      FavoriteUtil.getInstance().setFavoriteListData(favList);
    });
    loadAsync();
    _controller = new AnimationController(
        duration: const Duration(milliseconds: 3000), value: 0.01, vsync: this);

    _animation = new Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        if (_animation.status == AnimationStatus.completed) {
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => new Homepage()));
        }
        setState(() {
          _alignmentX = _animation.value;
        });
      });

    _controller.forward();
  }

  void loadAsync() {
    if (!FontUtil.isReady()) {
      FontUtil.getInstance().then((FontUtil font) {
        print('waiting for FontUtil init complete');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          new Image.asset('assets/images/start_bg.png',
              alignment: Alignment(_alignmentX, 0.0),
              fit: BoxFit.cover,
              height: window.physicalSize.height / window.devicePixelRatio,
              width: window.physicalSize.width / window.devicePixelRatio),
          new Container(
            margin: new EdgeInsets.fromLTRB(0.0, 300.0, 0.0, 0.0),
            alignment: Alignment.topCenter,
            child: new Image.asset(
              'assets/images/welcome_logo.png',
              height: 195.0 / window.devicePixelRatio,
              width: 251.0 / window.devicePixelRatio,
            ),
          ),
          new Container(
            margin: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 50.0),
            alignment: Alignment.bottomCenter,
            child: new Text('半杯咖啡工作室',
                style: new TextStyle(fontSize: 13.0, color: Colors.white)),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
