import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_tenge/bean/ListBean.dart';
import 'package:flutter_tenge/constant/common.dart';
import 'package:flutter_tenge/ui/callback.dart';
import 'package:flutter_tenge/ui/critic.dart';
import 'package:flutter_tenge/ui/diagram.dart';
import 'package:flutter_tenge/ui/header.dart';
import 'package:flutter_tenge/ui/novel.dart';
import 'package:flutter_tenge/ui/shareicon.dart';
import 'package:flutter_tenge/utils/FontUtil.dart';

class ContentPage extends StatefulWidget {
  ScrollCallback scrollCallback;

  ContentPage({this.type, this.scrollCallback});

  String type = CommonConstant.PAGE_CRITIC;

  @override
  State<StatefulWidget> createState() {
    return new ContentPageState();
  }
}

class ContentPageState extends State<ContentPage> {
  ScrollController scrollController = new ScrollController();
  HomepageHeader homepageHeader;
  ShareIcon shareIcon;

  @override
  void initState() {
    super.initState();
    print('contentPage init begin');
    loadAsync();
    print('contentPage init complete');
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

  void loadAsync() {
    if (!FontUtil.isReady()) {
      FontUtil.getInstance().then((FontUtil font) {
        print('waiting for FontUtil init complete');
      });
    }
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
