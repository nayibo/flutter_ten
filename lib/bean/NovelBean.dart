class NovelBean {
  var id;
  var title;
  var author;
  var authorbrief;
  var times;
  var summary;
  var text;
  var image;
  var publishtime;

  NovelBean.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap["id"];
    title = jsonMap["title"];
    author = jsonMap["author"];
    authorbrief = jsonMap["authorbrief"];
    times = jsonMap["times"];
    summary = jsonMap["summary"];
    text = jsonMap["text"];
    image = jsonMap["image"];
    publishtime = jsonMap["publishtime"];
  }
}