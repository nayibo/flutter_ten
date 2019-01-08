import 'package:flutter/material.dart';
import 'package:flutter_tenge/constant/font.dart';
import 'package:flutter_tenge/ui/title.dart';
import 'package:flutter_tenge/utils/FontUtil.dart';

class FontSettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new FontSettingPageState();
  }
}

class FontSettingPageState extends State<FontSettingPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: FontUtil.getMainBgColor(),
      body: new Container(
        child: new Column(
          children: <Widget>[
            new TitleBar(
                title: '字体设置',
                pressed: () {
                  Navigator.of(context).pop();
                }),
            new Container(
              alignment: Alignment.topCenter,
              height: 250.0,
              margin: new EdgeInsets.fromLTRB(16.0, 75.0, 16.0, 0.0),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    child: new Text(
                      '我已经老了，在人来人往的大厅，有一位老人他向我走来，他说我认识你，那时的你还很年轻，美丽，你的身边有许许多多的追求者，不过跟那时相比，我更喜欢现在你这经历了沧桑的容颜？',
                      style: FontUtil.getContentFont(),
                    ),
                  ),
                  new Container(
                    alignment: Alignment.topRight,
                    margin: new EdgeInsets.fromLTRB(16.0, 5.0, 16.0, 0.0),
                    child: new Text(
                      '—《情人》',
                      style: FontUtil.getContentFont(),
                    ),
                  ),
                ],
              ),
            ),
            new Container(
              margin: new EdgeInsets.fromLTRB(26.0, 60.0, 26.0, 0.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  new Expanded(
                    flex: 1,
                    child: new RaisedButton(
                      padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                      color: FontUtil.getMainBgColor(),
                      elevation: 0,
                      highlightElevation: 0,
                      disabledElevation: 0,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onPressed: _smallClick,
                      child: new Column(
                        children: <Widget>[
                          new Image.asset(
                            FontUtil.getFontSizeSmallIcon(),
                            height: 25.0,
                            width: 25.0,
                          ),
                          new Container(
                            margin:
                                new EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                            child: new Text('眼神儿好',
                                style: new TextStyle(
                                    fontSize: 12.0,
                                    color: FontUtil.getFontNormalSizeColor())),
                          )
                        ],
                      ),
                    ),
                  ),
                  new Expanded(
                    flex: 1,
                    child: new RaisedButton(
                      padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                      color: FontUtil.getMainBgColor(),
                      elevation: 0,
                      highlightElevation: 0,
                      disabledElevation: 0,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onPressed: _midClick,
                      child: new Column(
                        children: <Widget>[
                          new Image.asset(
                            FontUtil.getFontSizeMidIcon(),
                            height: 31.0,
                            width: 31.0,
                          ),
                          new Container(
                            margin: new EdgeInsets.fromLTRB(0.0, 7.0, 0.0, 0.0),
                            child: new Text('不大不小',
                                style: new TextStyle(
                                    fontSize: 12.0,
                                    color: FontUtil.getFontNormalSizeColor())),
                          )
                        ],
                      ),
                    ),
                  ),
                  new Expanded(
                    flex: 1,
                    child: new RaisedButton(
                      padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                      color: FontUtil.getMainBgColor(),
                      elevation: 0,
                      highlightElevation: 0,
                      disabledElevation: 0,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onPressed: _bigClick,
                      child: new Column(
                        children: <Widget>[
                          new Image.asset(
                            FontUtil.getFontSizeBigIcon(),
                            height: 37.0,
                            width: 37.0,
                          ),
                          new Container(
                            margin: new EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 0.0),
                            child: new Text('我要大大',
                                style: new TextStyle(
                                    fontSize: 12.0,
                                    color: FontUtil.getFontNormalSizeColor())),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _smallClick() {
    setState(() {
      FontUtil.setFontSizeMode(FontConstant.FONT_SMALL);
    });
  }

  _midClick() {
    setState(() {
      FontUtil.setFontSizeMode(FontConstant.FONT_MID);
    });
  }

  _bigClick() {
    setState(() {
      FontUtil.setFontSizeMode(FontConstant.FONT_BIG);
    });
  }
}
