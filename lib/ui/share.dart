import 'package:fake_tencent/fake_tencent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tenge/bean/Favorite.dart';
import 'package:flutter_tenge/bean/ListBean.dart';
import 'package:flutter_tenge/constant/common.dart';
import 'package:flutter_tenge/utils/FavoriteUtil.dart';
import 'package:flutter_tenge/utils/FontUtil.dart';
import 'package:flutter_tenge/utils/ShareUtil.dart';

class ShareDialog extends Dialog {
  final ListItem listItem;
  bool isFavorite = false;

  ShareDialog({Key key, @required this.listItem, @required this.isFavorite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Material(
      //创建透明层
      type: MaterialType.transparency, //透明类型
      child: new GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
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
                      style:
                          new TextStyle(fontSize: 18.0, color: Colors.white)),
                  alignment: Alignment(0.0, 0.3),
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Expanded(
                      flex: 1,
                      child: new ShareItemWidget(
                          listItem: listItem,
                          shareTypeUp: CommonConstant.SHARE_TYPE_FAVORITE,
                          pressUp: null,
                          shareTypeDown: CommonConstant.SHARE_TYPE_WEIBO,
                          pressDown: null,
                          isFavorite: isFavorite),
                    ),
                    new Expanded(
                      flex: 1,
                      child: new ShareItemWidget(
                          listItem: listItem,
                          shareTypeUp: CommonConstant.SHARE_TYPE_WEIXIN,
                          pressUp: null,
                          shareTypeDown: CommonConstant.SHARE_TYPE_QQ,
                          pressDown: null,
                          isFavorite: false),
                    ),
                    new Expanded(
                      flex: 1,
                      child: new ShareItemWidget(
                          listItem: listItem,
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
      ),
    );
  }
}

class ShareItemWidget extends StatefulWidget {
  String shareTypeUp;
  String shareTypeDown;
  VoidCallback pressUp;
  VoidCallback pressDown;
  bool isFavorite;
  ListItem listItem;

  ShareItemWidget(
      {this.shareTypeUp,
      this.shareTypeDown,
      this.pressUp,
      this.pressDown,
      this.isFavorite,
      this.listItem});

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
  bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
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
                    FontUtil.getShareIcon(widget.shareTypeUp, _isFavorite),
                    height: 60.0,
                    width: 60.0),
                onPressed: _pressUpItem),
          ),
          new Container(
            margin: new EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
            child: new IconButton(
                iconSize: 60.0,
                icon: new Image.asset(
                    FontUtil.getShareIcon(widget.shareTypeDown, _isFavorite),
                    height: 60.0,
                    width: 60.0),
                onPressed: _pressDownItem),
          ),
        ],
      ),
    );
  }

  _pressUpItem() async {
    print("_pressUpItem");
    if (widget.shareTypeUp == CommonConstant.SHARE_TYPE_FAVORITE) {
      FavoriteUtil.getInstance()
          .favorite(widget.listItem)
          .then(((List<FavoriteBean> favList) {
        setState(() {
          FavoriteUtil.getInstance().setFavoriteListData(favList);
          _isFavorite = FavoriteUtil.getInstance()
              .isFavorite(widget.listItem.id, widget.listItem.type);
          print("_pressUpItem setstate: " +
              favList.length.toString() +
              "  " +
              _isFavorite.toString());
        });
      }));
    }

    if (widget.shareTypeUp == CommonConstant.SHARE_TYPE_WEIXIN) {
      print("_pressUpItem SHARE_TYPE_WEIXIN");
      WechatShareUtil.wechatShareWebpageSession(
          WechatShareUtil.getShareUrl(1, 100052),
          'assets://assets/images/share_icon.png',
          "summary",
          "title");
    }

    if (widget.shareTypeUp == CommonConstant.SHARE_TYPE_PENGYOUQUAN) {
      print("_pressUpItem SHARE_TYPE_PENGYOUQUAN");
      WechatShareUtil.wechatShareWebpageTimeLine(
          WechatShareUtil.getShareUrl(1, 100052),
          'assets://assets/images/share_icon.png',
          "summary",
          "title");
    }
  }

  _pressDownItem() async {
    print("_pressDownItem : " + widget.shareTypeDown);

    if (widget.shareTypeDown == CommonConstant.SHARE_TYPE_QQ) {
      QQShareUtil.getInstance();
      QQShareUtil.shareQQUrl(_listenShareUrl, widget.listItem);
    }

    if (widget.shareTypeDown == CommonConstant.SHARE_TYPE_QQZONE) {
      QQShareUtil.getInstance();
      QQShareUtil.shareQQZONEUrl(_listenShareUrl, widget.listItem);
    }

    if (widget.shareTypeDown == CommonConstant.SHARE_TYPE_WEIBO) {

    }
  }

  void _listenShareUrl(FakeTencentShareResp resp) {
    String content = 'share: ${resp.errorCode} - ${resp.errorMsg}';
    print('分享' + content);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
