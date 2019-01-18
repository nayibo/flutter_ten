import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_tenge/bean/CriticBean.dart';
import 'package:flutter_tenge/bean/ListBean.dart';
import 'package:flutter_tenge/network/NetworkUtils.dart';
import 'package:flutter_tenge/ui/callback.dart';
import 'package:flutter_tenge/utils/FontUtil.dart';
import 'package:transparent_image/transparent_image.dart';

class CriticPage extends StatefulWidget {
  ScrollController scrollController;
  ScrollToNextPageCallback scrollToNextPageCallback;

  CriticPage({this.scrollController, this.scrollToNextPageCallback});

  @override
  State<StatefulWidget> createState() {
    print("CriticPage build");
    return new CriticPageState();
  }
}

class CriticPageState extends State<CriticPage> {
  ListBean _listBean;
  int _currentPageIndex = 0;
  var _pageController = new PageController(initialPage: 0);
  bool _showLoading = true;

  @override
  void initState() {
    super.initState();
    _getList();
  }

  _getCriticBody() {
    if (_showLoading) {
      return _getLoadingWidget();
    } else {
      return _getPageViewWidget();
    }
  }

  Widget _getLoadingWidget() {
    return new Center(child: new CircularProgressIndicator());
  }

  Widget _getPageViewWidget() {
    return new Stack(
      children: <Widget>[
        new Container(
          color: FontUtil.getMainBgColor(),
          child: new PageView.builder(
            onPageChanged: _pageChange,
            controller: _pageController,
            itemBuilder: (BuildContext context, int index) {
              print("CriticPageState itemBuilder");
              return _buildItem(context, index);
            },
            itemCount: _listBean == null
                ? 0
                : _listBean.result == null ? 0 : _listBean.result.length,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    print("CriticPageState build");
    return _getCriticBody();
  }

  _pageChange(int index) {
    if (_currentPageIndex != index) {
      _currentPageIndex = index;
      widget.scrollToNextPageCallback(_listBean.result[_currentPageIndex]);
    }
  }

  Widget _buildItem(BuildContext context, int index) {
    if (_listBean != null &&
        _listBean.result != null &&
        _listBean.result.length > index) {
      return new CriticItem(
          id: _listBean.result[index].id,
          scrollController: widget.scrollController);
    } else {
      return null;
    }
  }

  _getList() async {
    NetworkUtils.get("http://api.shigeten.net/api/Critic/GetCriticList",
        (data) {
      if (data != null) {
        _showLoading = false;
        setState(() {
          print("_getList setstate");
          _listBean = new ListBean.fromJson(data);
          if (_listBean.result.length > 0) {
            widget.scrollToNextPageCallback(_listBean.result[0]);
          }
        });
      }
    }, errorCallback: (e) {
      _showLoading = false;
      print("_getList network error: $e");
    });
  }
}

class CriticItem extends StatefulWidget {
  ScrollController scrollController;

  CriticItem({Key key, this.id, this.scrollController}) : super(key: key);
  final int id;

  @override
  State<StatefulWidget> createState() {
    return new CriticItemState(id: id);
  }
}

class CriticItemState extends State<CriticItem> {
  CriticItemState({this.id}) {
//    _getCritic(id);
  }

  bool _showLoading = true;
  CriticBean _critic;
  final int id;

  @override
  void initState() {
    super.initState();
    _getCritic(id);
  }

  _getItemBody() {
    if (_showLoading) {
      return _getLoadingWidget();
    } else {
      return _getItemWidget();
    }
  }

  Widget _getLoadingWidget() {
    return new Center(child: new CircularProgressIndicator());
  }

  Widget _getItemWidget() {
    return ListView.builder(
        controller: widget.scrollController,
        padding: const EdgeInsets.fromLTRB(16.0, 44.0, 16.0, 50.0),
        itemCount: 19,
        itemBuilder: (context, index) {
          return new CriticListViewItem(data: _critic, index: index);
        });
  }

  @override
  Widget build(BuildContext context) {
    return _getItemBody();
  }

  _getCritic(int id) async {
    if (id == null) {
      return;
    }
    Map<String, String> params = new Map();
    params['id'] = id.toString();
    NetworkUtils.get(
        "http://api.shigeten.net/api/Critic/GetCriticContent",
        (data) {
          _showLoading = false;
          if (data != null) {
            setState(() {
              print("_getCritic setstate");
              _critic = new CriticBean.fromJson(data);
            });
          }
        },
        params: params,
        errorCallback: (e) {
          _showLoading = false;
          print("_getCritic network error: $e");
        });
  }
}

class CriticListViewItem extends StatefulWidget {
  final CriticBean data;
  final int index;

  CriticListViewItem({this.data, this.index});

  @override
  State<StatefulWidget> createState() {
    switch (index) {
      case 0:
        return new ListItemStateHeadImage(url: data.imageforplay);
      case 1:
        return new ListItemStateTitle(title: data.title);
      case 2:
        return new ListItemStateAuthor(data: data);
      case 3:
        return new ListItemStateText1(data: data);
      case 4:
        return new ListItemStateDivider();
      case 5:
        return new ListItemStateBrief(data: data);
      case 6:
        return new ListItemStateText2(data: data);
      case 7:
        return new ListItemStateDivider2();
      case 8:
        return new ListItemStateRealTitle(data: data);
      case 9:
        return new ListItemStateImage2(data: data);
      case 10:
        return new ListItemStateText3(data: data);
      case 11:
        return new ListItemStateText4(data: data);
      case 12:
        return new ListItemStateText5(data: data);
      case 13:
        return new ListItemStateImage3(data: data);
      case 14:
        return new ListItemStateImage4(data: data);
      case 15:
        return new ListItemStateImage5(data: data);
      case 16:
        return new ListItemStateDivider3();
      case 17:
        return new ListItemStateAuthorBelow(data: data);
      case 18:
        return new ListItemStateAuthorBrief(data: data);
    }

    return new ListItemStateTitle(title: data.title);
  }
}

class ListItemStateHeadImage extends State<CriticListViewItem> {
  String url;

  ListItemStateHeadImage({this.url});

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: "http://images.shigeten.net/" + url,
        height:
            (window.physicalSize.width * 9) / (16 * window.devicePixelRatio),
        width: window.physicalSize.width / window.devicePixelRatio,
        fit: BoxFit.cover,
      ),
    );
  }
}

class ListItemStateTitle extends State<CriticListViewItem> {
  String title;

