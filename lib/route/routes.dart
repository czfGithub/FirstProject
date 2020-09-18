import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/help_center.dart';
import 'package:flutterapp/route/route_handles.dart';

class Routes {
  static String root = "/";
  static String home = "/home";
  static String login = "/login";
  static String dailySongs = "/daily_songs";
  static String playList = "/play_list";
  static String topList = "/top_list";
  static String playSongs = "/play_songs";
  static String comment = "/comment";
  static String search = "/search";
  static String lookImg = "/look_img";
  static String userDetail = "/user_detail";

  static void configureRoutes(Router router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
      return HelpCenter();
    });
    router.define(login, handler: loginHandler);
    router.define(home, handler: homeHandler);
  }
}
