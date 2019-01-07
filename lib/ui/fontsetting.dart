import 'package:flutter/material.dart';
import 'package:flutter_tenge/ui/title.dart';

class FontSettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        body: new Container(
          child: new Column(
            children: <Widget>[
              new TitleBar(
                  title: '字体设置',
                  pressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          ),
        ));
  }
}
