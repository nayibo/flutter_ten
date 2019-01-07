import 'package:flutter/material.dart';
import 'package:flutter_tenge/bean/ListBean.dart';
import 'package:flutter_tenge/constant/common.dart';
import 'package:flutter_tenge/ui/critic.dart';
import 'package:flutter_tenge/ui/diagram.dart';
import 'package:flutter_tenge/ui/novel.dart';
import 'package:flutter_tenge/ui/shareicon.dart';
import 'package:flutter_tenge/ui/title.dart';

class FavoriteDetailPage extends StatefulWidget {
  ListItem listItem;

  FavoriteDetailPage({this.listItem});

  @override
  State<StatefulWidget> createState() {
    return new FavoriteDetailPageState(id: listItem.id);
  }
}

class FavoriteDetailPageState extends State<FavoriteDetailPage> {
  int id;
  ShareIcon shareIcon;
  FavoriteDetailPageState({this.id});

  @override
  void initState() {
    super.initState();
    shareIcon = new ShareIcon();
    shareIcon.setShareData(widget.listItem);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        body: new Stack(
          children: <Widget>[
            new Column(
              children: <Widget>[
                new TitleBar(
                    title: _getTitleString(),
                    pressed: () {
                      Navigator.of(context).pop();
                    }),
                new Expanded(
                  child: _getBody(),
                )
              ],
            ),
            shareIcon,
          ],
        ));
  }

  String _getTitleString() {
    switch (widget.listItem.type) {
      case CommonConstant.TYPE_FILM_CRITIC:
        return '影评';
        break;
      case CommonConstant.TYPE_NOVEL:
        return '文章';
        break;
      case CommonConstant.TYPE_BEAUTY_DIAGRAM:
        return '美图';
        break;
      default:
        return '影评';
        break;
    }
  }

  Widget _getBody() {
    switch (widget.listItem.type) {
      case CommonConstant.TYPE_FILM_CRITIC:
        return new CriticItem(id: id, scrollController: new ScrollController());
        break;
      case CommonConstant.TYPE_NOVEL:
        return new NovelItem(id: id, scrollController: new ScrollController());
        break;
      case CommonConstant.TYPE_BEAUTY_DIAGRAM:
        return new DiagramItem(
            id: id, scrollController: new ScrollController());
        break;
      default:
        return new CriticItem(id: id, scrollController: new ScrollController());
        break;
    }
  }
}
