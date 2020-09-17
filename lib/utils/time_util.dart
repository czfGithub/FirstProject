import 'package:flutter/material.dart';

class TimeUtil {
  static const List<int> _daysInMonth = <int>[
    31,
    -1,
    31,
    30,
    31,
    30,
    31,
    31,
    30,
    31,
    30,
    31
  ];

  /// 获取这个月的天数
  static int getDaysInMonth(int year, int month) {
    if (month == DateTime.february) {
      final bool isLeapYear =
          (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
      if (isLeapYear) return 29;
      return 28;
    }
    return _daysInMonth[month-1];
  }

  /// 获取周Header
  static List<Widget> getDayHeaders(MaterialLocalizations localizations) {
    List<Widget> list = [];
    for (int i = localizations.firstDayOfWeekIndex; true; i = (i + 1) % 7) {
      final String weekday = localizations.narrowWeekdays[i];
      list.add(Flexible(
          child: Container(
            height: 40,
            child: Center(
              child: Text(
                weekday,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                ),
              ),
            ),
          )));
      if (i == (localizations.firstDayOfWeekIndex - 1) % 7) break;
    }
    return list;
  }

  /// 得到这个月的第一天是星期几（0 是 星期日 1 是 星期一...）
  static int computeFirstDayOffset(
      int year, int month, MaterialLocalizations localizations) {
    // 0-based day of week, with 0 representing Monday.
    final int weekdayFromMonday = DateTime(year, month).weekday - 1;
    // 0-based day of week, with 0 representing Sunday.
    final int firstDayOfWeekFromSunday = localizations.firstDayOfWeekIndex;
    // firstDayOfWeekFromSunday recomputed to be Monday-based
    final int firstDayOfWeekFromMonday = (firstDayOfWeekFromSunday - 1) % 7;
    // Number of days between the first day of week appearing on the calendar,
    // and the day corresponding to the 1-st of the month.
    return (weekdayFromMonday - firstDayOfWeekFromMonday) % 7;
  }

  /// 获取天
  static List getDay(int year, int month, MaterialLocalizations localizations) {
    List labels = [];
    final int daysInMonth = getDaysInMonth(year, month);
    final int firstDayOffset =
    computeFirstDayOffset(year, month, localizations);
    for (int i = 0; true; i += 1) {
      // 1-based day of month, e.g. 1-31 for January, and 1-29 for February on
      // a leap year.
      final int day = i - firstDayOffset + 1;
      if (day > daysInMonth) break;
      if (day < 1) {
        labels.add(0);
      } else {
        labels.add(DateTime(year, month, day));
      }
    }
    return labels;
  }

  /// get WeekDay.
  /// dateTime
  /// isUtc
  /// languageCode zh or en
  /// short
  static String getWeekday(DateTime dateTime,
      {String languageCode = 'en', bool short = false}) {
    if (dateTime == null) return null;
    String weekday;
    switch (dateTime.weekday) {
      case 1:
        weekday = languageCode == 'zh' ? '星期一' : "Monday";
        break;
      case 2:
        weekday = languageCode == 'zh' ? '星期二' : "Tuesday";
        break;
      case 3:
        weekday = languageCode == 'zh' ? '星期三' : "Wednesday";
        break;
      case 4:
        weekday = languageCode == 'zh' ? '星期四' : "Thursday";
        break;
      case 5:
        weekday = languageCode == 'zh' ? '星期五' : "Friday";
        break;
      case 6:
        weekday = languageCode == 'zh' ? '星期六' : "Saturday";
        break;
      case 7:
        weekday = languageCode == 'zh' ? '星期日' : "Sunday";
        break;
      default:
        break;
    }
    return languageCode == 'zh'
        ? (short ? weekday.replaceAll('星期', '周') : weekday)
        : weekday.substring(0, short ? 3 : weekday.length);
  }

  static String getMonthName(DateTime dateTime,
      {String languageCode = 'en', bool short = false}) {
    if (dateTime == null) return null;
    String monthName;
    switch (dateTime.month) {
      case 1:
        monthName = languageCode == 'zh' ? '一月' : "January";
        break;
      case 2:
        monthName = languageCode == 'zh' ? '二月' : "February";
        break;
      case 3:
        monthName = languageCode == 'zh' ? '三月' : "March";
        break;
      case 4:
        monthName = languageCode == 'zh' ? '四月' : "April";
        break;
      case 5:
        monthName = languageCode == 'zh' ? '五月' : "May";
        break;
      case 6:
        monthName = languageCode == 'zh' ? '六月' : "June";
        break;
      case 7:
        monthName = languageCode == 'zh' ? '七月' : "July";
        break;
      case 8:
        monthName = languageCode == 'zh' ? '八月' : "August";
        break;
      case 9:
        monthName = languageCode == 'zh' ? '九月' : "September";
        break;
      case 10:
        monthName = languageCode == 'zh' ? '十月' : "October";
        break;
      case 11:
        monthName = languageCode == 'zh' ? '十一月' : "November";
        break;
      case 12:
        monthName = languageCode == 'zh' ? '十二月' : "December";
        break;
      default:
        break;
    }
    return languageCode == 'zh'
        ? (short ? monthName.replaceAll('月', '') : monthName)
        : monthName.substring(0, short ? 3 : monthName.length);
  }
}