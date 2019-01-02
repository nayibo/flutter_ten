import 'package:flutter/material.dart';
import 'package:flutter_tenge/bean/ListBean.dart';
import 'package:flutter_tenge/constant/common.dart';
import 'package:flutter_tenge/utils/FontUtil.dart';
import 'package:flutter_tenge/utils/ShareUtil.dart';
//import 'package:flutter_qq/flutter_qq.dart';

class ShareDialog extends Dialog {
  final int currentIndex;
  final ListBean listBean;

  ShareDialog({Key key, @required this.currentIndex, @required this.listBean})
      : super(key: key);

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

//    Future<Null> _shareQQ() async {
//      ShareQQContent shareContent = new ShareQQContent(
//          shareType: SHARE_TO_QQ_TYPE.IMAGE,
//          title: listBean.result[currentIndex].title,
//          targetUrl: ShareUtil.getShareUrl(listBean.result[currentIndex].type,
//              listBean.result[currentIndex].id),
//          summary: listBean.result[currentIndex].summary,
////          imageLocalUrl: 'assets://assets/images/share_icon.png'
//      );
//      try {
//        var qqResult = await FlutterQq.shareToQQ(shareContent);
//        var output;
//        if (qqResult.code == 0) {
//          output = "分享成功";
//        } else if (qqResult.code == 1) {
//          output = "分享失败" + qqResult.message;
//        } else {
//          output = "用户取消";
//        }
//      } catch (error) {
//        print("flutter_plugin_qq_example:" + error.toString());
//
//      }
//    }
//
//    Future<Null> _shareZone() async {
//      ShareQzoneContent shareContent = new ShareQzoneContent(
//        shareType: SHARE_TO_QZONE_TYPE.IMAGE_TEXT,
//        title: listBean.result[currentIndex].title,
//        targetUrl: ShareUtil.getShareUrl(listBean.result[currentIndex].type,
//            listBean.result[currentIndex].id),
//        summary: listBean.result[currentIndex].summary,
//        imageUrl: "http://inews.gtimg.com/newsapp_bt/0/876781763/1000",
//      );
//      try {
//        var qqResult = await FlutterQq.shareToQzone(shareContent);
//        var output;
//        if (qqResult.code == 0) {
//          output = "分享成功";
//        } else if (qqResult.code == 1) {
//          output = "分享失败" + qqResult.message;
//        } else {
//          output = "用户取消";
//        }
//      } catch (error) {
//        print("flutter_plugin_qq_example:" + error.toString());
//      }
//    }

    return new Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: new Container(
          margin: new EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 100.0),
          decoration: ShapeDecoration(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
          ),
          child: new Stack(
            children: <Widget>[
              new Container(
                margin: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 70.0),
                child: new Text("分享至",
                    style: new TextStyle(fontSize: 18.0, color: Colors.white)),
                alignment: Alignment(0.0, 0.3),
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Expanded(
                    flex: 1,
                    child: new ShareItemWidget(
                        shareTypeDown: CommonConstant.SHARE_TYPE_FAVORITE,
                        shareTypeUp: CommonConstant.SHARE_TYPE_WEIBO),
                  ),
                  new Expanded(
                    flex: 1,
                    child: new ShareItemWidget(
                        shareTypeDown: CommonConstant.SHARE_TYPE_WEIXIN,
                        shareTypeUp: CommonConstant.SHARE_TYPE_QQ),
                  ),
                  new Expanded(
                    flex: 1,
                    child: new ShareItemWidget(
                        shareTypeDown: CommonConstant.SHARE_TYPE_PENGYOUQUAN,
                        shareTypeUp: CommonConstant.SHARE_TYPE_QQZONE),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}

class ShareItemWidget extends StatefulWidget {
  String shareTypeUp;
  String shareTypeDown;

  ShareItemWidget({this.shareTypeUp, this.shareTypeDown});

  @override
  State<StatefulWidget> createState() {
    return new ShareItemWidgetState();
  }
}

class ShareItemWidgetState extends State<ShareItemWidget>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController _controller;
  double _alignmentY = 2.5;

  @override
  void initState() {
    super.initState();
    if (widget.shareTypeUp == CommonConstant.SHARE_TYPE_QQ) {
      _controller = new AnimationController(
          duration: const Duration(milliseconds: 800),
          value: 0.01,
          vsync: this);
    } else {
      _controller = new AnimationController(
          duration: const Duration(milliseconds: 1000),
          value: 0.01,
          vsync: this);
    }
    animation = new Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _alignmentY = animation.value * animation.value * 3.25 -
              4.85 * animation.value +
              2.5;
          print("animation value: " + animation.value.toString());
        });
      });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment(0.0, _alignmentY),
      child: new Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Container(
            child: new IconButton(
                iconSize: 60.0,
                icon: new Image.asset(FontUtil.getShareIcon(widget.shareTypeUp),
                    height: 60.0, width: 60.0),
                onPressed: null),
          ),
          new Container(
            margin: new EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
            child: new IconButton(
                iconSize: 60.0,
                icon: new Image.asset(
                    FontUtil.getShareIcon(widget.shareTypeDown),
                    height: 60.0,
                    width: 60.0),
                onPressed: null),
          ),
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
