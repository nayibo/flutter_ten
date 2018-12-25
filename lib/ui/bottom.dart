import 'package:flutter/material.dart';
import 'package:flutter_tenge/constant/common.dart';
import 'package:flutter_tenge/utils/FontUtil.dart';

typedef BottomClickCallback = void Function(int index);

class HomepageBottomBar extends StatefulWidget {
  HomepageBottomBarState _state  = new HomepageBottomBarState();
  BottomClickCallback clickCallback;

  HomepageBottomBar({this.clickCallback});

  @override
  State<StatefulWidget> createState() {
    return _state;
  }

  refresh(double level) {
    _state.refresh(level);
  }
}

class HomepageBottomBarState extends State<HomepageBottomBar> {
  int _page = 0;
  double _opacityLevel = 1.0;

  @override
  Widget build(BuildContext context) {
    return new Container(
        alignment: new Alignment(0.0, 1.0),
        child: new AnimatedOpacity(
            opacity: _opacityLevel,
            duration: new Duration(milliseconds: 500),
            child: new Container(
              child: new Theme(
                data: Theme.of(context).copyWith(
                  // sets the background color of the `BottomNavigationBar`
                    canvasColor:
                    FontUtil.getBottomBarBackgroundColor(),
                    // sets the active color of the `BottomNavigationBar` if `Brightness` is light
                    primaryColor: Colors.red,
                    textTheme: Theme
                        .of(context)
                        .textTheme
                        .copyWith(
                        caption:
                        new TextStyle(color: Colors.yellow))),
                // sets the inactive color of the `BottomNavigationBar`
                child: new BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  items: [
                    new BottomNavigationBarItem(
                        icon: new Image.asset(
                            FontUtil.getBottomBarIcon(
                                CommonConstant.PAGE_CRITIC),
                            height: 35.0),
                        activeIcon: new Image.asset(
                            FontUtil.getBottomBarActiveIcon(
                                CommonConstant.PAGE_CRITIC),
                            height: 35.0),
                        title: Container(height: 0.0)),
                    new BottomNavigationBarItem(
                        icon: new Image.asset(
                            FontUtil.getBottomBarIcon(
                                CommonConstant.PAGE_DIAGRAM),
                            height: 35.0),
                        activeIcon: new Image.asset(
                            FontUtil.getBottomBarActiveIcon(
                                CommonConstant.PAGE_DIAGRAM),
                            height: 35.0),
                        title: Container(height: 0.0)),
                    new BottomNavigationBarItem(
                        icon: new Image.asset(
                            FontUtil.getBottomBarIcon(
                                CommonConstant.PAGE_NOVEL),
                            height: 35.0),
                        activeIcon: new Image.asset(
                            FontUtil.getBottomBarActiveIcon(
                                CommonConstant.PAGE_NOVEL),
                            height: 35.0),
                        title: Container(height: 0.0)),
                    new BottomNavigationBarItem(
                        icon: new Image.asset(
                            FontUtil.getBottomBarIcon(
                                CommonConstant.PAGE_PERSONAL),
                            height: 35.0),
                        activeIcon: new Image.asset(
                            FontUtil.getBottomBarActiveIcon(
                                CommonConstant.PAGE_PERSONAL),
                            height: 35.0),
                        title: Container(height: 0.0)),
                  ],
                  currentIndex: _page,
                  onTap: (int index) {
                    setState(() {
                      _page = index;
                    });
                    if (widget.clickCallback != null) {
                      widget.clickCallback(index);
                    }
                  },
                ),
              ),
            )
        )
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
