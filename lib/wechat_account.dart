import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterapp/widget/common_appbar_widget.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';

class WeChatAccount extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _WechatAccount();
  }
}

class _WechatAccount extends State<WeChatAccount>{

  //首先在你需要生成二维码页面中声明一个GlobalKey
  GlobalKey _globalKey = new GlobalKey();

  Future<Uint8List> _widgetShot () async {
    // 检查并请求权限
    PermissionStatus status = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
    if (PermissionStatus.granted != status) {
      PermissionHandler().requestPermissions(<PermissionGroup>[
        PermissionGroup.storage,
      ]);
    }else{
      RenderRepaintBoundary boundary = _globalKey.currentContext.findRenderObject();
      var image = await boundary.toImage();
      ByteData byteData = await image.toByteData(format: ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      final result = await ImageGallerySaver.saveImage(Uint8List.fromList(pngBytes));
      if (result != null && result != "") {
        //返回路径
        String str = Uri.decodeComponent(result);
        print("成功保存到$str");
      } else {
        print("保存失败");
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        leading: 'images/ic_title_back_black.png',
        leftListener: (){
          Navigator.pop(context);
        },
        center: Text('微信公众号',style: TextStyle(color: Color.fromRGBO(16, 16, 16, 1),fontSize: 18,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            color: Color.fromRGBO(232, 232, 232, 1),
            width: double.infinity,
            height: 0.5,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RepaintBoundary(
                  key: _globalKey,
                  child: QrImage(
                    backgroundColor: Colors.white,
                    data: '二维码',
                    size: 200,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text('我们的微信公众号',style: TextStyle(color: Color.fromRGBO(53, 53, 53, 1),fontSize: 12),),
                ),
              ],
            ),
          ),
          Container(
            color: Color.fromRGBO(232, 232, 232, 1),
            width: double.infinity,
            height: 0.5,
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _widgetShot,
            child: Container(
              margin: EdgeInsets.only(top: 10,left: 15,right: 15,bottom: 10),
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Color.fromRGBO(114, 198, 254, 1),Color.fromRGBO(30, 103, 228, 1),Color.fromRGBO(30, 103, 228, 1)]),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text('保存相册',style: TextStyle(color: Colors.white,fontSize: 14),),
            )
          ),
        ],
      ),
    );
  }
}