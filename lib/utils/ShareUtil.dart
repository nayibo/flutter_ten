import 'dart:async';
import 'dart:typed_data';

import 'package:fake_tencent/fake_tencent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tenge/bean/ListBean.dart';
import 'package:flutter_tenge/constant/data.dart';
import 'package:flutter_tenge/utils/SharedPreferencesUtil.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:fake_weibo/fake_weibo.dart';

class SINAShareUtil {
  static SINAShareUtil _singleton;
  static String WEIBO_APP_KEY = '1471162418';
  static FakeWeibo weibo;

  SINAShareUtil._();

  static SINAShareUtil getInstance() {
    if (_singleton == null) {
      if (_singleton == null) {
        var singleton = SINAShareUtil._();
        singleton._init();
        _singleton = singleton;
      }
    }
    return _singleton;
  }

  void _init() {
    weibo = new FakeWeibo(
      appKey: WEIBO_APP_KEY,
      scope: [
        FakeWeiboScope.ALL,
      ],
    );
    weibo.registerApp();
  }

  static void shareWebpage(BuildContext context, ListItem item) async {
    if (weibo == null) {
      return;
    }
    AssetImage image = new AssetImage('assets/images/share_icon.png');
    AssetBundleImageKey key =
    await image.obtainKey(createLocalImageConfiguration(context));
    ByteData thumbData = await key.bundle.load(key.name);
    weibo.shareWebpage(
      title: item.title,
      description: item.summary,
      thumbData: thumbData.buffer.asUint8List(),
      webpageUrl: WechatShareUtil.getShareUrl(item.type, item.id),
    );
  }
}

class QQShareUtil {
  static QQShareUtil _singleton;
  static FakeTencent _tencent;
  static StreamSubscription<FakeTencentLoginResp> _login;
  static StreamSubscription<FakeTencentUserInfoResp> _userInfo;
  static StreamSubscription<FakeTencentShareResp> _share;

  QQShareUtil._();

  static QQShareUtil getInstance() {
    if (_singleton == null) {
      if (_singleton == null) {
        var singleton = QQShareUtil._();
        singleton._init();
        _singleton = singleton;
      }
    }
    return _singleton;
  }

  void _init() {
    _tencent = new FakeTencent();
    _tencent.registerApp(appId: '1104005798');
  }

  static void login(void onData(FakeTencentLoginResp event),
      {Function onError, void onDone(), bool cancelOnError}) {
    if (_tencent != null) {
      _login = _tencent.loginResp().listen(onData);
      _tencent.login(scope: [FakeTencentScope.GET_USER_INFO]);
    }
  }

  static void getUserInfo(void onData(FakeTencentUserInfoResp event),
      {Function onError, void onDone(), bool cancelOnError}) {
    if (_tencent != null) {
      _userInfo = _tencent.userInfoResp().listen(onData);
      print("open id: " +
          SpUtil.getString(SPConstant.SP_QQ_OPEN_ID) +
          SpUtil.getString(SPConstant.SP_QQ_ACCESS_TOKEN));
      if (SpUtil.getString(SPConstant.SP_QQ_OPEN_ID) != null &&
          SpUtil.getString(SPConstant.SP_QQ_ACCESS_TOKEN) != null &&
          SpUtil.getInt(SPConstant.SP_QQ_EXPIRES_TIME_SEC) != null) {
        _tencent.setAccessToken(
            openId: SpUtil.getString(SPConstant.SP_QQ_OPEN_ID),
            accessToken: SpUtil.getString(SPConstant.SP_QQ_ACCESS_TOKEN),
            expirationDate: SpUtil.getInt(SPConstant.SP_QQ_EXPIRES_TIME_SEC));
      }
      _tencent.getUserInfo();
    }
  }

  static void shareQQUrl(void onData(FakeTencentShareResp event), ListItem item,
      {Function onError, void onDone(), bool cancelOnError}) {
    if (_tencent != null) {
      _share = _tencent.shareResp().listen(onData);
      _tencent.shareWebpage(
        appName: '十个',
        scene: FakeTencentScene.SCENE_QQ,
        title: item.title,
        summary: item.summary,
        imageUri: Uri.file('assets://assets/images/share_icon.png'),
        targetUrl: WechatShareUtil.getShareUrl(item.type, item.id),
      );
    }
  }

