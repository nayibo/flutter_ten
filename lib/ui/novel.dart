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
        widget.scrollToNextPageCallback(_listBean.result[_currentPageIndex]);
      }
    });
  }

  Widget _buildItem(BuildContext context, int index) {
    if (_listBean != null &&
        _listBean.result != null &&
        _listBean.result.length > index) {
      return new NovelItem(
          id: _listBean.result[index].id,
          scrollController: widget.scrollController);
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
    return ListView.builder(
        controller: widget.scrollController,
        padding: const EdgeInsets.fromLTRB(16.0, 44.0, 16.0, 50.0),
        itemCount: 8,
        itemBuilder: (context, index) {
          return new NovelListViewItem(data: _novel, index: index);
        });
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

class NovelListViewItem extends StatefulWidget {
  final NovelBean data;
  final int index;

  NovelListViewItem({this.data, this.index});

  @override
  State<StatefulWidget> createState() {
    switch (index) {
      case 0:
        return new NovelListItemStateTitle(data: data);
      case 1:
        return new NovelListItemStateAuthor(data: data);
      case 2:
        return new NovelListItemStateImage(data: data);
      case 3:
        return new NovelListItemStateSummary(data: data);
      case 4:
        return new NovelListItemStateText(data: data);
      case 5:
        return new NovelListItemStateDivider();
      case 6:
        return new NovelListItemStateAuthorBelow(data: data);
      case 7:
        return new NovelListItemStateAuthorBrief(data: data);
    }

    return new NovelListItemStateTitle(data: data);
  }
}

class NovelListItemStateTitle extends State<NovelListViewItem> {
  NovelBean data;

  NovelListItemStateTitle({this.data});

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 0),
      child: new Container(
        margin: const EdgeInsets.fromLTRB(0, 15.0, 0, 5.0),
        child: new Text(data == null ? '' : data.title,
            style: FontUtil.getContentTitleFont()),
      ),
    );
  }
}

class NovelListItemStateAuthor extends State<NovelListViewItem> {
  NovelBean data;

  NovelListItemStateAuthor({this.data});

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Text(data == null ? '' : '作者: ' + data.author,
            style: FontUtil.getAuthorFont()),
        new Container(
          height: 12.0,
          width: 1.0,
          color: FontUtil.getAuthorVerticalLineColor(),
          margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 4.0),
        ),
        new Text(data == null ? '' : '阅读量: ' + data.times.toString(),
            style: FontUtil.getAuthorFont())
      ],
    );
  }
}

class NovelListItemStateImage extends State<NovelListViewItem> {
  NovelBean data;

  NovelListItemStateImage({this.data});

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: const EdgeInsets.fromLTRB(0, 15.0, 0, 0),
        child: new Image.network(
          data == null ? '' : "http://images.shigeten.net/" + data.image,
          height: data == null || data.image == null || data.image == ""
              ? 0
              : (window.physicalSize.width * 9) /
                  (16 * window.devicePixelRatio),
          width: window.physicalSize.width / window.devicePixelRatio,
          fit: BoxFit.fill,
        ));
  }
}

class NovelListItemStateSummary extends State<NovelListViewItem> {
  NovelBean data;

  NovelListItemStateSummary({this.data});

  @override
  Widget build(BuildContext context) {
    return new Container(
        width: window.physicalSize.width,
        margin: const EdgeInsets.fromLTRB(0, 15.0, 0, 15.0),
        padding: const EdgeInsets.fromLTRB(17.0, 17.0, 17.0, 17.0),
        color: FontUtil.getSummaryBackgroundColor(),
        child: new Text(data == null ? '' : data.summary,
            style: FontUtil.getSummaryFont()));
  }
}

class NovelListItemStateText extends State<NovelListViewItem> {
  NovelBean data;

  NovelListItemStateText({this.data});

  @override
  Widget build(BuildContext context) {
    return new Text(data == null ? '' : data.text,
        style: FontUtil.getContentFont());
  }
}

class NovelListItemStateDivider extends State<NovelListViewItem> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.fromLTRB(0, 16.0, 0, 0.0),
      height: 1.0,
      color: const Color(0x60eaeaea),
    );
  }
}

class NovelListItemStateAuthorBelow extends State<NovelListViewItem> {
  NovelBean data;

  NovelListItemStateAuthorBelow({this.data});

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: const EdgeInsets.fromLTRB(0, 8.0, 0, 0.0),
      child: new Text(data == null ? '' : data.author,
          style: FontUtil.getAuthorBelowFont()),
    );
  }
}

class NovelListItemStateAuthorBrief extends State<NovelListViewItem> {
  NovelBean data;

  NovelListItemStateAuthorBrief({this.data});

  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: const EdgeInsets.fromLTRB(0, 10.0, 0, 59.0),
        child: new Text(data == null ? '' : data.authorbrief,
            style: FontUtil.getAuthorBrief()));
  }
}
