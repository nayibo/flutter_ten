import 'package:flutter/material.dart';

class ShareIcon extends StatefulWidget {
  ShareIconState _state  = new ShareIconState();
  @override
  State<StatefulWidget> createState() {
    return _state;
  }

  refresh(double level) {
    _state.refresh(level);
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
          child: new Image.asset('assets/images/more.png',
              height: 46.0, width: 46.0)),
    );
  }

  refresh(double level) {
    if (this.mounted) {
      setState(() {
        _opacityLevel = level;
      });
    }
  }
}
