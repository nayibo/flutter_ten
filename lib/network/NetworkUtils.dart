import 'package:flutter_tenge/bean/CriticBean.dart';
import 'package:flutter_tenge/bean/Favorite.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkUtils {
  static void get(String url, Function callback,
      {Map<String, String> params, Function errorCallback}) async {
    if (params != null && params.isNotEmpty) {
      StringBuffer sb = new StringBuffer("?");
      params.forEach((key, value) {
        sb.write("$key" + "=" + "$value" + "&");
      });
      String paramStr = sb.toString();
      paramStr = paramStr.substring(0, paramStr.length - 1);
      url += paramStr;
    }

    try {
      http.Response response = await http.get(url);
      print("flutter url: " + url);
      if (callback != null) {
        callback(json.decode(response.body));
      }
    } catch (e) {
      if (errorCallback != null) {
        errorCallback(e);
      }
    }
  }

  static Future<CriticBean> fetchCritic(String url,
      {Map<String, String> params}) async {
    if (params != null && params.isNotEmpty) {
      StringBuffer sb = new StringBuffer("?");
      params.forEach((key, value) {
        sb.write("$key" + "=" + "$value" + "&");
      });
      String paramStr = sb.toString();
      paramStr = paramStr.substring(0, paramStr.length - 1);
      url += paramStr;
    }

    try {
      CriticBean criticBean;
      http.Response response = await http.get(url);
      print("flutter url: " + url);
      if (json.decode(response.body) != null) {
        criticBean = new CriticBean.fromJson(json.decode(response.body));
      }

      return criticBean;
    } catch (e) {
      throw Exception('Failed to critic');
    }
  }

  static Future<List<FavoriteBean>> fetchFavoriteList(String url,
      {Map<String, String> params}) async {
    if (params != null && params.isNotEmpty) {
      StringBuffer sb = new StringBuffer("?");
      params.forEach((key, value) {
        sb.write("$key" + "=" + "$value" + "&");
      });
      String paramStr = sb.toString();
      paramStr = paramStr.substring(0, paramStr.length - 1);
      url += paramStr;
    }

    try {
      FavoriteListData favoriteListData;
      http.Response response = await http.get(url);
      print("flutter url: " + url);
      if (json.decode(response.body) != null) {
        favoriteListData =
            new FavoriteListData.fromJson(json.decode(response.body));
      }

      return favoriteListData.result;
    } catch (e) {
      throw Exception('Failed to fetchFavoriteList');
    }
  }

  static void post(String url, Function callback,
      {String body, Function errorCallback}) async {
    try {
      http.Response response = await http.post(url,
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: body,
          encoding: Utf8Codec());
      if (callback != null) {
        callback(json.decode(response.body));
      }
    } catch (e) {
      if (errorCallback != null) {
        errorCallback(e);
      }
    }
  }

  static Future<bool> postAddFavorite(String url, {String body}) async {
    print("postAddFavorite");
    try {
      http.Response response = await http.post(url,
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: body,
          encoding: Utf8Codec());
      print("postAddFavorite return : " +
          json.decode(response.body)['result'].toString());
      return json.decode(response.body)['result'];
    } catch (e) {
      throw Exception('Failed to postAddFavorite : ' + e.toString());
    }
  }

  static Future<bool> postDelFavorite(String url, {String body}) async {
    print("postDelFavorite");
    try {
      http.Response response = await http.post(url,
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          },
          body: body,
          encoding: Utf8Codec());
      print("postDelFavorite return : " +
          json.decode(response.body)['result'].toString());
      return json.decode(response.body)['result'];
    } catch (e) {
      throw Exception('Failed to postDelFavorite: ' + e.toString());
    }
  }

  static Map<String, String> getHttpHeaders() {
    var _headers = new Map();
//    _headers["Device-Id"] = "";
//    _headers["Device-Type"] = "";
//    _headers["App-Version"] = "";
//    _headers["App-Market"] = "";
//    _headers["Network"] = "";
//    _headers["Os-Version"] = "";
//    _headers["Device-Mode"] = "";
//    _headers["Screen-Width"] = "";
//    _headers["Screen-Height"] = "";
//    _headers["Wifi"] = "";
//    _headers["Event-Source"] = "";

    return _headers;
  }
}

class NetworkConstant {
  static const OFFICAL_TENGE_DOMAIN = "http://api.shigeten.net/api";
  static const TEST_TENGE_DOMAIN = "http://test.api.shigeten.net/api";

  static const OFFICAL_IMAGE_TENGE_DOMAIN = "http://images.shigeten.net/";
  static const TEST_IMAGE_TENGE_DOMAIN = "http://api.shigeten.net/";

  static const GET_DIAGRAM_CONTENT = "/Diagram/GetDiagramContent";
  static const GET_DIAGRAM_LIST = "/Diagram/GetDiagramList";

  static const GET_NOVEL_CONTENT = "/Novel/GetNovelContent";
  static const GET_NOVEL_LIST = "/Novel/GetNovelList";

  static const GET_CRITIC_CONTENT = "/Critic/GetCriticContent";
  static const GET_CRITIC_LIST = "/Critic/GetCriticList";

  static const GET_FIRSTPAGE_AD = "/Ad/GetFirstPageAd";
  static const GET_AD_CONTENT = "/Ad/GetAdContent";

  static const GET_LOGIN = "/user/Login";
  static const POST_ADD_FAVORITE = "/user/AddFavorite";
  static const POST_DELETE_FAVORITE = "/user/DeleteFavorite";
  static const GET_FAVORITE_LIST = "/user/GetFavoriteList";

  static const GET_TIMES = "/Times/GetTimes";
}
