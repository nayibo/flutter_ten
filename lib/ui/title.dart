import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_tenge/utils/FontUtil.dart';

class TitleBar extends StatefulWidget {
  VoidCallback pressed;
  String title;

  TitleBar({@required this.pressed, @required this.title});

  @override
  State<StatefulWidget> createState() {
    return new TitleBarState();
  }
}

class TitleBarState extends State<TitleBar> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: FontUtil.getTitleBarBackgroundColor(),
      padding: new EdgeInsets.fromLTRB(
          0.0, MediaQueryData.fromWindow(window).padding.top, 0.0, 0.0),
      height: MediaQueryData.fromWindow(window).padding.top + 44.0,
      child: new Row(
        children: <Widget>[
          new IconButton(
              icon: new Image.asset(FontUtil.getTitleBarBackIcon(),
                  height: 20.0, width: 20.0),
              onPressed: widget.pressed),
          new Expanded(
            child: new Container(
              padding: new EdgeInsets.fromLTRB(0.0, 0.0, 35.0, 0.0),
              alignment: Alignment.center,
              child: new Text(widget.title,
                  style: new TextStyle(
                      fontSize: 18.0, color: FontUtil.getTitleColor())),
            ),
          ),
        ],
      ),
    );
  }
}
