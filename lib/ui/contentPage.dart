import 'package:flutter/material.dart';
import 'package:flutter_tenge/ui/critic.dart';

class ContentPage extends StatefulWidget {
  ContentPage({this.type});

  String type;

  @override
  State<StatefulWidget> createState() {
    return new ContentPageState(contentType: type);
  }
}

class ContentPageState extends State<ContentPage> {
  ContentPageState({this.contentType});

  String contentType = "critic";

  @override
  Widget build(BuildContext context) {
    return new Container(
        decoration: new BoxDecoration(
            color: Color(0xE6F4F4F4),
            image: new DecorationImage(
                image: new AssetImage("assets/images/topbar.png"))),
        child: new Stack(
          children: <Widget>[
            new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Image.asset('assets/images/logo_critic.png',
                    height: 44, width: 107),
                new Expanded(
                    child: new Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Image.asset('assets/images/date_0.png',
                        height: 44, width: 20),
                    new Image.asset('assets/images/date_1.png',
                        height: 44, width: 20),
                    new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Image.asset('assets/images/week_1.png',
                            height: 20, width: 42),
                        new Row(
                          children: <Widget>[
                            new Image.asset('assets/images/month_divide.png',
                                height: 24, width: 15),
                            new Image.asset('assets/images/month_12.png',
                                height: 24, width: 27),
                          ],
                        )
                      ],
                    )
                  ],
                ))
              ],
            ),
            new CriticPage()
          ],
        ));
  }
}
