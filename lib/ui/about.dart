import 'package:flutter/material.dart';
import 'package:flutter_tenge/ui/title.dart';
import 'package:flutter_tenge/utils/FontUtil.dart';
import 'package:package_info/package_info.dart';

class AboutPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new AboutPageState();
  }
}

class AboutPageState extends State<AboutPage> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  @override
  void initState() {
    _initPackageInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: FontUtil.getMainBgColor(),
        body: new Container(
          child: new Stack(
            children: <Widget>[
              new TitleBar(
                  title: '关于十个',
                  pressed: () {
                    Navigator.of(context).pop();
                  }),
              new Container(
                  alignment: Alignment.center,
                  child: new Image.asset(FontUtil.getAboutBg())),
              new Container(
                margin: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 30.0),
                alignment: Alignment.bottomCenter,
                child: new Text('Ten V' + _packageInfo.version, style: new TextStyle(fontSize: 14.0, color: FontUtil.getSettingVersionColor())),
              )
            ],
          ),
        ));
  }

  Future<void> _initPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }
}
