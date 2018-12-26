import 'package:flutter/material.dart';
import 'package:flutter_tenge/constant/common.dart';
import 'package:flutter_tenge/ui/callback.dart';
import 'package:flutter_tenge/utils/DateUtil.dart';
import 'package:flutter_tenge/utils/FontUtil.dart';

class HomepageHeader extends StatefulWidget {
  HomepageHeaderState _state = new HomepageHeaderState();
  ScrollToNextPageCallback clickCallback;
  String type = CommonConstant.PAGE_CRITIC;

  HomepageHeader({this.type, this.clickCallback});

  @override
  State<StatefulWidget> createState() {
    return _state;
  }

  refresh(int publishtime) {
    _state.refresh(publishtime);
  }
}

class HomepageHeaderState extends State<HomepageHeader> {
  int _date0 = 0;
  int _date1 = 0;
  int _month = DateTime.january;
  int _weekday = DateTime.monday;

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 44.0,
      color: Color(0xE6F4F4F4),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Image.asset(FontUtil.getHeaderLogoIcon(widget.type),
              height: 44, width: 107),
          new Expanded(
              child: new Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Image.asset(FontUtil.getDateIcon(_date0),
                  height: 44, width: 20),
              new Image.asset(FontUtil.getDateIcon(_date1),
                  height: 44, width: 20),
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Image.asset(FontUtil.getWeekDayIcon(_weekday),
                      height: 20, width: 42),
                  new Row(
                    children: <Widget>[
                      new Image.asset(FontUtil.getMonthDivider(),
                          height: 24, width: 15),
                      new Image.asset(FontUtil.getMonthIcon(_month),
                          height: 24, width: 27),
                    ],
                  )
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  refresh(int publishtime) {
    if (this.mounted) {
      setState(() {
        DateTime dateTime = DateUtil.getDateTimeByMs(
            DateUtil.formatCSharpMiliSecondtoMiliSecond(publishtime));
        _date0 = (dateTime.day / 10).floor();
        _date1 = dateTime.day % 10;
        _month = dateTime.month;
        _weekday = dateTime.weekday;
      });
    }
  }
}
