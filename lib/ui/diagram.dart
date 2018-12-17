import 'package:flutter/material.dart';
import 'package:flutter_tenge/bean/ListBean.dart';
import 'package:flutter_tenge/network/NetworkUtils.dart';

class DiagramPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new DiagramPageState();
  }
}

class DiagramPageState extends State<DiagramPage> {
  ListBean listBean;
  var _title = 'empty';

  @override
  Widget build(BuildContext context) {
    _getList();

    return new Center(
      child: new Text(_title),
    );
  }

  _getList() async {
    NetworkUtils.get("http://api.shigeten.net/api/Diagram/GetDiagramList", (data) {
      if (data != null) {
        listBean = new ListBean.fromJson(data);
        setState(() {
          _title = listBean.result[0].title;
        });
      }
    }, errorCallback: (e) {
      print("network error: $e");
    });
  }
}
