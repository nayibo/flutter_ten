import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_tenge/bean/DiagramBean.dart';
import 'package:flutter_tenge/bean/ListBean.dart';
import 'package:flutter_tenge/constant/font.dart';
import 'package:flutter_tenge/network/NetworkUtils.dart';
import 'package:flutter_tenge/utils/FontUtil.dart';
import 'package:flutter_tenge/utils/SharedPreferencesUtil.dart';

class DiagramPage extends StatefulWidget {
  ScrollController scrollController;

  DiagramPage({this.scrollController});

  @override
  State<StatefulWidget> createState() {
    return new DiagramPageState();
  }
}

class DiagramPageState extends State<DiagramPage> {
  bool _showLoading = true;
  ListBean _listBean;
  int _currentPageIndex = 0;
  var _pageController = new PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    _getList();
  }

  _getDiagramBody() {
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
      color: Colors.white,
      child: new PageView.builder(
        onPageChanged: _pageChange,
        controller: _pageController,
        itemBuilder: (BuildContext context, int index) {
          print("DiagramPageState itemBuilder");
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
    return _getDiagramBody();
  }

  _getList() async {
    NetworkUtils.get("http://api.shigeten.net/api/Diagram/GetDiagramList",
        (data) {
      _showLoading = false;
      if (data != null) {
        setState(() {
          _listBean = new ListBean.fromJson(data);
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
      }
    });
  }

  Widget _buildItem(BuildContext context, int index) {
    if (_listBean != null &&
        _listBean.result != null &&
        _listBean.result.length > index) {
      return new DiagramItem(
          id: _listBean.result[index].id,
          scrollController: widget.scrollController);
    } else {
      return null;
    }
  }
}

class DiagramItem extends StatefulWidget {
  ScrollController scrollController;

  DiagramItem({Key key, this.id, this.scrollController}) : super(key: key);

  final int id;

  @override
  State<StatefulWidget> createState() {
    return new DiagramItemState(id: id);
  }
}

class DiagramItemState extends State<DiagramItem> {
  DiagramItemState({this.id}) {
    _getDiagram(id);
  }

  bool _showLoading = true;
  DiagramBean _diagram;
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
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(0.0, 44.0, 0.0, 115.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
                margin: const EdgeInsets.fromLTRB(0, 15.0, 0, 0),
                child: new Image.network(
                  _diagram == null
                      ? ''
                      : "http://images.shigeten.net/" + _diagram.image1,
                  width: window.physicalSize.width / window.devicePixelRatio,
                  fit: BoxFit.fill,
                )),
            new Container(
              margin: const EdgeInsets.fromLTRB(16.0, 10.0, 16.0, 0.0),
              child: new Text(_diagram == null ? 'empty' : _diagram.title,
                  style: FontUtil.getContentTitleFont()),
            ),
            new Container(
              margin: const EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 0.0),
              child: new Text(
                  _diagram == null
                      ? '十个 每晚十点推送:一篇影评,一篇美文,一组美图,每晚入睡前用上十分钟读到最美内容.'
                      : _diagram.authorbrief,
                  style: FontUtil.getAuthorFont()),
            ),
            new Container(
              margin: const EdgeInsets.fromLTRB(16.0, 15.0, 16.0, 0.0),
              height: 1.0,
              color: const Color(0x60eaeaea),
            ),
            new Container(
              color: FontUtil.getSummaryBackgroundColor(),
              margin: const EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 0.0),
              padding: const EdgeInsets.fromLTRB(17.0, 17.0, 17.0, 17.0),
              child: new Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Container(
                      child: new Text(_diagram == null ? '' : _diagram.text1,
                          style: FontUtil.getSummaryFontWithMode(
                              FontConstant.FONT_SMALL)),
                    ),
                    new Container(
                      margin: const EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 0.0),
                      child: new Text(_diagram == null ? '' : _diagram.text2,
                          style: FontUtil.getSummaryFontWithMode(
                              FontConstant.FONT_SMALL)),
                    ),
                  ]),
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

  _getDiagram(int id) async {
    if (id == null) {
      return;
    }
    Map<String, String> params = new Map();
    params['id'] = id.toString();
    NetworkUtils.get(
        "http://api.shigeten.net/api/Diagram/GetDiagramContent",
        (data) {
          _showLoading = false;
          if (data != null) {
            setState(() {
              _diagram = new DiagramBean.fromJson(data);
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
