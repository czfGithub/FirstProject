

import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterapp/models/user.dart';
import 'package:flutterapp/route/navigate_service.dart';
import 'package:flutterapp/route/routes.dart';
import 'package:flutterapp/utils/utils.dart';
import 'package:flutterapp/widget/loading.dart';
import 'package:path_provider/path_provider.dart';

import '../application.dart';

class NetUtil{
  static Dio _dio;
  static final String baseUrl = 'http://118.31.42.165:7002';

  static void init() async {
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    CookieJar cj = PersistCookieJar(dir: tempPath);
    _dio = Dio(BaseOptions(baseUrl: '$baseUrl', followRedirects: false))
      ..interceptors.add(CookieManager(cj))
      ..interceptors
          .add(LogInterceptor(responseBody: true, requestBody: true));

    // 海外華人可使用 nondanee/UnblockNeteaseMusic
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.findProxy = (uri) {
//        var host = uri.host;
//        if (host == 'music.163.com' ||
//            host == 'interface.music.163.com' ||
//            host == 'interface3.music.163.com' ||
//            host == 'apm.music.163.com' ||
//            host == 'apm3.music.163.com' ||
//            host == '59.111.181.60' ||
//            host == '223.252.199.66' ||
//            host == '223.252.199.67' ||
//            host == '59.111.160.195' ||
//            host == '59.111.160.197' ||
//            host == '59.111.181.38' ||
//            host == '193.112.159.225' ||
//            host == '118.24.63.156' ||
//            host == '59.111.181.35' ||
//            host == '39.105.63.80' ||
//            host == '47.100.127.239' ||
//            host == '103.126.92.133' ||
//            host == '103.126.92.132') {
//          return 'PROXY YOURPROXY;DIRECT';
//        }
        return 'DIRECT';
      };
    };
  }

  static Future<Response> _get(
      BuildContext context,
      String url, {
        Map<String, dynamic> params,
        bool isShowLoading = true,
      }) async {
    if (isShowLoading) Loading.showLoading(context);
    try {
      return await _dio.get(url, queryParameters: params);
    } on DioError catch (e) {
      if (e == null) {
        return Future.error(Response(data: -1));
      } else if (e.response != null) {
        if (e.response.statusCode >= 300 && e.response.statusCode < 400) {
          _reLogin();
          return Future.error(Response(data: -1));
        } else {
          return Future.value(e.response);
        }
      } else {
        return Future.error(Response(data: -1));
      }
    } finally {
      Loading.hideLoading(context);
    }
  }

  static void _reLogin() {
    Future.delayed(Duration(milliseconds: 200), () {
      Application.getIt<NavigateService>().popAndPushNamed(Routes.login);
      Utils.showToast('登录失效，请重新登录');
    });
  }

  /// 登录
  static Future<User> getSmsCode(
      BuildContext context, String phone) async {
    var response = await _get(context, '/api/merchant/sendSmsCode', params: {
      'phone': phone,
      'eventType': 1,
//      'password': password,
    });

    return User.fromJson(response.data);
  }

}