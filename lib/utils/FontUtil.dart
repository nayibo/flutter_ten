import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_tenge/constant/common.dart';
import 'package:flutter_tenge/constant/font.dart';
import 'package:flutter_tenge/constant/sp.dart';
import 'package:flutter_tenge/utils/SharedPreferencesUtil.dart';
import 'package:synchronized/synchronized.dart';

class FontUtil {
  static FontUtil _singleton;
  static int _sizeMode = FontConstant.FONT_SMALL;
  static bool _isNightMode = false;
  static Lock _lock = Lock();

  static Future<FontUtil> getInstance() async {
    if (_singleton == null) {
      await _lock.synchronized(() async {
        if (_singleton == null) {
          // 保持本地实例直到完全初始化。
          var singleton = FontUtil._();
          await singleton._init();
          _singleton = singleton;
        }
      });
    }
    return _singleton;
  }

  FontUtil._();

  Future _init() async {
    await SpUtil.getInstance();
    _sizeMode = SpUtil.getInt(SPConstant.SP_FONT);
    if (_sizeMode == null) {
      _sizeMode = FontConstant.FONT_SMALL;
    }
    _isNightMode = SpUtil.getBool(SPConstant.SP_NIGHT_MODE);
    if (_isNightMode == null) {
      _isNightMode = false;
    }
  }

  static TextStyle getContentTitleFont() {
    if (_isNightMode) {
      return new TextStyle(
          fontSize: FontConstant.FONT_CONTENT_TITLE_SIZE,
          color: Color(FontConstant.FONT_CONTENT_TITLE_COLOR_NIGHT));
    } else {
      return new TextStyle(
          fontSize: FontConstant.FONT_CONTENT_TITLE_SIZE,
          color: Color(FontConstant.FONT_CONTENT_TITLE_COLOR_DAY));
    }
  }

  static TextStyle getContentFont() {
    if (!_isNightMode) {
      switch (_sizeMode) {
        case FontConstant.FONT_SMALL:
          return new TextStyle(
              fontSize: FontConstant.FONT_CONTENT_SMALL,
              color: Color(FontConstant.FONT_CONTENT_COLOR_DAY));
          break;
        case FontConstant.FONT_MID:
          return new TextStyle(
              fontSize: FontConstant.FONT_CONTENT_MID,
              color: Color(FontConstant.FONT_CONTENT_COLOR_DAY));
          break;
        case FontConstant.FONT_BIG:
          return new TextStyle(
              fontSize: FontConstant.FONT_CONTENT_BIG,
              color: Color(FontConstant.FONT_CONTENT_COLOR_DAY));
          break;
        default:
          return new TextStyle(
              fontSize: FontConstant.FONT_CONTENT_SMALL,
              color: Color(FontConstant.FONT_CONTENT_COLOR_DAY));
      }
    } else {
      switch (_sizeMode) {
        case FontConstant.FONT_SMALL:
          return new TextStyle(
              fontSize: FontConstant.FONT_CONTENT_SMALL,
              color: Color(FontConstant.FONT_CONTENT_COLOR_NIGHT));
          break;
        case FontConstant.FONT_MID:
          return new TextStyle(
              fontSize: FontConstant.FONT_CONTENT_MID,
              color: Color(FontConstant.FONT_CONTENT_COLOR_NIGHT));
          break;
        case FontConstant.FONT_BIG:
          return new TextStyle(
              fontSize: FontConstant.FONT_CONTENT_BIG,
              color: Color(FontConstant.FONT_CONTENT_COLOR_NIGHT));
          break;
        default:
          return new TextStyle(
              fontSize: FontConstant.FONT_CONTENT_SMALL,
              color: Color(FontConstant.FONT_CONTENT_COLOR_NIGHT));
      }
    }
  }

  static TextStyle getSummaryFont() {
    if (!_isNightMode) {
      switch (_sizeMode) {
        case FontConstant.FONT_SMALL:
          return new TextStyle(
              fontSize: FontConstant.FONT_SUMMARY_SMALL,
              color: Color(FontConstant.FONT_SUMMARY_COLOR_DAY));
          break;
        case FontConstant.FONT_MID:
          return new TextStyle(
              fontSize: FontConstant.FONT_SUMMARY_MID,
              color: Color(FontConstant.FONT_SUMMARY_COLOR_DAY));
          break;
        case FontConstant.FONT_BIG:
          return new TextStyle(
              fontSize: FontConstant.FONT_SUMMARY_BIG,
              color: Color(FontConstant.FONT_SUMMARY_COLOR_DAY));
          break;
        default:
          return new TextStyle(
              fontSize: FontConstant.FONT_SUMMARY_SMALL,
              color: Color(FontConstant.FONT_SUMMARY_COLOR_DAY));
      }
    } else {
      switch (_sizeMode) {
        case FontConstant.FONT_SMALL:
          return new TextStyle(
              fontSize: FontConstant.FONT_SUMMARY_SMALL,
              color: Color(FontConstant.FONT_SUMMARY_COLOR_NIGHT));
          break;
        case FontConstant.FONT_MID:
          return new TextStyle(
              fontSize: FontConstant.FONT_SUMMARY_MID,
              color: Color(FontConstant.FONT_SUMMARY_COLOR_NIGHT));
          break;
        case FontConstant.FONT_BIG:
          return new TextStyle(
              fontSize: FontConstant.FONT_SUMMARY_BIG,
              color: Color(FontConstant.FONT_SUMMARY_COLOR_NIGHT));
          break;
        default:
          return new TextStyle(
              fontSize: FontConstant.FONT_SUMMARY_SMALL,
              color: Color(FontConstant.FONT_SUMMARY_COLOR_NIGHT));
      }
    }
  }

