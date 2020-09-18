import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/select_appointment_time.dart';

import '../home_page.dart';

// 登录页
var loginHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return PopupRoutePage();
    });

// 跳转到主页
var homeHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<Object>> params) {
      return SelectAppointmentTime();
    });
