import 'dart:convert';

import 'package:flutter_tenge/bean/Favorite.dart';
import 'package:flutter_tenge/bean/ListBean.dart';
import 'package:flutter_tenge/constant/data.dart';
import 'package:flutter_tenge/network/NetworkUtils.dart';
import 'package:flutter_tenge/utils/SharedPreferencesUtil.dart';
import 'package:flutter_tenge/utils/sqflite.dart';

class FavoriteUtil {
  static FavoriteUtil _singleton;
  List<FavoriteBean> _favoriteListData = new List();

  static FavoriteUtil getInstance() {
    if (_singleton == null) {
      _singleton = FavoriteUtil._();
    }

    return _singleton;
  }

  FavoriteUtil._();

  List<FavoriteBean> getFavoriteListData() {
    return _favoriteListData;
  }

  void setFavoriteListData(List<FavoriteBean> data) {
    if (data != null) {
      print("FavoriteUtil setFavoriteListData: " + data.length.toString());
      _favoriteListData = data;
    }
  }

  bool isFavorite(int id, int type) {
    if (_favoriteListData == null || _favoriteListData.length == 0) {
      return false;
    }

    for (int i = 0; i < _favoriteListData.length; i++) {
      if (_favoriteListData[i].id == id && _favoriteListData[i].type == type) {
        return true;
      }
    }
    return false;
  }

//  void fetchFavorites() async {
//    await SpUtil.getInstance();
//    if (SpUtil.getBool(SPConstant.SP_QQ_IS_LOGIN)) {
//      int _userID = SpUtil.getInt(SPConstant.SP_USER_ID);
//      Map<String, String> params = new Map();
//      params['userId'] = _userID.toString();
//      NetworkUtils.get(
//          "http://api.shigeten.net/api//user/GetFavoriteList",
//          (data) {
//            if (data != null) {
//              FavoriteUtil.getInstance().fetchFavorites();
//              FavoriteListData favoriteListData =
//                  new FavoriteListData.fromJson(data);
//              _favoriteListData = favoriteListData;
//            }
//          },
//          params: params,
//          errorCallback: (e) {
//            print("_getCritic network error: $e");
//          });
//    } else {
//      var dbHelper = DBHelper();
//      dbHelper.getFavoriteList().then((List<FavoriteBean> list) {
//        if (_favoriteListData == null) {
//          _favoriteListData = new FavoriteListData();
//        }
//        _favoriteListData.result = list;
//      });
//    }
//  }

  Future<List<FavoriteBean>> fetchFavoritesFromDatabase() async {
    print("FavoriteUtil fetchFavoritesFromDatabase");
    var dbHelper = DBHelper();
    return dbHelper.getFavoriteList();
  }

  Future<List<FavoriteBean>> fetchFavoritesFromServer() async {
    print("FavoriteUtil fetchFavoritesFromServer");
    int _userID = SpUtil.getInt(SPConstant.SP_USER_ID);
    Map<String, String> params = new Map();
    params['userId'] = _userID.toString();
    return NetworkUtils.fetchFavoriteList(
        "http://api.shigeten.net/api/user/GetFavoriteList",
        params: params);
  }

  Future<List<FavoriteBean>> fetchFavorites() async {
    print("FavoriteUtil fetchFavorites");
    await SpUtil.getInstance();
    bool _isLogin = SpUtil.getBool(SPConstant.SP_QQ_IS_LOGIN);

    if (_isLogin == null) {
      _isLogin = false;
    }

    if (_isLogin) {
      return fetchFavoritesFromServer();
    } else {
      return fetchFavoritesFromDatabase();
    }
  }

  Future<List<FavoriteBean>> favorite(ListItem listItem) async {
    print("FavoriteUtil favorite");
    if (!FavoriteUtil.getInstance().isFavorite(listItem.id, listItem.type)) {
      await _addFavorite(listItem);
    } else {
      await _delFavorite(listItem);
    }
    return FavoriteUtil.getInstance().fetchFavorites();
  }

  _addFavorite(ListItem listItem) async {
    print("FavoriteUtil _addFavorite");
    await SpUtil.getInstance();
    bool _isLogin;
    _isLogin = SpUtil.getBool(SPConstant.SP_QQ_IS_LOGIN);
    if (_isLogin) {
      await _addFavoriteServer(listItem);
    } else {
      await _addFavoriteDB(listItem);
    }
  }

  _delFavorite(ListItem listItem) async {
    print("FavoriteUtil _delFavorite");
    await SpUtil.getInstance();
    bool _isLogin;
    _isLogin = SpUtil.getBool(SPConstant.SP_QQ_IS_LOGIN);
    if (_isLogin) {
      await _delFavoriteServer(listItem);
    } else {
      await _delFavoriteDB(listItem);
    }
  }

  _addFavoriteDB(ListItem listItem) async {
    print("FavoriteUtil _addFavoriteDB");
    var dbHelper = DBHelper();
    FavoriteBean favoriteBean = new FavoriteBean(
        id: listItem.id,
        title: listItem.title,
        type: listItem.type,
        summary: listItem.summary,
        publishtime: listItem.publishtime);
    dbHelper.insertFavorite(favoriteBean);
//    dbHelper.getFavoriteList();
  }

  _delFavoriteDB(ListItem listItem) async {
    print("FavoriteUtil _delFavoriteDB");
    var dbHelper = DBHelper();
    dbHelper.deleteFavorite(listItem.id.toString(), listItem.type.toString());
//    dbHelper.getFavoriteList();
  }

  _addFavoriteServer(ListItem listItem) async {
    print("FavoriteUtil _addFavoriteServer");
    FavoriteBean favoriteBean = new FavoriteBean(
        userId: SpUtil.getInt(SPConstant.SP_USER_ID),
        id: listItem.id,
        title: listItem.title,
        type: listItem.type,
        summary: listItem.summary,
        publishtime: listItem.publishtime);

    List<FavoriteBean> favList = new List();
    favList.add(favoriteBean);

    await NetworkUtils.postAddFavorite(
        "http://api.shigeten.net/api/user/AddFavorite",
        body: json.encode(favList));
  }

  _delFavoriteServer(ListItem listItem) async {
    print("FavoriteUtil _delFavoriteServer");
    FavoriteBean favoriteBean = new FavoriteBean(
        userId: SpUtil.getInt(SPConstant.SP_USER_ID),
        id: listItem.id,
        title: listItem.title,
        type: listItem.type,
        summary: listItem.summary,
        publishtime: listItem.publishtime);

    await NetworkUtils.postDelFavorite(
        "http://api.shigeten.net/api/user/DeleteFavorite",
        body: json.encode(favoriteBean));
  }
}
