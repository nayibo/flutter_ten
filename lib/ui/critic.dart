import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_tenge/bean/CriticBean.dart';
import 'package:flutter_tenge/bean/ListBean.dart';
import 'package:flutter_tenge/constant/data.dart';
import 'package:flutter_tenge/constant/font.dart';
import 'package:flutter_tenge/network/NetworkUtils.dart';
import 'package:flutter_tenge/ui/callback.dart';
import 'package:flutter_tenge/ui/share.dart';
import 'package:flutter_tenge/utils/FontUtil.dart';
import 'package:flutter_tenge/utils/ShareUtil.dart';
import 'package:flutter_tenge/utils/SharedPreferencesUtil.dart';

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
          color: Colors.white,
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

  _share() {
//    fluwx
//        .share(fluwx.WeChatShareTextModel(
//            text: 'share text',
//            transaction: "text${DateTime.now().millisecondsSinceEpoch}",
//            scene: fluwx.WeChatScene.TIMELINE))
//        .then((data) {
//      print(data);
//    });
    ShareUtil.wechatShareWebpageTimeLine(
        ShareUtil.getShareUrl(_listBean.result[_currentPageIndex].type,
            _listBean.result[_currentPageIndex].id),
        'assets://assets/images/share_icon.png',
        _listBean.result[_currentPageIndex].summary,
        _listBean.result[_currentPageIndex].title);
  }

  Future<void> _showShareDialog() {
    return showDialog<Null>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new ShareDialog(
              listItem: _listBean.result[_currentPageIndex]);
        });
  }

  _pageChange(int index) {
    setState(() {
      if (_currentPageIndex != index) {
        _currentPageIndex = index;
        widget.scrollToNextPageCallback(_listBean.result[_currentPageIndex]);
      }
    });
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
    _getCritic(id);
  }

  bool _showLoading = true;
  CriticBean _critic;
  TextStyle textStyle =
      new TextStyle(fontSize: 18, color: const Color(0xFF666666));
  final int id;

  @override
  void initState() {
    super.initState();
    _getCritic(id);
    loadFontAsync();
    loadAsync();
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
    return new SingleChildScrollView(
      controller: widget.scrollController,
      child: new Container(
        padding: const EdgeInsets.fromLTRB(0, 44.0, 0, 0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Image.network(
              _critic == null
                  ? ''
                  : "http://images.shigeten.net/" + _critic.imageforplay,
              height: (window.physicalSize.width * 9) /
                  (16 * window.devicePixelRatio),
              width: window.physicalSize.width / window.devicePixelRatio,
              fit: BoxFit.fill,
            ),
            new Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(16.0, 15.0, 16.0, 50.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(_critic == null ? 'empty' : _critic.title,
                      style: FontUtil.getContentTitleFont()),
                  new Row(
                    children: <Widget>[
                      new Text(
                          _critic == null ? 'empty' : '作者: ' + _critic.author,
                          style: new TextStyle(
                              fontSize: 12.0, color: const Color(0xFF999999))),
                      new Container(
                        height: 12.0,
                        width: 1.0,
                        color: const Color(0xFF999999),
                        margin: const EdgeInsets.only(
                            left: 10.0, right: 10.0, top: 4.0),
                      ),
                      new Text(
                          _critic == null
                              ? 'empty'
                              : '阅读量: ' + _critic.times.toString(),
                          style: new TextStyle(
                              fontSize: 12.0, color: const Color(0xFF999999)))
                    ],
                  ),
                  new Container(
                      width: window.physicalSize.width,
                      margin: const EdgeInsets.fromLTRB(0, 35.0, 0, 0),
                      padding:
                          const EdgeInsets.fromLTRB(17.0, 17.0, 17.0, 17.0),
                      color: const Color(0x60eaeaea),
                      child: new Text(_critic == null ? 'empty' : _critic.text1,
                          style: textStyle)),
                  new Container(
                    margin: const EdgeInsets.fromLTRB(0, 20.0, 0, 10.0),
                    height: 1.0,
                    color: const Color(0x60eaeaea),
                  ),
                  new Text("剧情简介",
                      style: new TextStyle(
                          fontSize: 18.0, color: const Color(0xFF222222))),
                  new Container(
                      margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                      child: new Image.network(
                        _critic == null
                            ? ''
                            : "http://images.shigeten.net/" + _critic.image1,
                        height: (window.physicalSize.width * 9) /
                            (16 * window.devicePixelRatio),
                        width:
                            window.physicalSize.width / window.devicePixelRatio,
                        fit: BoxFit.fill,
                      )),
                  new Text(
                      _critic == null
                          ? 'empty'
                          : _critic.text2
                              .toString()
                              .replaceAll("剧情介绍\r\n", "")
                              .replaceAll("剧情简介\r\n", "")
                              .replaceAll("剧情简介 \r\n", ""),
                      style: textStyle),
                  new Container(
                    margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                    height: 1.0,
                    color: const Color(0x60eaeaea),
                  ),
                  new Text(_critic == null ? 'empty' : _critic.realtitle,
                      style: new TextStyle(
                          fontSize: 18.0, color: const Color(0xFF222222))),
                  new Container(
                      margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                      child: new Image.network(
                        _critic == null
                            ? ''
                            : "http://images.shigeten.net/" + _critic.image2,
                        height: (window.physicalSize.width * 9) /
                            (16 * window.devicePixelRatio),
                        width:
                            window.physicalSize.width / window.devicePixelRatio,
                        fit: BoxFit.fill,
                      )),
                  new Text(_critic == null ? 'empty' : _critic.text3,
                      style: textStyle),
                  new Text(_critic == null ? 'empty' : _critic.text4,
                      style: textStyle),
                  new Text(_critic == null ? 'empty' : _critic.text5,
                      style: textStyle),
                  new Container(
                      margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 0),
                      child: new Image.network(
                        _critic == null
                            ? ''
                            : "http://images.shigeten.net/" + _critic.image3,
                        height: (window.physicalSize.width * 9) /
                            (16 * window.devicePixelRatio),
                        width:
                            window.physicalSize.width / window.devicePixelRatio,
                        fit: BoxFit.fill,
                      )),
                  new Container(
                      margin: const EdgeInsets.fromLTRB(0, 1.0, 0, 0),
                      child: new Image.network(
                        _critic == null
                            ? ''
                            : "http://images.shigeten.net/" + _critic.image4,
                        height: (window.physicalSize.width * 9) /
                            (16 * window.devicePixelRatio),
                        width:
                            window.physicalSize.width / window.devicePixelRatio,
                        fit: BoxFit.fill,
                      )),
                  new Container(
                      margin: const EdgeInsets.fromLTRB(0, 1.0, 0, 0),
                      child: new Image.network(
                        _critic == null
                            ? ''
                            : "http://images.shigeten.net/" + _critic.image5,
                        height: _critic == null ||
                                _critic.image5 == null ||
                                _critic.image5 == ""
                            ? 0
                            : (window.physicalSize.width * 9) /
                                (16 * window.devicePixelRatio),
                        width:
                            window.physicalSize.width / window.devicePixelRatio,
                        fit: BoxFit.fill,
                      )),
                  new Container(
                    margin: const EdgeInsets.fromLTRB(0, 26.0, 0, 10.0),
                    height: 1.0,
                    color: const Color(0x60eaeaea),
                  ),
                  new Container(
                      margin: const EdgeInsets.fromLTRB(0, 8.0, 0, 10.0),
                      child: new Text(
                          _critic == null ? 'empty' : _critic.author,
                          style: new TextStyle(
                              fontSize: 18.0,
                              color: const Color(0xFF464646),
                              fontWeight: FontWeight.bold))),
                  new Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                      child: new Text(
                          _critic == null || _critic.authorbrief == null
                              ? '十个 每晚十点推送:一篇影评,一篇美文,一组美图,每晚入睡前用上十分钟读到最美内容.'
                              : _critic.authorbrief,
                          style: new TextStyle(
                              color: const Color(0xFF777777), fontSize: 16.0)))
                ],
              ),
            ),
          ],
        ),
      ),
    );
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

  void loadAsync() async {
    await SpUtil.getInstance();
    initFont();
  }

  void loadFontAsync() async {
    await FontUtil.getInstance();
  }

  void initFont() {
    setState(() {
      int size = 1;
      print("_initFont: " + SpUtil.getInt(SPConstant.SP_FONT).toString());
      if (null != SpUtil.getInt(SPConstant.SP_FONT)) {
        size = SpUtil.getInt(SPConstant.SP_FONT);
      }

      switch (size) {
        case 1:
          textStyle = new TextStyle(
              fontSize: FontConstant.FONT_CONTENT_SMALL,
              color: const Color(0xFF666666));
          break;
        case 2:
          textStyle = new TextStyle(
              fontSize: FontConstant.FONT_CONTENT_MID,
              color: const Color(0xFF666666));
          break;
        case 3:
          textStyle = new TextStyle(
              fontSize: FontConstant.FONT_CONTENT_BIG,
              color: const Color(0xFF666666));
          break;
        default:
      }
    });
  }
}
