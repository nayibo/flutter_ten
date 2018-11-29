class ListBean {
  List<ListItem> result;
  int status;
  String errMsg;

  ListBean.fromJson(Map<String, dynamic> jsonMap) {
    status = jsonMap['status'];
    errMsg = jsonMap["errMsg"];
    result = [];

    for (var item in jsonMap['result']) {
      result.add(new ListItem.fromJson(item));
    }
  }
}

class ListItem {
  int id;
  int type;
  int publishtime;
  String title;
  String summary;

  ListItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    publishtime = json['publishtime'];
    title = json['title'];
    summary = json['summary'];
  }
}
