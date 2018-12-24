class DiagramBean {
  var id;
  var title;
  var author;
  var authorbrief;
  var text1;
  var image1;
  var text2;
  var times;
  var publishtime;

  DiagramBean.fromJson(Map<String, dynamic> jsonMap) {
    id = jsonMap["id"];
    title = jsonMap["title"];
    author = jsonMap["author"];
    authorbrief = jsonMap["authorbrief"];
    text1 = jsonMap["text1"];
    image1 = jsonMap["image1"];
    text2 = jsonMap["text2"];
    times = jsonMap["times"];
    publishtime = jsonMap["publishtime"];
  }
}