  ListItemStateTitle({this.title});

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 0),
      child: new Text(title, style: FontUtil.getContentTitleFont()),
    );
  }
}

class ListItemStateAuthor extends State<CriticListViewItem> {
  CriticBean data;

  ListItemStateAuthor({this.data});

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Text(data == null ? 'empty' : '作者: ' + data.author,
            style: FontUtil.getAuthorFont()),
        new Container(
          height: 12.0,
          width: 1.0,
          color: FontUtil.getAuthorVerticalLineColor(),
          margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 4.0),
        ),
        new Text(data == null ? 'empty' : '阅读量: ' + data.times.toString(),
            style: FontUtil.getAuthorFont())
      ],
    );
  }
}

class ListItemStateText1 extends State<CriticListViewItem> {
  CriticBean data;

  ListItemStateText1({this.data});

  @override
  Widget build(BuildContext context) {
    return new Container(
        width: window.physicalSize.width,
        margin: const EdgeInsets.fromLTRB(0, 35.0, 0, 0),
        padding: const EdgeInsets.fromLTRB(17.0, 17.0, 17.0, 17.0),
        color: FontUtil.getSummaryBackgroundColor(),
        child: new Text(data == null ? 'empty' : data.text1,
            style: FontUtil.getSummaryFont()));
  }
}

class ListItemStateDivider extends State<CriticListViewItem> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.fromLTRB(0, 20.0, 0, 10.0),
      height: 0.5,
      color: FontUtil.getLineShixinColor(),
    );
  }
}

class ListItemStateBrief extends State<CriticListViewItem> {
  CriticBean data;

  ListItemStateBrief({this.data});

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text("剧情简介",
            style: new TextStyle(
                fontSize: 18.0, color: FontUtil.getBriefFontColor())),
        new Container(
            margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
            child: new FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: data == null
                  ? ''
                  : "http://images.shigeten.net/" + data.image1,
              height: (window.physicalSize.width * 9) /
                  (16 * window.devicePixelRatio),
              width: window.physicalSize.width / window.devicePixelRatio,
              fit: BoxFit.cover,
            )),
      ],
    );
  }
}

class ListItemStateText2 extends State<CriticListViewItem> {
  CriticBean data;

  ListItemStateText2({this.data});

  @override
  Widget build(BuildContext context) {
    return new Text(
        data == null
            ? 'empty'
            : data.text2
                .toString()
                .replaceAll("剧情介绍\r\n", "")
                .replaceAll("剧情简介\r\n", "")
                .replaceAll("剧情简介 \r\n", ""),
        style: FontUtil.getContentFont());
  }
}

