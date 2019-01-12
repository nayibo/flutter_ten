import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: false)
class FavoriteBean extends Object {
  int userId;
  int id;
  int type;
  int publishtime;
  String title;
  String summary;

  FavoriteBean(
      {this.userId,
      this.id,
      this.type,
      this.publishtime,
      this.title,
      this.summary});

  FavoriteBean.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap["id"];
    title = jsonMap["title"];
    publishtime = jsonMap["publishtime"];
    userId = jsonMap["userId"];
    type = jsonMap["type"];
    summary = jsonMap["summary"];
  }

  Map toJson() {
    Map map = new Map();
    map["userId"] = userId;
    map["id"] = id;
    map["type"] = type;
    map["publishtime"] = publishtime;
    map["title"] = title;
    map["summary"] = summary;
    return map;
  }
}

@JsonSerializable(nullable: false)
class FavoriteListData {
  int status;
  String errMsg;
  List<FavoriteBean> result;

  FavoriteListData();

  FavoriteListData.fromJson(Map<String, dynamic> jsonMap) {
    result = [];
    errMsg = jsonMap["errMsg"];
    status = jsonMap["status"];

    for (var item in jsonMap['result']) {
      result.add(new FavoriteBean.fromJson(item));
    }
  }
}
