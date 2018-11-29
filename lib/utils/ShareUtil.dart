import 'package:flutter/material.dart';
import 'package:fluwx/fluwx.dart' as fluwx;

class ShareUtil {

  /***
   * 微信朋友圈分享  文字
   */
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

  /***
   * 微信好友分享  文字
   */
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

  static wechatShareWebpageTimeLine(String url, String thumnail, String title) {
    var model = fluwx.WeChatShareWebPageModel(
        webPage: url,
        title: title,
        thumbnail: thumnail,
        scene: fluwx.WeChatScene.TIMELINE,
        transaction: "hh");
    fluwx.share(model);
  }

  static wechatShareWebpageSession(String url, String thumnail, String title) {
    var model = fluwx.WeChatShareWebPageModel(
        webPage: url,
        title: title,
        thumbnail: thumnail,
        scene: fluwx.WeChatScene.SESSION,
        transaction: "hh");
    fluwx.share(model);
  }

  static void wechatShareVideoTimeLine(String videoUrl, String lowBandUrl, String thumnail, String description, String title) {
    var model = new fluwx.WeChatShareVideoModel(
        videoUrl: videoUrl,
        transaction: "video",
        videoLowBandUrl: lowBandUrl,
        thumbnail: thumnail,
        description: description,
        scene: fluwx.WeChatScene.TIMELINE,
        title: title);
    fluwx.share(model);
  }

  static void wechatShareVideoSession(String videoUrl, String lowBandUrl, String thumnail, String description, String title) {
    var model = new fluwx.WeChatShareVideoModel(
        videoUrl: videoUrl,
        transaction: "video",
        videoLowBandUrl: lowBandUrl,
        thumbnail: thumnail,
        description: description,
        scene: fluwx.WeChatScene.SESSION,
        title: title);
    fluwx.share(model);
  }
}
