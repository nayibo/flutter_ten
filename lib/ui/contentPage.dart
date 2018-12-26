import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_tenge/constant/common.dart';
import 'package:flutter_tenge/ui/callback.dart';
import 'package:flutter_tenge/ui/critic.dart';
import 'package:flutter_tenge/ui/diagram.dart';
import 'package:flutter_tenge/ui/header.dart';
import 'package:flutter_tenge/ui/novel.dart';
import 'package:flutter_tenge/utils/FontUtil.dart';

class ContentPage extends StatefulWidget {
  ScrollToBottomCallback scrollToBottomCallback;

  ContentPage({this.type, this.scrollToBottomCallback});

  String type = CommonConstant.PAGE_CRITIC;

  @override
  State<StatefulWidget> createState() {
    return new ContentPageState();
  }
}

class ContentPageState extends State<ContentPage> {
  ScrollController scrollController = new ScrollController();
  HomepageHeader homepageHeader;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        widget.scrollToBottomCallback();
      }
    });
    homepageHeader = new HomepageHeader(type: widget.type);
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: new EdgeInsets.fromLTRB(
            0.0, MediaQueryData.fromWindow(window).padding.top, 0.0, 0.0),
        decoration: new BoxDecoration(
            color: Color(0xE6F4F4F4),
            image: new DecorationImage(
                image: new AssetImage("assets/images/topbar.png"))),
        child: new Stack(
          children: <Widget>[
            _getPage(),
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

  _homepageHeaderCallback(int publishtime) {
    homepageHeader.refresh(publishtime);
  }
}
