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

  /***
   * 微信朋友圈分享  网址
   */
  static wechatShareWebpageTimeLine(String url, String thumbnail, String title, String description) {
    var model = fluwx.WeChatShareWebPageModel(
        webPage: url,
        title: title,
        thumbnail: thumbnail,
        scene: fluwx.WeChatScene.TIMELINE,
        description: description,
        transaction: "hh");
    fluwx.share(model);
  }

  /***
   * 微信好友分享  网址
   */
  static wechatShareWebpageSession(String url, String thumbnail, String title, String description) {
    var model = fluwx.WeChatShareWebPageModel(
        webPage: url,
        title: title,
        thumbnail: thumbnail,
        scene: fluwx.WeChatScene.SESSION,
        description: description,
        transaction: "hh");
    fluwx.share(model);
  }

  /***
   * 微信朋友圈分享  视频
   */
  static wechatShareVideoTimeLine(String videoUrl, String lowBandUrl, String thumbnail, String description, String title) {
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

  /***
   * 微信好友分享  视频
   */
  static wechatShareVideoSession(String videoUrl, String lowBandUrl, String thumbnail, String description, String title) {
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

  /***
   * 微信朋友圈分享  图片
   */
  static wechatShareImageTimeLine(String imageUrl, String thumbnail, String description) {
    fluwx.share(fluwx.WeChatShareImageModel(
        image: imageUrl,
        thumbnail: thumbnail,
        transaction: imageUrl,
        scene: fluwx.WeChatScene.TIMELINE,
        description: description));
  }

  /***
   * 微信好友分享  图片
   */
  static wechatShareImageSession(String imageUrl, String thumbnail, String description) {
    fluwx.share(fluwx.WeChatShareImageModel(
        image: imageUrl,
        thumbnail: thumbnail,
        transaction: imageUrl,
        scene: fluwx.WeChatScene.SESSION,
        description: description));
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