  static void shareQQZONEUrl(
      void onData(FakeTencentShareResp event), ListItem item,
      {Function onError, void onDone(), bool cancelOnError}) {
    if (_tencent != null) {
      _share = _tencent.shareResp().listen(onData);
      _tencent.shareWebpage(
        appName: '十个',
        scene: FakeTencentScene.SCENE_QZONE,
        title: item.title,
        summary: item.summary,
        imageUri: Uri.file('assets://assets/images/share_icon.png'),
        targetUrl: WechatShareUtil.getShareUrl(item.type, item.id),
      );
    }
  }

  static void clear() {
    if (_login != null) {
      _login.cancel();
    }
    if (_userInfo != null) {
      _userInfo.cancel();
    }
    if (_share != null) {
      _share.cancel();
    }
    _tencent = null;
    _singleton = null;
  }
}

class WechatShareUtil {
  /// 微信朋友圈分享  文字
  static weChatShareTextTimeLine(String text) {
    fluwx
        .share(fluwx.WeChatShareTextModel(
            text: text,
            transaction: "text${DateTime.now().millisecondsSinceEpoch}",
            scene: fluwx.WeChatScene.TIMELINE))
        .then((data) {
      print(data);
    });
  }

  ///微信好友分享  文字
  static weChatShareTextSession(String text) {
    fluwx
        .share(fluwx.WeChatShareTextModel(
            text: text,
            transaction: "text${DateTime.now().millisecondsSinceEpoch}",
            scene: fluwx.WeChatScene.SESSION))
        .then((data) {
      print(data);
    });
  }

  ///微信朋友圈分享  网址
  static wechatShareWebpageTimeLine(
      String url, String thumbnail, String title, String description) {
    var model = fluwx.WeChatShareWebPageModel(
        webPage: url,
        title: title,
        thumbnail: thumbnail,
        scene: fluwx.WeChatScene.TIMELINE,
        description: description,
        transaction: "web url");
    fluwx.share(model);
  }

  ///微信好友分享  网址
  static wechatShareWebpageSession(
      String url, String thumbnail, String title, String description) {
    var model = fluwx.WeChatShareWebPageModel(
        webPage: url,
        title: title,
        thumbnail: thumbnail,
        scene: fluwx.WeChatScene.SESSION,
        description: description,
        transaction: "web url");
    fluwx.share(model);
  }

  ///微信朋友圈分享  视频
  static wechatShareVideoTimeLine(String videoUrl, String lowBandUrl,
      String thumbnail, String description, String title) {
    var model = new fluwx.WeChatShareVideoModel(
        videoUrl: videoUrl,
        transaction: "video",
        videoLowBandUrl: lowBandUrl,
        thumbnail: thumbnail,
        description: description,
        scene: fluwx.WeChatScene.TIMELINE,
        title: title);
    fluwx.share(model);
  }

  ///微信好友分享  视频
  static wechatShareVideoSession(String videoUrl, String lowBandUrl,
      String thumbnail, String description, String title) {
    var model = new fluwx.WeChatShareVideoModel(
        videoUrl: videoUrl,
        transaction: "video",
        videoLowBandUrl: lowBandUrl,
        thumbnail: thumbnail,
        description: description,
        scene: fluwx.WeChatScene.SESSION,
        title: title);
    fluwx.share(model);
  }

  ///微信朋友圈分享  图片
  static wechatShareImageTimeLine(
      String imageUrl, String thumbnail, String description) {
    fluwx.share(fluwx.WeChatShareImageModel(
        image: imageUrl,
        thumbnail: thumbnail,
        transaction: imageUrl,
        scene: fluwx.WeChatScene.TIMELINE,
        description: description));
  }

  ///微信好友分享  图片
  static wechatShareImageSession(
      String imageUrl, String thumbnail, String description) {
    fluwx.share(fluwx.WeChatShareImageModel(
        image: imageUrl,
        thumbnail: thumbnail,
        transaction: imageUrl,
        scene: fluwx.WeChatScene.SESSION,
        description: description));
  }

  static Future isWechatInstall() {
    return fluwx.isWeChatInstalled();
  }

  static final String URL_START = "http://www.shigeten.net/content.aspx?";

  static String getShareUrl(int type, int id) {
    StringBuffer sb = new StringBuffer();
    sb.write(URL_START);
    sb.write("type=");
    sb.write(type);
    sb.write("&id=");
    sb.write(id);
    return sb.toString();
  }
}
