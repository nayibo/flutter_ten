import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tenge_flutter/bean/CriticBean.dart';
import 'package:tenge_flutter/bean/ListBean.dart';
import 'package:tenge_flutter/network/NetworkUtils.dart';
import 'package:tenge_flutter/ui/share.dart';
import 'package:tenge_flutter/utils/DateUtil.dart';
import 'package:tenge_flutter/utils/ShareUtil.dart';

class CriticPage extends StatefulWidget {
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

  CriticPageState() {
    print("CriticPageState construtor");
    _getList();
  }

  @override
  Widget build(BuildContext context) {
    print("CriticPageState build");
    return new Stack(
      children: <Widget>[
        new Container(
          color: Colors.white,
          padding: const EdgeInsets.fromLTRB(
            0,
            32.0,
            0,
            0,
          ),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Text((_listBean != null &&
                          _listBean.result != null &&
                          _listBean.result.length > _currentPageIndex)
                      ? DateUtil.getDateStrByMs(
                          DateUtil.formatCSharpMiliSecondtoMiliSecond(
                              _listBean.result[_currentPageIndex].publishtime),
                          format: DateFormat.YEAR_MONTH_DAY)
                      : "empty date"),
                  new Text((_listBean != null &&
                          _listBean.result != null &&
                          _listBean.result.length > _currentPageIndex)
                      ? DateUtil.getWeekDayByMs(
                          DateUtil.formatCSharpMiliSecondtoMiliSecond(
                              _listBean.result[_currentPageIndex].publishtime))
                      : "empty week")
                ],
              ),
              new Expanded(
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
              )
            ],
          ),
        ),
        new Container(
          alignment: new Alignment(0.9, 0.8),
          child: new IconButton(icon: new Icon(Icons.share), onPressed: _showShareDialog),
        )
      ],
    );
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
        return new ShareDialog(currentIndex: _currentPageIndex, listBean: _listBean);
      }
    );
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
      return new CriticItem(id: _listBean.result[index].id);
    } else {
      return null;
    }
  }

  _getList() async {
    NetworkUtils.get("http://api.shigeten.net/api/Critic/GetCriticList",
        (data) {
      if (data != null) {
        _listBean = new ListBean.fromJson(data);
      }
      setState(() {});
    }, errorCallback: (e) {
      print("_getList network error: $e");
    });
  }
}

class CriticItem extends StatefulWidget {
  CriticItem({Key key, this.id}) : super(key: key);

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

  CriticBean _critic;

  final int id;

  @override
  Widget build(BuildContext context) {
    return new SingleChildScrollView(
        child: new Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        new Image.network(
          _critic == null
              ? ''
              : "http://images.shigeten.net/" + _critic.imageforplay,
          height:
              (window.physicalSize.width * 9) / (16 * window.devicePixelRatio),
          width: window.physicalSize.width / window.devicePixelRatio,
          fit: BoxFit.fill,
        ),
        new Text(_critic == null ? 'empty' : _critic.title),
        new Row(
          children: <Widget>[
            new Text(_critic == null ? 'empty' : '作者: ' + _critic.author),
            new Container(
              height: 12.0,
              width: 1.0,
              color: Colors.grey,
              margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 4.0),
            ),
            new Text(
                _critic == null ? 'empty' : '阅读量: ' + _critic.times.toString())
          ],
        ),
        new Container(
            color: Colors.grey,
            child: new Text(_critic == null ? 'empty' : _critic.text1)),
        new Text("剧情简介"),
        new Image.network(
          _critic == null ? '' : "http://images.shigeten.net/" + _critic.image1,
          height:
              (window.physicalSize.width * 9) / (16 * window.devicePixelRatio),
          width: window.physicalSize.width / window.devicePixelRatio,
          fit: BoxFit.fill,
        ),
        new Text(_critic == null ? 'empty' : _critic.text2),
        new Text(_critic == null ? 'empty' : _critic.realtitle),
        new Image.network(
          _critic == null ? '' : "http://images.shigeten.net/" + _critic.image2,
          height:
              (window.physicalSize.width * 9) / (16 * window.devicePixelRatio),
          width: window.physicalSize.width / window.devicePixelRatio,
          fit: BoxFit.fill,
        ),
        new Text(_critic == null ? 'empty' : _critic.text3),
        new Text(_critic == null ? 'empty' : _critic.text4),
        new Text(_critic == null ? 'empty' : _critic.text5),
        new Image.network(
          _critic == null ? '' : "http://images.shigeten.net/" + _critic.image3,
          height:
              (window.physicalSize.width * 9) / (16 * window.devicePixelRatio),
          width: window.physicalSize.width / window.devicePixelRatio,
          fit: BoxFit.fill,
        ),
        new Image.network(
          _critic == null ? '' : "http://images.shigeten.net/" + _critic.image4,
          height:
              (window.physicalSize.width * 9) / (16 * window.devicePixelRatio),
          width: window.physicalSize.width / window.devicePixelRatio,
          fit: BoxFit.fill,
        ),
        new Image.network(
          _critic == null ? '' : "http://images.shigeten.net/" + _critic.image5,
          height:
              _critic == null || _critic.image5 == null || _critic.image5 == ""
                  ? 0
                  : (window.physicalSize.width * 9) /
                      (16 * window.devicePixelRatio),
          width: window.physicalSize.width / window.devicePixelRatio,
          fit: BoxFit.fill,
        ),
        new Text(_critic == null ? 'empty' : _critic.author),
        new Text(_critic == null || _critic.authorbrief == null
            ? 'empty'
            : _critic.authorbrief),
        new Image.asset('assets/images/share_icon.png')
      ],
    ));
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
          if (data != null) {
            setState(() {
              _critic = new CriticBean.fromJson(data);
            });
          }
        },
        params: params,
        errorCallback: (e) {
          print("_getCritic network error: $e");
        });
  }
}
