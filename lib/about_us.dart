import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/wechat_account.dart';

class AboutUs extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AboutUs();
  }
}

class _AboutUs extends State<AboutUs>{

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    SystemChrome.setEnabledSystemUIOverlays([]); //隐藏
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
//    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Container(
                  padding: EdgeInsets.all(12),
                  child: Image.asset('images/right_gray.png'),
                ),
                Center(
                  child: Text('关于我们',style: TextStyle(color: Color.fromRGBO(16, 16, 16, 1),fontSize: 18),),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.only(left: 20,top: 15,right: 20,bottom: 15),
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text('我们的官网',style: TextStyle(color: Color.fromRGBO(53, 53, 53, 1),fontSize: 12),),
                ),
                Image.asset('images/ic_route_right_arrow.png'),
              ],
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => WeChatAccount()));
            },
            child: Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.only(left: 20,top: 15,right: 20,bottom: 15),
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text('我们的微信公众号',style: TextStyle(color: Color.fromRGBO(53, 53, 53, 1),fontSize: 12),),
                  ),
                  Image.asset('images/ic_route_right_arrow'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}