class FavoriteBean {
  int userId;
  int id;
  int type;
  int publishtime;
  String title;
  String summary;

  FavoriteBean({this.userId, this.id, this.type, this.publishtime, this.title,
      this.summary});

  FavoriteBean.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap["id"];
    title = jsonMap["title"];
    publishtime = jsonMap["publishtime"];
    userId = jsonMap["userId"];
    type = jsonMap["type"];
    summary = jsonMap["summary"];
  }
}

class FavoriteListData {
  int status;
  String errMsg;
  List<FavoriteBean> result;
}