class ListItemStateDivider2 extends State<CriticListViewItem> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
      height: 0.5,
      color: FontUtil.getLineShixinColor(),
    );
  }
}

class ListItemStateRealTitle extends State<CriticListViewItem> {
  CriticBean data;

  ListItemStateRealTitle({this.data});

  @override
  Widget build(BuildContext context) {
    return new Text(data == null ? 'empty' : data.realtitle,
        style:
            new TextStyle(fontSize: 18.0, color: FontUtil.getBriefFontColor()));
  }
}

class ListItemStateImage2 extends State<CriticListViewItem> {
  CriticBean data;

  ListItemStateImage2({this.data});

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
        child: new FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image:
              data == null ? '' : "http://images.shigeten.net/" + data.image2,
          height:
              (window.physicalSize.width * 9) / (16 * window.devicePixelRatio),
          width: window.physicalSize.width / window.devicePixelRatio,
          fit: BoxFit.cover,
        ));
  }
}

class ListItemStateText3 extends State<CriticListViewItem> {
  CriticBean data;

  ListItemStateText3({this.data});

  @override
  Widget build(BuildContext context) {
    return new Text(data == null ? 'empty' : data.text3,
        style: FontUtil.getContentFont());
  }
}

class ListItemStateText4 extends State<CriticListViewItem> {
  CriticBean data;

  ListItemStateText4({this.data});

  @override
  Widget build(BuildContext context) {
    return new Text(data == null ? 'empty' : data.text4,
        style: FontUtil.getContentFont());
  }
}

class ListItemStateText5 extends State<CriticListViewItem> {
  CriticBean data;

  ListItemStateText5({this.data});

  @override
  Widget build(BuildContext context) {
    return new Text(data == null ? 'empty' : data.text5,
        style: FontUtil.getContentFont());
  }
}

class ListItemStateImage3 extends State<CriticListViewItem> {
  CriticBean data;

  ListItemStateImage3({this.data});

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
        child: new FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image:
              data == null ? '' : "http://images.shigeten.net/" + data.image3,
          height:
              (window.physicalSize.width * 9) / (16 * window.devicePixelRatio),
          width: window.physicalSize.width / window.devicePixelRatio,
          fit: BoxFit.cover,
        ));
  }
}

class ListItemStateImage4 extends State<CriticListViewItem> {
  CriticBean data;

  ListItemStateImage4({this.data});

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: const EdgeInsets.fromLTRB(0, 1.0, 0, 0),
        child: new FadeInImage.memoryNetwork(
          placeholder: kTransparentImage,
          image:
              data == null ? '' : "http://images.shigeten.net/" + data.image4,
          height:
              (window.physicalSize.width * 9) / (16 * window.devicePixelRatio),
          width: window.physicalSize.width / window.devicePixelRatio,
          fit: BoxFit.cover,
        ));
  }
}

class ListItemStateImage5 extends State<CriticListViewItem> {
  CriticBean data;

  ListItemStateImage5({this.data});

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: const EdgeInsets.fromLTRB(0, 1.0, 0, 0),
        child: FadeInImage.memoryNetwork(
          image:
              data == null ? '' : "http://images.shigeten.net/" + data.image5,
          placeholder: kTransparentImage,
          height: data == null || data.image5 == null || data.image5 == ""
              ? 0
              : (window.physicalSize.width * 9) /
                  (16 * window.devicePixelRatio),
          width: window.physicalSize.width / window.devicePixelRatio,
          fit: BoxFit.cover,
        ));
  }
}

class ListItemStateDivider3 extends State<CriticListViewItem> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.fromLTRB(0, 26.0, 0, 10.0),
      height: 0.5,
      color: FontUtil.getLineShixinColor(),
    );
  }
}

class ListItemStateAuthorBelow extends State<CriticListViewItem> {
  CriticBean data;

  ListItemStateAuthorBelow({this.data});

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: const EdgeInsets.fromLTRB(0, 8.0, 0, 10.0),
        child: new Text(data == null ? 'empty' : data.author,
            style: FontUtil.getAuthorBelowFont()));
  }
}

class ListItemStateAuthorBrief extends State<CriticListViewItem> {
  CriticBean data;

  ListItemStateAuthorBrief({this.data});

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 10.0),
        child: new Text(
            data == null || data.authorbrief == null
                ? '十个 每晚十点推送:一篇影评,一篇美文,一组美图,每晚入睡前用上十分钟读到最美内容.'
                : data.authorbrief,
            style: FontUtil.getAuthorBrief()));
  }
}
