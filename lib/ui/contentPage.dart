import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_tenge/constant/common.dart';
import 'package:flutter_tenge/ui/critic.dart';
import 'package:flutter_tenge/ui/diagram.dart';
import 'package:flutter_tenge/ui/novel.dart';

typedef ScrollToBottomCallback = void Function();

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

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
//      print("listener pixels: " + scrollController.position.pixels.toString() + " max: " + scrollController.position.maxScrollExtent.toString() + " equal: " + (scrollController.position.pixels ==
//          scrollController.position.maxScrollExtent).toString());
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print("call scrollToBottomCallback");
        widget.scrollToBottomCallback();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: new EdgeInsets.fromLTRB(
            0.0, MediaQueryData
            .fromWindow(window)
            .padding
            .top, 0.0, 0.0),
        decoration: new BoxDecoration(
            color: Color(0xE6F4F4F4),
            image: new DecorationImage(
                image: new AssetImage("assets/images/topbar.png"))),
        child: new Stack(
          children: <Widget>[
            _getPage(),
            new Container(
              height: 44.0,
              color: Color(0xE6F4F4F4),
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Image.asset('assets/images/logo_critic.png',
                      height: 44, width: 107),
                  new Expanded(
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Image.asset('assets/images/date_0.png',
                              height: 44, width: 20),
                          new Image.asset('assets/images/date_1.png',
                              height: 44, width: 20),
                          new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Image.asset('assets/images/week_1.png',
                                  height: 20, width: 42),
                              new Row(
                                children: <Widget>[
                                  new Image.asset(
                                      'assets/images/month_divide.png',
                                      height: 24, width: 15),
                                  new Image.asset('assets/images/month_12.png',
                                      height: 24, width: 27),
                                ],
                              )
                            ],
                          )
                        ],
                      ))
                ],
              ),
            ),
          ],
        ));
  }

  StatefulWidget _getPage() {
    switch (widget.type) {
      case CommonConstant.PAGE_CRITIC:
        return new CriticPage(scrollController: scrollController);
        break;
      case CommonConstant.PAGE_NOVEL:
        return new NovelPage(scrollController: scrollController);
        break;
      case CommonConstant.PAGE_DIAGRAM:
        return new DiagramPage(scrollController: scrollController);
        break;
      default:
        return new CriticPage(scrollController: scrollController);
    }
  }
}
