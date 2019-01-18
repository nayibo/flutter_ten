import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_tenge/constant/common.dart';
import 'package:flutter_tenge/constant/data.dart';
import 'package:flutter_tenge/constant/font.dart';
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
          print("sp_init_begin");
          print("FontUtil_init_begin");
          var singleton = FontUtil._();
          await singleton._init();
          print("sp_init_complete");
          _singleton = singleton;
          print('FontUtil init complete');
        }
      });
    }
    return _singleton;
  }

  FontUtil._();

  Future _init() async {
    await SpUtil.getInstance();
    _sizeMode = SpUtil.getInt(SPConstant.SP_FONT);
    print('sizemode: ' + _sizeMode.toString());
    if (_sizeMode == null) {
      _sizeMode = FontConstant.FONT_SMALL;
    }
    _isNightMode = SpUtil.getBool(SPConstant.SP_NIGHT_MODE);
    print('night: ' + _isNightMode.toString());
    if (_isNightMode == null) {
      _isNightMode = false;
    }
  }

  static bool isReady() {
    return _singleton != null;
  }

  static Future<bool> setNightModel(bool flag) async {
    _isNightMode = flag;
    return SpUtil.putBool(SPConstant.SP_NIGHT_MODE, flag);
  }

  static Future<bool> setFontSizeMode(int flag) async {
    _sizeMode = flag;
    return SpUtil.putInt(SPConstant.SP_FONT, flag);
  }

  static bool getNightMode() {
    return _isNightMode;
  }

  static int getSizeMode() {
    return _sizeMode;
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

  static TextStyle getSummaryFontWithMode(int mode) {
    if (!_isNightMode) {
      switch (mode) {
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
      switch (mode) {
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
          fontWeight: FontWeight.bold);
    } else {
      return new TextStyle(
          fontSize: FontConstant.FONT_AUTHOR_BELOW_SIZE,
          color: Color(FontConstant.FONT_AUTHOR_BELOW_COLOR_DAY),
          fontWeight: FontWeight.bold);
    }
  }

  static TextStyle getAuthorBrief() {
    return new TextStyle(
      fontSize: FontConstant.FONT_AUTHOR_BRIEF_SIZE,
      color: Color(FontConstant.FONT_AUTHOR_BRIEF_COLOR),
    );
  }

  static Color getLoginBackgroundColor() {
    if (_isNightMode) {
      return Color(FontConstant.FONT_LOGIN_BACKGROUND_COLOR_NIGHT);
    } else {
      return Color(FontConstant.FONT_LOGIN_BACKGROUND_COLOR_DAY);
    }
  }

  static TextStyle getUserNameFont() {
    if (_isNightMode) {
      return new TextStyle(
        fontSize: FontConstant.FONT_USERNAME_SIZE,
        color: Color(FontConstant.FONT_USERNAME_COLOR_NIGHT),
      );
    } else {
      return new TextStyle(
        fontSize: FontConstant.FONT_USERNAME_SIZE,
        color: Color(FontConstant.FONT_USERNAME_COLOR_DAY),
      );
    }
  }

  static String getFavoriteIcon() {
    if (_isNightMode) {
      return 'assets/images/setting_favorite_night.png';
    } else {
      return 'assets/images/setting_favorite.png';
    }
  }

  static String getFontIcon() {
    if (_isNightMode) {
      return 'assets/images/setting_font_night.png';
    } else {
      return 'assets/images/setting_font.png';
    }
  }

  static String getAboutUsIcon() {
    if (_isNightMode) {
      return 'assets/images/setting_aboutus_night.png';
    } else {
      return 'assets/images/setting_aboutus.png';
    }
  }

  static String getFeedbackIcon() {
    if (_isNightMode) {
      return 'assets/images/setting_feedback_night.png';
    } else {
      return 'assets/images/setting_feedback.png';
    }
  }

  static String getNightModeIcon() {
    if (_isNightMode) {
      return 'assets/images/setting_nightmodel_night.png';
    } else {
      return 'assets/images/setting_nightmodel.png';
    }
  }

  static String getSettingArrowIcon() {
    if (_isNightMode) {
      return 'assets/images/setting_arrow_night.png';
    } else {
      return 'assets/images/setting_arrow.png';
    }
  }

  static TextStyle getSettingItemFont() {
    if (_isNightMode) {
      return new TextStyle(
          fontSize: FontConstant.FONT_SETTING_ITEM_SIZE,
          color: Color(FontConstant.FONT_CONTENT_TITLE_COLOR_NIGHT));
    } else {
      return new TextStyle(
          fontSize: FontConstant.FONT_SETTING_ITEM_SIZE,
          color: Color(FontConstant.FONT_CONTENT_TITLE_COLOR_DAY));
    }
  }

  static Color getLineShixinColor() {
    if (_isNightMode) {
      return Color(FontConstant.FONT_LINE_SHIXIN_COLOR_NIGHT);
    } else {
      return Color(FontConstant.FONT_LINE_SHIXIN_COLOR_DAY);
    }
  }

  static String getHeaderLogoIcon(String pageType) {
    switch (pageType) {
      case CommonConstant.PAGE_CRITIC:
        if (_isNightMode) {
          return 'assets/images/logo_critic_night.png';
        } else {
          return 'assets/images/logo_critic.png';
        }
        break;
      case CommonConstant.PAGE_NOVEL:
        if (_isNightMode) {
          return 'assets/images/logo_novel_night.png';
        } else {
          return 'assets/images/logo_novel.png';
        }
        break;
      case CommonConstant.PAGE_DIAGRAM:
        if (_isNightMode) {
          return 'assets/images/logo_diagram_night.png';
        } else {
          return 'assets/images/logo_diagram.png';
        }
        break;
      default:
        if (_isNightMode) {
          return 'assets/images/logo_critic_night.png';
        } else {
          return 'assets/images/logo_critic.png';
        }
    }
  }

  static String getDateIcon(int date) {
    if (_isNightMode) {
      switch (date) {
        case 0:
          return 'assets/images/2date_1_night.png';
          break;
        case 1:
          return 'assets/images/date_1_night.png';
          break;
        case 2:
          return 'assets/images/date_2_night.png';
          break;
        case 3:
          return 'assets/images/date_3_night.png';
          break;
        case 4:
          return 'assets/images/date_4_night.png';
          break;
        case 5:
          return 'assets/images/date_5_night.png';
          break;
        case 6:
          return 'assets/images/date_6_night.png';
          break;
        case 7:
          return 'assets/images/date_7_night.png';
          break;
        case 8:
          return 'assets/images/date_8_night.png';
          break;
        case 9:
          return 'assets/images/date_9_night.png';
          break;
        default:
          return 'assets/images/date_0_night.png';
      }
    } else {
      switch (date) {
        case 0:
          return 'assets/images/date_0.png';
          break;
        case 1:
          return 'assets/images/date_1.png';
          break;
        case 2:
          return 'assets/images/date_2.png';
          break;
        case 3:
          return 'assets/images/date_3.png';
          break;
        case 4:
          return 'assets/images/date_4.png';
          break;
        case 5:
          return 'assets/images/date_5.png';
          break;
        case 6:
          return 'assets/images/date_6.png';
          break;
        case 7:
          return 'assets/images/date_7.png';
          break;
        case 8:
          return 'assets/images/date_8.png';
          break;
        case 9:
          return 'assets/images/date_9.png';
          break;
        default:
          return 'assets/images/date_0.png';
      }
    }
  }

  static String getMonthIcon(int month) {
    if (_isNightMode) {
      switch (month) {
        case DateTime.january:
          return 'assets/images/month_1_night.png';
          break;
        case DateTime.february:
          return 'assets/images/month_2_night.png';
          break;
        case DateTime.march:
          return 'assets/images/month_3_night.png';
          break;
        case DateTime.april:
          return 'assets/images/month_4_night.png';
          break;
        case DateTime.may:
          return 'assets/images/month_5_night.png';
          break;
        case DateTime.june:
          return 'assets/images/month_6_night.png';
          break;
        case DateTime.july:
          return 'assets/images/month_7_night.png';
          break;
        case DateTime.august:
          return 'assets/images/month_8_night.png';
          break;
        case DateTime.september:
          return 'assets/images/month_9_night.png';
          break;
        case DateTime.october:
          return 'assets/images/month_10_night.png';
          break;
        case DateTime.november:
          return 'assets/images/month_11_night.png';
          break;
        case DateTime.december:
          return 'assets/images/month_12_night.png';
          break;
        default:
          return 'assets/images/month_1_night.png';
      }
    } else {
      switch (month) {
        case DateTime.january:
          return 'assets/images/month_1.png';
          break;
        case DateTime.february:
          return 'assets/images/month_2.png';
          break;
        case DateTime.march:
          return 'assets/images/month_3.png';
          break;
        case DateTime.april:
          return 'assets/images/month_4.png';
          break;
        case DateTime.may:
          return 'assets/images/month_5.png';
          break;
        case DateTime.june:
          return 'assets/images/month_6.png';
          break;
        case DateTime.july:
          return 'assets/images/month_7.png';
          break;
        case DateTime.august:
          return 'assets/images/month_8.png';
          break;
        case DateTime.september:
          return 'assets/images/month_9.png';
          break;
        case DateTime.october:
          return 'assets/images/month_10.png';
          break;
        case DateTime.november:
          return 'assets/images/month_11.png';
          break;
        case DateTime.december:
          return 'assets/images/month_12.png';
          break;
        default:
          return 'assets/images/month_1.png';
      }
    }
  }

  static String getWeekDayIcon(int weekDay) {
    if (_isNightMode) {
      switch (weekDay) {
        case DateTime.monday:
          return 'assets/images/week_1_night.png';
          break;
        case DateTime.tuesday:
          return 'assets/images/week_2_night.png';
          break;
        case DateTime.wednesday:
          return 'assets/images/week_3_night.png';
          break;
        case DateTime.thursday:
          return 'assets/images/week_4_night.png';
          break;
        case DateTime.friday:
          return 'assets/images/week_5_night.png';
          break;
        case DateTime.saturday:
          return 'assets/images/week_6_night.png';
          break;
        case DateTime.sunday:
          return 'assets/images/week_7_night.png';
          break;
        default:
          return 'assets/images/week_0_night.png';
      }
    } else {
      switch (weekDay) {
        case DateTime.monday:
          return 'assets/images/week_1.png';
          break;
        case DateTime.tuesday:
          return 'assets/images/week_2.png';
          break;
        case DateTime.wednesday:
          return 'assets/images/week_3.png';
          break;
        case DateTime.thursday:
          return 'assets/images/week_4.png';
          break;
        case DateTime.friday:
          return 'assets/images/week_5.png';
          break;
        case DateTime.saturday:
          return 'assets/images/week_6.png';
          break;
        case DateTime.sunday:
          return 'assets/images/week_7.png';
          break;
        default:
          return 'assets/images/week_1.png';
      }
    }
  }

  static String getMonthDivider() {
    if (_isNightMode) {
      return 'assets/images/month_divide_night.png';
    } else {
      return 'assets/images/month_divide.png';
    }
  }

  static String getShareDialogFavoriteIcon(bool isFavorite) {
    if (isFavorite) {
      if (_isNightMode) {
        return 'assets/images/share_favorite_selected_night.png';
      } else {
        return 'assets/images/share_favorite_selected.png';
      }
    } else {
      if (_isNightMode) {
        return 'assets/images/share_favorite_night.png';
      } else {
        return 'assets/images/share_favorite.png';
      }
    }
  }

  static String getShareDialogWeixinIcon() {
    if (_isNightMode) {
      return 'assets/images/share_weixin_night.png';
    } else {
      return 'assets/images/share_weixin.png';
    }
  }

  static String getShareDialogPengyouquanIcon() {
    if (_isNightMode) {
      return 'assets/images/share_pengyouquan_night.png';
    } else {
      return 'assets/images/share_pengyouquan.png';
    }
  }

  static String getShareDialogWeiboIcon() {
    if (_isNightMode) {
      return 'assets/images/share_weibo_night.png';
    } else {
      return 'assets/images/share_weibo.png';
    }
  }

  static String getShareDialogQQIcon() {
    if (_isNightMode) {
      return 'assets/images/share_qq_bound_night.png';
    } else {
      return 'assets/images/share_qq_bound.png';
    }
  }

  static String getShareDialogQQZONEIcon() {
    if (_isNightMode) {
      return 'assets/images/share_qqzone_bound_night.png';
    } else {
      return 'assets/images/share_qqzone_bound.png';
    }
  }

  static String getShareIcon(String type, bool isFavorite) {
    switch (type) {
      case CommonConstant.SHARE_TYPE_FAVORITE:
        return getShareDialogFavoriteIcon(isFavorite);
        break;
      case CommonConstant.SHARE_TYPE_WEIXIN:
        return getShareDialogWeixinIcon();
        break;
      case CommonConstant.SHARE_TYPE_PENGYOUQUAN:
        return getShareDialogPengyouquanIcon();
        break;
      case CommonConstant.SHARE_TYPE_WEIBO:
        return getShareDialogWeiboIcon();
        break;
      case CommonConstant.SHARE_TYPE_QQ:
        return getShareDialogQQIcon();
        break;
      case CommonConstant.SHARE_TYPE_QQZONE:
        return getShareDialogQQZONEIcon();
        break;
      default:
        return getShareDialogFavoriteIcon(isFavorite);
    }
  }

  static Color getTitleBarBackgroundColor() {
    if (_isNightMode) {
      return Color(FontConstant.FONT_TITLE_BACKGROUND_COLOR_NIGHT);
    } else {
      return Color(FontConstant.FONT_TITLE_BACKGROUND_COLOR_DAY);
    }
  }

  static String getTitleBarBackIcon() {
    if (_isNightMode) {
      return 'assets/images/back_night.png';
    } else {
      return 'assets/images/back.png';
    }
  }

  static Color getTitleColor() {
    if (_isNightMode) {
      return Color(FontConstant.FONT_TITLE_COLOR_NIGHT);
    } else {
      return Color(FontConstant.FONT_TITLE_COLOR_DAY);
    }
  }

  static Color getArticleBgColor(int type) {
    switch (type) {
      case CommonConstant.TYPE_FILM_CRITIC:
        return Color(FontConstant.FONT_ARTICLE_BACKGROUND_COLOR_FILM);
        break;
      case CommonConstant.TYPE_NOVEL:
        if (_isNightMode) {
          return Color(FontConstant.FONT_ARTICLE_BACKGROUND_COLOR_NIGHT);
        } else {
          return Color(FontConstant.FONT_ARTICLE_BACKGROUND_COLOR_DAY);
        }
        break;
      case CommonConstant.TYPE_BEAUTY_DIAGRAM:
        return Color(FontConstant.FONT_ARTICLE_BACKGROUND_COLOR_DIAGRAM);
        break;
      default:
        return Color(FontConstant.FONT_ARTICLE_BACKGROUND_COLOR_FILM);
        break;
    }
  }

  static Color getFeedbackFontColor() {
    if (_isNightMode) {
      return Color(FontConstant.FONT_FEEDBACK_COLOR_NIGHT);
    } else {
      return Color(FontConstant.FONT_FEEDBACK_COLOR_DAY);
    }
  }

  static Color getFavoriteDateTvColor() {
    if (_isNightMode) {
      return Color(FontConstant.FONT_FAVORITEDATETV_COLOR_NIGHT);
    } else {
      return Color(FontConstant.FONT_FAVORITEDATETV_COLOR_DAY);
    }
  }

  static Color getFavoriteTitleColor() {
    if (_isNightMode) {
      return Color(FontConstant.FONT_FAVORITETITLE_COLOR_NIGHT);
    } else {
      return Color(FontConstant.FONT_FAVORITETITLE_COLOR_DAY);
    }
  }

  static Color getFavoriteSummaryColor() {
    if (_isNightMode) {
      return Color(FontConstant.FONT_FAVORITESUMMART_COLOR_NIGHT);
    } else {
      return Color(FontConstant.FONT_FAVORITESUMMART_COLOR_DAY);
    }
  }

  static String getAboutBg() {
    if (_isNightMode) {
      return 'assets/images/about_us_bg_night.png';
    } else {
      return 'assets/images/about_us_bg.png';
    }
  }

  static Color getMainBgColor() {
    if (_isNightMode) {
      return Color(FontConstant.FONT_MAIN_BACKGROUND_COLOR_NIGHT);
    } else {
      return Color(FontConstant.FONT_MAIN_BACKGROUND_COLOR_DAY);
    }
  }

  static Color getStatusBarBgColor() {
    if (_isNightMode) {
      return Color(FontConstant.FONT_MAIN_BACKGROUND_COLOR_NIGHT);
    } else {
      return Colors.transparent;
    }
  }

  static String getWechatIcon() {
    if (_isNightMode) {
      return 'assets/images/feedback_weixin_night.png';
    } else {
      return 'assets/images/feedback_weixin.png';
    }
  }

  static String getQQIcon() {
    if (_isNightMode) {
      return 'assets/images/feedback_qq_night.png';
    } else {
      return 'assets/images/feedback_qq.png';
    }
  }

  static String getFontSizeSmallIcon() {
    if (_sizeMode == FontConstant.FONT_SMALL) {
      if (_isNightMode) {
        return 'assets/images/fontsize_s_selected_night.png';
      } else {
        return 'assets/images/fontsize_s_selected.png';
      }
    } else {
      if (_isNightMode) {
        return 'assets/images/fontsize_s_night.png';
      } else {
        return 'assets/images/fontsize_s.png';
      }
    }
  }

  static String getFontSizeMidIcon() {
    if (_sizeMode == FontConstant.FONT_MID) {
      if (_isNightMode) {
        return 'assets/images/fontsize_m_selected_night.png';
      } else {
        return 'assets/images/fontsize_m_selected.png';
      }
    } else {
      if (_isNightMode) {
        return 'assets/images/fontsize_m_night.png';
      } else {
        return 'assets/images/fontsize_m.png';
      }
    }
  }

  static String getFontSizeBigIcon() {
    if (_sizeMode == FontConstant.FONT_BIG) {
      if (_isNightMode) {
        return 'assets/images/fontsize_l_selected_night.png';
      } else {
        return 'assets/images/fontsize_l_selected.png';
      }
    } else {
      if (_isNightMode) {
        return 'assets/images/fontsize_l_night.png';
      } else {
        return 'assets/images/fontsize_l.png';
      }
    }
  }

  static Color getFontNormalSizeColor() {
    if (_isNightMode) {
      return Color(FontConstant.FONT_SIZE_NORMAL_COLOR_NIGHT);
    } else {
      return Color(FontConstant.FONT_SIZE_NORMAL_COLOR_DAY);
    }
  }

  static String getLoginAvatarIcon() {
    if (_isNightMode) {
      return 'assets/images/avator_login_night.png';
    } else {
      return 'assets/images/avator_login.png';
    }
  }

  static String getWhiteLine() {
    if (_isNightMode) {
      return 'assets/images/avator_whiteline_night.png';
    } else {
      return 'assets/images/avator_whiteline.png';
    }
  }

  static Color getSettingVersionColor() {
    if (_isNightMode) {
      return Color(FontConstant.FONT_SETTINGVERSION_COLOR_NIGHT);
    } else {
      return Color(FontConstant.FONT_SETTINGVERSION_COLOR_DAY);
    }
  }

  static String getTopBarBg() {
    if (_isNightMode) {
      return 'assets/images/topbar_night.png';
    } else {
      return 'assets/images/topbar.png';
    }
  }

  static Color getBriefFontColor() {
    if (_isNightMode) {
      return Color(FontConstant.FONT_BRIEF_COLOR_NIGHT);
    } else {
      return Color(FontConstant.FONT_BRIEF_COLOR_DAY);
    }
  }
}
