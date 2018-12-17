import 'package:flutter/material.dart';
import 'package:tenge_flutter/bean/ListBean.dart';
import 'package:tenge_flutter/utils/ShareUtil.dart';
import 'package:flutter_qq/flutter_qq.dart';

class ShareDialog extends Dialog {
  final int currentIndex;
  final ListBean listBean;

  ShareDialog({Key key, @required this.currentIndex, @required this.listBean}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _shareTimeLine() {
      ShareUtil.wechatShareWebpageTimeLine(
          ShareUtil.getShareUrl(listBean.result[currentIndex].type,
              listBean.result[currentIndex].id),
          'assets://assets/images/share_icon.png',
          listBean.result[currentIndex].summary,
          listBean.result[currentIndex].title);
    }

    _shareSession() {
      ShareUtil.wechatShareWebpageSession(
          ShareUtil.getShareUrl(listBean.result[currentIndex].type,
              listBean.result[currentIndex].id),
          'assets://assets/images/share_icon.png',
          listBean.result[currentIndex].summary,
          listBean.result[currentIndex].title);
    }

    Future<Null> _shareQQ() async {
      ShareQQContent shareContent = new ShareQQContent(
          shareType: SHARE_TO_QQ_TYPE.IMAGE,
          title: listBean.result[currentIndex].title,
          targetUrl: ShareUtil.getShareUrl(listBean.result[currentIndex].type,
              listBean.result[currentIndex].id),
          summary: listBean.result[currentIndex].summary,
//          imageLocalUrl: 'assets://assets/images/share_icon.png'
      );
      try {
        var qqResult = await FlutterQq.shareToQQ(shareContent);
        var output;
        if (qqResult.code == 0) {
          output = "分享成功";
        } else if (qqResult.code == 1) {
          output = "分享失败" + qqResult.message;
        } else {
          output = "用户取消";
        }
      } catch (error) {
        print("flutter_plugin_qq_example:" + error.toString());

      }
    }

    Future<Null> _shareZone() async {
      ShareQzoneContent shareContent = new ShareQzoneContent(
        shareType: SHARE_TO_QZONE_TYPE.IMAGE_TEXT,
        title: listBean.result[currentIndex].title,
        targetUrl: ShareUtil.getShareUrl(listBean.result[currentIndex].type,
            listBean.result[currentIndex].id),
        summary: listBean.result[currentIndex].summary,
        imageUrl: "http://inews.gtimg.com/newsapp_bt/0/876781763/1000",
      );
      try {
        var qqResult = await FlutterQq.shareToQzone(shareContent);
        var output;
        if (qqResult.code == 0) {
          output = "分享成功";
        } else if (qqResult.code == 1) {
          output = "分享失败" + qqResult.message;
        } else {
          output = "用户取消";
        }
      } catch (error) {
        print("flutter_plugin_qq_example:" + error.toString());
      }
    }

    return new Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: new Center(
        //保证控件居中效果
        child: new SizedBox(
          width: 240.0,
          height: 240.0,
          child: new Container(
            decoration: ShapeDecoration(
              color: Color(0xffffffff),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new RaisedButton(
                  child: new Container(
                    child: new Text("微信分享"),
                  ),
                  onPressed: _shareSession,
                ),
                new RaisedButton(
                  child: new Text('朋友圈分享'),
                  onPressed: _shareTimeLine,
                ),
                new RaisedButton(
                  child: new Container(
                    child: new Text("QQ分享"),
                  ),
                  onPressed: _shareQQ,
                ),
                new RaisedButton(
                  child: new Text('QQ ZONE分享'),
                  onPressed: _shareZone,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
