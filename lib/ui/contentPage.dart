import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_tenge/bean/ListBean.dart';
import 'package:flutter_tenge/constant/common.dart';
import 'package:flutter_tenge/constant/data.dart';
import 'package:flutter_tenge/ui/callback.dart';
import 'package:flutter_tenge/ui/critic.dart';
import 'package:flutter_tenge/ui/diagram.dart';
import 'package:flutter_tenge/ui/header.dart';
import 'package:flutter_tenge/ui/novel.dart';
import 'package:flutter_tenge/ui/shareicon.dart';
import 'package:flutter_tenge/utils/FontUtil.dart';
import 'package:flutter_tenge/utils/SharedPreferencesUtil.dart';

class ContentPage extends StatefulWidget {
  ScrollCallback scrollCallback;

  ContentPage({this.type, this.scrollCallback});

  String type = CommonConstant.PAGE_CRITIC;

  @override
  State<StatefulWidget> createState() {
    return new ContentPageState();
  }
}

class ContentPageState extends State<ContentPage>
    with SingleTickerProviderStateMixin {
  ScrollController scrollController = new ScrollController();
  HomepageHeader homepageHeader;
  ShareIcon shareIcon;
  Animation<double> animation;
  AnimationController _controller;
  bool _helperVisibility = true;

  @override
  void initState() {
    super.initState();
    loadAsync();
    _readHelper().then((value) {
      setState(() {
        print("init read helper setState");
        if (value == null || !value) {
          _saveHelper();
          _helperVisibility = false;
          _controller.forward();
        }
      });
    });

    if (!_helperVisibility) {
      _controller.forward();
    }

    _controller = new AnimationController(
        duration: const Duration(milliseconds: 600), value: 0, vsync: this);

    animation = new Tween(begin: 0.0, end: 40.0).animate(_controller)
      ..addListener(() {
        setState(() {
          print("helper animation setState");
          if (animation.status == AnimationStatus.completed) {
            _controller.reverse();
          } else if (animation.status == AnimationStatus.dismissed) {
            _controller.forward();
          }
        });
      });

    shareIcon = new ShareIcon();
    homepageHeader = new HomepageHeader(type: widget.type);
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        widget.scrollCallback(0.0);
        shareIcon.refresh(0.0);
      }

      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        widget.scrollCallback(1.0);
        shareIcon.refresh(1.0);
      }

      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        widget.scrollCallback(1.0);
        shareIcon.refresh(1.0);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void loadAsync() {
    if (!FontUtil.isReady()) {
      FontUtil.getInstance().then((FontUtil font) {
        print('waiting for FontUtil init complete');
      });
    }
  }

  Future<bool> _readHelper() async {
    await SpUtil.getInstance();
    bool showed = SpUtil.getBool(SPConstant.SP_HELPER_SHOWED);

    if (showed == null) {
      showed = false;
    }

    return showed;
  }

  void _saveHelper() async {
    await SpUtil.getInstance();
    SpUtil.putBool(SPConstant.SP_HELPER_SHOWED, true);
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: new EdgeInsets.fromLTRB(
            0.0, MediaQueryData.fromWindow(window).padding.top, 0.0, 0.0),
        decoration: new BoxDecoration(
            image: new DecorationImage(
                fit: BoxFit.fill,
                image: new AssetImage(FontUtil.getTopBarBg()))),
        child: new Stack(
          children: <Widget>[
            _getPage(),
            shareIcon,
            homepageHeader,
            Offstage(
                offstage: _helperVisibility,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      print("helper tap setState");
                      _helperVisibility = true;
                      _controller.stop();
                    });
                  },
                  child: Container(
                    padding:
                        new EdgeInsets.fromLTRB(0.0, 0.0, animation.value, 0.0),
                    decoration: new BoxDecoration(
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image:
                                new AssetImage('assets/images/helper_bg.png'))),
                    height: window.physicalSize.height -
                        MediaQueryData.fromWindow(window).padding.top,
                    width: window.physicalSize.width,
                    child: new Image.asset('assets/images/helper.png'),
                  ),
                )),
          ],
        ));
  }

  StatefulWidget _getPage() {
    switch (widget.type) {
      case CommonConstant.PAGE_CRITIC:
        return new CriticPage(
            scrollController: scrollController,
            scrollToNextPageCallback: _homepageHeaderCallback);
        break;
      case CommonConstant.PAGE_NOVEL:
        return new NovelPage(
            scrollController: scrollController,
            scrollToNextPageCallback: _homepageHeaderCallback);
        break;
      case CommonConstant.PAGE_DIAGRAM:
        return new DiagramPage(
            scrollController: scrollController,
            scrollToNextPageCallback: _homepageHeaderCallback);
        break;
      default:
        return new CriticPage(scrollController: scrollController);
    }
  }

  _homepageHeaderCallback(ListItem item) {
    homepageHeader.refresh(item.publishtime);
    shareIcon.setShareData(item);
  }
}
