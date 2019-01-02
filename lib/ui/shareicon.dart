import 'package:flutter/material.dart';
import 'package:flutter_tenge/bean/ListBean.dart';
import 'package:flutter_tenge/ui/share.dart';

class ShareIcon extends StatefulWidget {
  ShareIconState _state = new ShareIconState();
  int _currentPageIndex = 0;
  ListBean _listBean;

  @override
  State<StatefulWidget> createState() {
    return _state;
  }

  refresh(double level) {
    _state.refresh(level);
  }

  setShareData(int index, ListBean listbean) {
    _currentPageIndex = index;
    _listBean = listbean;
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
          return new ShareDialog(
              currentIndex: widget._currentPageIndex, listBean: widget._listBean);
        });
  }
}