  static Color getBottomBarBackgroundColor() {
    if (_isNightMode) {
      return Color(FontConstant.FONT_BOTTOMBAR_BACKGROUNDCOLOR_NIGHT);
    } else {
      return Color(FontConstant.FONT_BOTTOMBAR_BACKGROUNDCOLOR_DAY);
    }
  }

  static String getBottomBarIcon(String flag) {
    if (_isNightMode) {
      switch (flag) {
        case CommonConstant.PAGE_CRITIC:
          return "assets/images/home_critic_night.png";
        case CommonConstant.PAGE_DIAGRAM:
          return "assets/images/home_diagram_night.png";
        case CommonConstant.PAGE_NOVEL:
          return "assets/images/home_novel_night.png";
        case CommonConstant.PAGE_PERSONAL:
          return "assets/images/home_personal_night.png";
        default:
          return "assets/images/home_critic_night.png";
      }
    } else {
      switch (flag) {
        case CommonConstant.PAGE_CRITIC:
          return "assets/images/home_critic.png";
        case CommonConstant.PAGE_DIAGRAM:
          return "assets/images/home_diagram.png";
        case CommonConstant.PAGE_NOVEL:
          return "assets/images/home_novel.png";
        case CommonConstant.PAGE_PERSONAL:
          return "assets/images/home_personal.png";
        default:
          return "assets/images/home_critic.png";
      }
    }
  }

  static String getBottomBarActiveIcon(String flag) {
    if (_isNightMode) {
      switch (flag) {
        case CommonConstant.PAGE_CRITIC:
          return "assets/images/home_critic_focus_night.png";
        case CommonConstant.PAGE_DIAGRAM:
          return "assets/images/home_diagram_focus_night.png";
        case CommonConstant.PAGE_NOVEL:
          return "assets/images/home_novel_focus_night.png";
        case CommonConstant.PAGE_PERSONAL:
          return "assets/images/home_personal_focus_night.png";
        default:
          return "assets/images/home_critic_focus_night.png";
      }
    } else {
      switch (flag) {
        case CommonConstant.PAGE_CRITIC:
          return "assets/images/home_critic_focus.png";
        case CommonConstant.PAGE_DIAGRAM:
          return "assets/images/home_diagram_focus.png";
        case CommonConstant.PAGE_NOVEL:
          return "assets/images/home_novel_focus.png";
        case CommonConstant.PAGE_PERSONAL:
          return "assets/images/home_personal_focus.png";
        default:
          return "assets/images/home_critic_focus.png";
      }
    }
  }

  static TextStyle getAuthorFont() {
    if (_isNightMode) {
      return new TextStyle(
          fontSize: FontConstant.FONT_AUTHOR_SIZE,
          color: Color(FontConstant.FONT_AUTHOR_COLOR_NIGHT));
    } else {
      return new TextStyle(
          fontSize: FontConstant.FONT_AUTHOR_SIZE,
          color: Color(FontConstant.FONT_AUTHOR_COLOR_DAY));
    }
  }

  static Color getAuthorVerticalLineColor() {
    if (_isNightMode) {
      return Color(FontConstant.FONT_AUTHOR_VERTICAL_LINE_COLOR_NIGHT);
    } else {
      return Color(FontConstant.FONT_AUTHOR_VERTICAL_LINE_COLOR_DAY);
    }
  }

  static Color getSummaryBackgroundColor() {
    if (_isNightMode) {
      return Color(FontConstant.FONT_SUMMARY_BACKGROUND_COLOR_NIGHT);
    } else {
      return Color(FontConstant.FONT_SUMMARY_BACKGROUND_COLOR_DAY);
    }
  }

  static TextStyle getAuthorBelowFont() {
    if (_isNightMode) {
      return new TextStyle(
          fontSize: FontConstant.FONT_AUTHOR_BELOW_SIZE,
          color: Color(FontConstant.FONT_AUTHOR_BELOW_COLOR_NIGHT),
          fontWeight: FontWeight.bold
      );
    } else {
      return new TextStyle(
          fontSize: FontConstant.FONT_AUTHOR_BELOW_SIZE,
          color: Color(FontConstant.FONT_AUTHOR_BELOW_COLOR_DAY),
          fontWeight: FontWeight.bold
      );
    }
  }

  static TextStyle getAuthorBrief() {
    return new TextStyle(
      fontSize: FontConstant.FONT_AUTHOR_BRIEF_SIZE,
      color: Color(FontConstant.FONT_AUTHOR_BRIEF_COLOR),
    );
  }
}
