import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_tenge/bean/ListBean.dart';
import 'package:flutter_tenge/bean/NovelBean.dart';
import 'package:flutter_tenge/network/NetworkUtils.dart';
import 'package:flutter_tenge/ui/callback.dart';
import 'package:flutter_tenge/utils/FontUtil.dart';
import 'package:flutter_tenge/utils/SharedPreferencesUtil.dart';

class NovelPage extends StatefulWidget {
  ScrollController scrollController;
  ScrollToNextPageCallback scrollToNextPageCallback;

  NovelPage({this.scrollController, this.scrollToNextPageCallback});

  @override
  State<StatefulWidget> createState() {
    return new NovelPageState();
  }
}

class NovelPageState extends State<NovelPage> {
  bool _showLoading = true;
  ListBean _listBean;
  int _currentPageIndex = 0;
  var _pageController = new PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    _getList();
  }

  _getNovelBody() {
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
    return new Container(
      color: FontUtil.getMainBgColor(),
      child: new PageView.builder(
        onPageChanged: _pageChange,
        controller: _pageController,
        itemBuilder: (BuildContext context, int index) {
          print("NovelPageState itemBuilder");
          return _buildItem(context, index);
        },
        itemCount: _listBean == null
            ? 0
            : _listBean.result == null ? 0 : _listBean.result.length,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _getNovelBody();
  }

  _getList() async {
    NetworkUtils.get("http://api.shigeten.net/api/Novel/GetNovelList", (data) {
      _showLoading = false;
      if (data != null) {
        setState(() {
          _listBean = new ListBean.fromJson(data);
          if (_listBean.result.length > 0) {
            widget.scrollToNextPageCallback(_listBean.result[0]);
          }
        });
      }
    }, errorCallback: (e) {
      _showLoading = false;
      print("network error: $e");
    });
  }

  _pageChange(int index) {
    setState(() {
      if (_currentPageIndex != index) {
        _currentPageIndex = index;
        widget.scrollToNextPageCallback( _listBean.result[_currentPageIndex]);
      }
    });
  }

  Widget _buildItem(BuildContext context, int index) {
    if (_listBean != null &&
        _listBean.result != null &&
        _listBean.result.length > index) {
      return new NovelItem(id: _listBean.result[index].id, scrollController: widget.scrollController);
    } else {
      return null;
    }
  }
}

class NovelItem extends StatefulWidget {
  ScrollController scrollController;
  NovelItem({Key key, this.id, this.scrollController}) : super(key: key);
  final int id;

  @override
  State<StatefulWidget> createState() {
    return new NovelItemState(id: id);
  }
}

class NovelItemState extends State<NovelItem> {
  NovelItemState({this.id}) {
    _getNovel(id);
  }

  bool _showLoading = true;
  NovelBean _novel;
  final int id;

  @override
  void initState() {
    super.initState();
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
        color: FontUtil.getMainBgColor(),
        padding: const EdgeInsets.fromLTRB(16.0, 44.0, 16.0, 0.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              margin: const EdgeInsets.fromLTRB(0, 15.0, 0, 5.0),
              child: new Text(_novel == null ? '' : _novel.title,
                  style: FontUtil.getContentTitleFont()),
            ),
            new Row(
              children: <Widget>[
                new Text(_novel == null ? '' : '作者: ' + _novel.author,
                    style: FontUtil.getAuthorFont()),
                new Container(
                  height: 12.0,
                  width: 1.0,
                  color: FontUtil.getAuthorVerticalLineColor(),
                  margin:
                  const EdgeInsets.only(left: 10.0, right: 10.0, top: 4.0),
                ),
                new Text(
                    _novel == null
                        ? ''
                        : '阅读量: ' + _novel.times.toString(),
                    style: FontUtil.getAuthorFont())
              ],
            ),
            new Container(
                margin: const EdgeInsets.fromLTRB(0, 15.0, 0, 0),
                child: new Image.network(
                  _novel == null
                      ? ''
                      : "http://images.shigeten.net/" + _novel.image,
                  height: _novel == null ||
                      _novel.image == null ||
                      _novel.image == ""
                      ? 0
                      : (window.physicalSize.width * 9) /
                      (16 * window.devicePixelRatio),
                  width: window.physicalSize.width / window.devicePixelRatio,
                  fit: BoxFit.fill,
                )),
            new Container(
                width: window.physicalSize.width,
                margin: const EdgeInsets.fromLTRB(0, 15.0, 0, 15.0),
                padding: const EdgeInsets.fromLTRB(17.0, 17.0, 17.0, 17.0),
                color: FontUtil.getSummaryBackgroundColor(),
                child: new Text(_novel == null ? '' : _novel.summary,
                    style: FontUtil.getSummaryFont())),
            new Text(_novel == null ? '' : _novel.text,
                style: FontUtil.getContentFont()),
            new Container(
              margin: const EdgeInsets.fromLTRB(0, 16.0, 0, 0.0),
              height: 1.0,
              color: const Color(0x60eaeaea),
            ),
            new Container(
              margin: const EdgeInsets.fromLTRB(0, 8.0, 0, 0.0),
              child: new Text(_novel == null ? '' : _novel.author,
                  style: FontUtil.getAuthorBelowFont()),
            ),
            new Container(
              margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 59.0),
              child: new Text(_novel == null ? '' : _novel.authorbrief,
                  style: FontUtil.getAuthorBrief()),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _getItemBody();
  }

  _getNovel(int id) async {
    if (id == null) {
      return;
    }
    Map<String, String> params = new Map();
    params['id'] = id.toString();
    NetworkUtils.get(
        "http://api.shigeten.net/api/Novel/GetNovelContent",
        (data) {
          _showLoading = false;
          if (data != null) {
            setState(() {
              _novel = new NovelBean.fromJson(data);
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
  }

  void loadFontAsync() async {
    await FontUtil.getInstance();
  }
}
