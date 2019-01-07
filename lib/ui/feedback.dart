import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tenge/ui/title.dart';
import 'package:flutter_tenge/utils/FontUtil.dart';
import 'package:fluttertoast/fluttertoast.dart';


class FeedbackPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Container(
        child: new Column(
          children: <Widget>[
            new TitleBar(
                title: '意见反馈',
                pressed: () {
                  Navigator.of(context).pop();
                }),
            new Container(
                margin: new EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
                alignment: Alignment.topCenter,
                child: new Text(
                  '加微信或QQ反馈问题，我们会第一时间为你解决。',
                  style: new TextStyle(
                      fontSize: 12.0, color: FontUtil.getFeedbackFontColor()),
                )),
            new Container(
              margin: new EdgeInsets.fromLTRB(0.0, 80.0, 0.0, 0.0),
              child: new RaisedButton(
                padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                color: Colors.white,
                elevation: 0,
                highlightElevation: 0,
                disabledElevation: 0,
                onPressed: _copyWechatToClipboard,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      child: new Image.asset(
                        FontUtil.getWechatIcon(),
                        height: 20,
                        width: 20,
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                      child: new Text(
                        '微信公众账号: ',
                        style: new TextStyle(
                            fontSize: 12.0,
                            color: FontUtil.getFeedbackFontColor()),
                      ),
                    ),
                    new Container(
                      child: new Text(
                        'shigeten',
                        style: new TextStyle(
                          fontSize: 12.0,
                          color: Color(0xFF10B0FB),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            new Container(
              margin: new EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
              child: new RaisedButton(
                padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                color: Colors.white,
                elevation: 0,
                highlightElevation: 0,
                disabledElevation: 0,
                onPressed: _copyQQToClipboard,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Container(
                      child: new Image.asset(
                        FontUtil.getQQIcon(),
                        height: 20,
                        width: 20,
                      ),
                    ),
                    new Container(
                      margin: new EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                      child: new Text(
                        'QQ号: ',
                        style: new TextStyle(
                            fontSize: 12.0,
                            color: FontUtil.getFeedbackFontColor()),
                      ),
                    ),
                    new Container(
                      child: new Text(
                        '551608331',
                        style: new TextStyle(
                          fontSize: 12.0,
                          color: Color(0xFF10B0FB),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _copyWechatToClipboard() {
    Clipboard.setData(new ClipboardData(text: 'shigeten'));
    Fluttertoast.showToast(
        msg: "已为您复制“shigeten”到剪贴板。",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
    );
  }

  _copyQQToClipboard() {
    Clipboard.setData(new ClipboardData(text: '551608331'));
    Fluttertoast.showToast(
        msg: "已为您复制“551608331”到剪贴板。",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
    );
  }
}
