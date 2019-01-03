import 'package:flutter/material.dart';
import 'package:flutter_tenge/bean/ListBean.dart';
import 'package:flutter_tenge/ui/share.dart';
import 'package:flutter_tenge/utils/sqflite.dart';

class ShareIcon extends StatefulWidget {
  ShareIconState _state = new ShareIconState();
  ListItem _listItem;
  bool _isFavorite = false;

  @override
  State<StatefulWidget> createState() {
    return _state;
  }

  refresh(double level) {
    _state.refresh(level);
  }

  setShareData(ListItem listItem) {
    _listItem = listItem;
    _getIsFavorite();
  }

  _getIsFavorite() {
    var dbHelper = DBHelper();
    Future<bool> result =
    dbHelper.isFavorite(_listItem.id.toString(), _listItem.type.toString());
    result.then((value) {
      _isFavorite = value;
    });
  }
}

class ShareIconState extends State<ShareIcon> {
  double _opacityLevel = 1.0;

  @override
  Widget build(BuildContext context) {
    return new Container(
        alignment: new Alignment(0.90, 0.72),
        child: new AnimatedOpacity(
            opacity: _opacityLevel,
            duration: new Duration(milliseconds: 500),
            child: new IconButton(
                iconSize: 46.0,
                onPressed: _showShareDialog,
                icon: new Image.asset('assets/images/more.png',
                    height: 46.0, width: 46.0))));
  }

  refresh(double level) {
    if (this.mounted) {
      setState(() {
        _opacityLevel = level;
      });
    }
  }

  Future<void> _showShareDialog() {
    return showDialog<Null>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return new ShareDialog(listItem: widget._listItem, isFavorite: widget._isFavorite,);
        });
  }
}
