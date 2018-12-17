import 'package:flutter/material.dart';
import 'package:flutter_tenge/bean/ListBean.dart';
import 'package:flutter_tenge/network/NetworkUtils.dart';
import 'package:transparent_image/transparent_image.dart';

class NovelPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new NovelPageState();
  }
}

class NovelPageState extends State<NovelPage> {
  ListBean listBean;

  @override
  Widget build(BuildContext context) {
    _getList();

    return new Center(
      child: new FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image:
            'http://e.hiphotos.baidu.com/image/pic/item/3bf33a87e950352aba22c6495e43fbf2b2118b34.jpg',
      ),
    );
  }

  _getList() async {
    NetworkUtils.get("http://api.shigeten.net/api/Novel/GetNovelList", (data) {
      if (data != null) {
        listBean = new ListBean.fromJson(data);
      }
    }, errorCallback: (e) {
      print("network error: $e");
    });
  }
}
