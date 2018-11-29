class CriticBean {
  var status;
  var errMsg;
  var id;
  var title;
  var realtitle;
  var author;
  var authorbrief;
  var times;
  var text1;
  var text2;
  var text3;
  var text4;
  var text5;
  var image1;
  var image2;
  var image3;
  var image4;
  var image5;
  var imageforplay;
  var urlforplay;
  var titleforplay;
  var publishtime;

  CriticBean.fromJson(Map<String, dynamic> jsonMap) {
    status = jsonMap['status'];
    errMsg = jsonMap["errMsg"];
    id = jsonMap["id"];
    title = jsonMap["title"];
    realtitle = jsonMap["realtitle"];
    author = jsonMap["author"];
    times = jsonMap["times"];
    text1 = jsonMap["text1"];
    text2 = jsonMap["text2"];
    text3 = jsonMap["text3"];
    text4 = jsonMap["text4"];
    text5 = jsonMap["text5"];
    image1 = jsonMap["image1"];
    image2 = jsonMap["image2"];
    image3 = jsonMap["image3"];
    image4 = jsonMap["image4"];
    image5 = jsonMap["image5"];
    imageforplay = jsonMap["imageforplay"];
    urlforplay = jsonMap["urlforplay"];
    titleforplay = jsonMap["titleforplay"];
    publishtime = jsonMap["publishtime"];
  }
}
