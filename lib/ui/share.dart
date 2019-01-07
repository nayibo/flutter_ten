import 'package:flutter/material.dart';
import 'package:flutter_tenge/bean/Favorite.dart';
import 'package:flutter_tenge/bean/ListBean.dart';
import 'package:flutter_tenge/constant/common.dart';
import 'package:flutter_tenge/utils/FontUtil.dart';
import 'package:flutter_tenge/utils/ShareUtil.dart';
import 'package:flutter_tenge/utils/sqflite.dart';
//import 'package:flutter_qq/flutter_qq.dart';

class ShareDialog extends Dialog {
  final ListItem listItem;
  bool isFavorite = false;

  ShareDialog({Key key, @required this.listItem, @required this.isFavorite}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        shareTypeUp: CommonConstant.SHARE_TYPE_FAVORITE,
                        pressUp: _favorite,
                        shareTypeDown: CommonConstant.SHARE_TYPE_WEIBO,
                        pressDown: null,
                        isFavorite: isFavorite),
                  ),
                  new Expanded(
                    flex: 1,
                    child: new ShareItemWidget(
                        shareTypeUp: CommonConstant.SHARE_TYPE_WEIXIN,
                        pressUp: null,
                        shareTypeDown: CommonConstant.SHARE_TYPE_QQ,
                        pressDown: null,
                        isFavorite: false),
                  ),
                  new Expanded(
                    flex: 1,
                    child: new ShareItemWidget(
                        shareTypeUp: CommonConstant.SHARE_TYPE_PENGYOUQUAN,
                        pressUp: null,
                        shareTypeDown: CommonConstant.SHARE_TYPE_QQZONE,
                        pressDown: null,
                        isFavorite: false),
                  ),
                ],
              ),
            ],
          )),
    );
  }

  _favorite() {
    var dbHelper = DBHelper();
    FavoriteBean favoriteBean = new FavoriteBean(
        id: listItem.id,
        title: listItem.title,
        type: listItem.type,
        summary: listItem.summary,
        publishtime: listItem.publishtime);
    dbHelper.insertFavorite(favoriteBean);
    dbHelper.getFavoriteList();
  }

  _shareTimeLine() {
    ShareUtil.wechatShareWebpageTimeLine(
        ShareUtil.getShareUrl(listItem.type, listItem.id),
        'assets://assets/images/share_icon.png',
        listItem.summary,
        listItem.title);
  }

  _shareSession() {
    ShareUtil.wechatShareWebpageSession(
        ShareUtil.getShareUrl(listItem.type, listItem.id),
        'assets://assets/images/share_icon.png',
        listItem.summary,
        listItem.title);
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
}

class ShareItemWidget extends StatefulWidget {
  String shareTypeUp;
  String shareTypeDown;
  VoidCallback pressUp;
  VoidCallback pressDown;
  bool isFavorite;

  ShareItemWidget(
      {this.shareTypeUp,
      this.shareTypeDown,
      this.pressUp,
      this.pressDown,
      this.isFavorite});

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
    if (widget.shareTypeUp == CommonConstant.SHARE_TYPE_WEIXIN) {
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
                icon: new Image.asset(
                    FontUtil.getShareIcon(
                        widget.shareTypeUp, widget.isFavorite),
                    height: 60.0,
                    width: 60.0),
                onPressed: widget.pressUp),
          ),
          new Container(
            margin: new EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
            child: new IconButton(
                iconSize: 60.0,
                icon: new Image.asset(
                    FontUtil.getShareIcon(
                        widget.shareTypeDown, widget.isFavorite),
                    height: 60.0,
                    width: 60.0),
                onPressed: widget.pressDown),
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
