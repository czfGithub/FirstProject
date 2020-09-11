import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutterapp/about_us.dart';
import 'package:flutterapp/add_employee.dart';
import 'package:flutterapp/customer_list.dart';
import 'package:flutterapp/discount_ticket.dart';
import 'package:flutterapp/help_center.dart';
import 'package:flutterapp/mark.dart';
import 'package:flutterapp/my_service.dart';
import 'package:flutterapp/page_view.dart';
import 'package:flutterapp/purchase_record.dart';
import 'package:flutterapp/show_dialog.dart';
import 'package:flutterapp/widget/popup_item.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'http_request.dart';
import 'models/popup_model.dart';
import 'widget/widget_w_popup_menu.dart';
import 'popup_menu_botton_page.dart';
import 'shader_mask_page.dart';
import 'drop_down_botton_page.dart';
import 'package:popup_window/popup_window.dart';
import 'package:flutterapp/Popup.dart';
import 'group_manage.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:image_picker/image_picker.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: PopupRoutePage(),
    );
  }
}

class PopupRoutePage extends StatefulWidget {
  @override
  _PopupRoutePageState createState() => _PopupRoutePageState();
}

class _PopupRoutePageState extends State<PopupRoutePage> {

  GlobalKey anchorKey = GlobalKey();
  //首先在你需要生成二维码页面中声明一个GlobalKey
  GlobalKey _globalKey = new GlobalKey();

  Timer _countdownTimer;
  String _codeCountdownStr = '获取验证码';
  int _countdownNum = 59;
  Future<File> _imageFile;
  int _selectedCount = 0;
  var _radioGroupValue = '语文';
  var _sex = '先生';
  var _tag = '家';
  List<String> _sexs = ['先生','女士'];
  List<String> _tags = ['家','公司','学校'];

  List<Widget> _getTags(List<String> tags, String tag, Function onChange){
    List<Widget> widgets = [];
    for(int i = 0; i < tags.length; i++){
      widgets.add(GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: (){
          onChange(tags[i]);
        },
        child: Container(
          width: 60,
          height: 30,
          alignment: Alignment.center,
          padding: EdgeInsets.only(top: 5,bottom: 5),
          margin: EdgeInsets.only(left: i == 0 ? 0 : 10),
          decoration: BoxDecoration(
            color: tags[i] == tag ? Color.fromRGBO(3, 50, 157, 1) : Color.fromRGBO(255, 246, 246, 1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(tags[i],style: TextStyle(color: tags[i] == tag ? Colors.white : Color.fromRGBO(136, 136, 136, 1),fontSize: 14)),
        ),
      ));
    }
    return widgets;
  }

  void reGetCountdown() {
    setState(() {
      if (_countdownTimer != null) {
        return;
      }
      // Timer的第一秒倒计时是有一点延迟的，为了立刻显示效果可以添加下一行。
      _codeCountdownStr = '${_countdownNum--}重新获取';
      _countdownTimer =
      new Timer.periodic(new Duration(seconds: 1), (timer) {
        setState(() {
          if (_countdownNum > 0) {
            _codeCountdownStr = '${_countdownNum--}重新获取';
          } else {
            _codeCountdownStr = '获取验证码';
            _countdownNum = 59;
            _countdownTimer.cancel();
            _countdownTimer = null;
          }
        });
      });
    });
  }

  Future<Uint8List> _widgetShot () async {
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

  void _selectedImage(bool isSelect) {
    setState(() {
      _imageFile = ImagePicker.pickImage(source: isSelect ? ImageSource.gallery : ImageSource.camera);
    });
  }

  Widget _previewImage() {
    return FutureBuilder<File>(
        future: _imageFile,
        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return new ClipOval(
              child: SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: Image.file(snapshot.data, fit: BoxFit.cover)
              ),
            );
          } else {
            return new Image.asset("images/ic_load_default_round.png", height: 100.0, width: 100.0,fit: BoxFit.fill,);
          }
        });
  }

  final List<String> actions = [
    '复制',
    '转发',
    '收藏',
    '删除',
    '多选',
    '提醒',
    '翻译',
    '引用',
    '黏贴',
    '消息',
  ];

  final List<PopupModel> items = [
    PopupModel(index: 0,value: '今日实时'),
    PopupModel(index: 1,value: '7天'),
    PopupModel(index: 2,value: '30天'),
    PopupModel(index: 3,value: '自然日'),
    PopupModel(index: 4,value: '自然月'),
  ];

  List<PopupItem> getPopupItems(BuildContext context){
    List<PopupItem> popupItems = [];
    for(int i = 0; i < items.length; i++){
      popupItems.add(PopupItem(
        lineVisible: i == items.length - 1 ? false : true,
        model:items[i],
        onClick: (){
          print(items[i].value);
        },
      ));
    }
    return popupItems;
  }

  ///弹出退出按钮
  ///点击退出调用onClick
  void _showExit() {
    Navigator.push(context, PopRoute(child: Popup(
      child: _buildExit(),
      left: 60,
      top: 22,
      onClick: () {
        print("exit");
      },
    ),),);
  }

  void _showPopup(){
    RenderBox renderBox = anchorKey.currentContext.findRenderObject();
    var offset =  renderBox.localToGlobal(Offset(0.0, renderBox.size.height));
    Navigator.push(context, PopRoute(child: Popup(
      items: getPopupItems(context),
      left: offset.dx,
      top: offset.dy,
    ),),);
//    Navigator.push(context, PopRoute(child: Popup(
//      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.center,
//        children: [
//          PopupItem(model: PopupModel(index: 0,value: '今日实时'),onClick: () {
//            print("exit");
//          }),
//          PopupItem(model: PopupModel(index: 1,value: '7天'),),
//          PopupItem(model: PopupModel(index: 2,value: '30天'),),
//          PopupItem(model: PopupModel(index: 3,value: '自然日'),),
//          PopupItem(model: PopupModel(index: 4,value: '自然月'),),
//        ],
//      ),
//      left: offset.dx,
//      top: offset.dy,
//    ),),);
  }

  ///构建退出按钮
  Widget _buildExit() {
    return Container(
      width: 91,
      height: 36,
      child: Stack(
        children: <Widget>[
          Center(
            child: Text(
              '退出',
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  void changeImg(int pos) {
    setState(() {
      imgs[pos] = "https://i1.mifile.cn/f/i/2019/micc9/summary/specs-08.png";
    });
  }

  void onPageChanged(int pos) {
    print("当前是第$pos页");
  }

  var imgs = [
    "https://i1.mifile.cn/f/i/2019/micc9/summary/specs-02.png",
    "https://i1.mifile.cn/f/i/2019/micc9/summary/specs-03.png",
    "https://i1.mifile.cn/f/i/2019/micc9/summary/specs-04.png",
    "https://i1.mifile.cn/f/i/2019/micc9/summary/specs-05.png",
    "https://i1.mifile.cn/f/i/2019/micc9/summary/specs-06.png"
  ];

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334);
    return Scaffold(
        appBar: AppBar(
          title: Text('PopupRoutePage'),
        ),
        body: Builder(
          builder: (BuildContext context){
            return Column(
              children: <Widget>[
//            PageView(
//              children: <Widget>[
//                Image.network(imgs[0]),
//                Image.network(imgs[1]),
//                Image.network(imgs[2]),
//                Image.network(imgs[3]),
//                GestureDetector(
//                    onTap: () => changeImg(4), child: Image.network(imgs[4]))
//              ],
//              onPageChanged: onPageChanged,
//            ),
                Text.rich(TextSpan(
                  text: '商城认证体系更多店铺认证详情您可以点击下载',
                  style: TextStyle(color: Color.fromRGBO(53, 53, 53, 1),fontSize: 14),
                  children: [
                    TextSpan(
                      text: '商家认证手册3.0',
                      style: TextStyle(color: Color.fromRGBO(4, 50, 157, 1)),
                      recognizer: TapGestureRecognizer()..onTap=() async{
                        print('hello');
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerList()));
                      },
                    ),
                    TextSpan(
                      text: ' 优惠券列表',
                      style: TextStyle(color: Color.fromRGBO(4, 50, 157, 1)),
                      recognizer: TapGestureRecognizer()..onTap=() async{
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DiscountTicket()));
                      },
                    ),
                    TextSpan(
                      text: ' http 请求',
                      style: TextStyle(color: Color.fromRGBO(4, 50, 157, 1)),
                      recognizer: TapGestureRecognizer()..onTap=() async{
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MHttpRequest()));
                      },
                    ),
                    TextSpan(
                      text: ' 购买记录',
                      style: TextStyle(color: Color.fromRGBO(4, 50, 157, 1)),
                      recognizer: TapGestureRecognizer()..onTap=() async{
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PurchaseRecord()));
                      },
                    ),
                  ],
                )),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        autofocus: false,
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: Color.fromRGBO(53, 53, 53, 1),fontSize: 14),
                        decoration: InputDecoration(
                          hintText: '请输入手机号',
                          hintStyle: TextStyle(color: Color.fromRGBO(153, 153, 153, 1),fontSize: 14),
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.blue,
                                width: 0.5,
                              )
                          ),
                        ),
                      ),
                    ),
                    FlatButton(
                      textColor: Colors.blue,
                      child: Text(_codeCountdownStr),
                      onPressed: reGetCountdown,
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FlatButton(onPressed: _widgetShot, child: Text('保存二维码')),
                    FlatButton(onPressed: (){
                      _selectedImage(true);
                      }, child: Text('选择图片')),
                    FlatButton(onPressed: (){
                      _selectedImage(false);
                      }, child: Text('拍照')),
                    Padding(
                      key: anchorKey,
                      padding: EdgeInsets.all(0),
                      child: GestureDetector(
                        child: Container(
                          child: Image.asset(
                            "images/right_gray.png",
                          ),
                        ),
                        onTap: _showPopup,
                      ),
                    ),
                    PopupWindowButton(
                      offset: Offset(0, 200),
                      child: Image(image: AssetImage("images/right_gray.png")),
                      window: Container(
                        padding: EdgeInsets.all(50),
                        alignment: Alignment.center,
                        color: Colors.greenAccent,
                        height: 200,
                        child: Container(
                          color: Colors.white,
                          height: 50,
                        ) ,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: _getTags(_sexs, _sex, (tag){
                    setState(() {
                      print(tag);
                      _sex = tag;
                    });
                  }),
                ),
                Row(
                  children: _getTags(_tags, _tag, (tag){
                    setState(() {
                      print(tag);
                      _tag = tag;
                    });
                  }),
//              children: [
//                Container(
//                  padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
//                  decoration: BoxDecoration(
//                    color: Color.fromRGBO(3, 50, 157, 1),
//                    borderRadius: BorderRadius.circular(20),
//                  ),
//                  child: Text('家',style: TextStyle(color: Colors.white,fontSize: 14)),
//                ),
//                Container(
//                  margin: EdgeInsets.only(left: 10),
//                  padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
//                  decoration: BoxDecoration(
//                    color: Color.fromRGBO(255, 246, 246, 1),
//                    borderRadius: BorderRadius.circular(20),
//                  ),
//                  child: Text('公司',style: TextStyle(color: Color.fromRGBO(136, 136, 136, 1),fontSize: 14)),
//                ),
//                Container(
//                  margin: EdgeInsets.only(left: 10),
//                  padding: EdgeInsets.only(left: 10,right: 10,top: 5,bottom: 5),
//                  decoration: BoxDecoration(
//                    color: Color.fromRGBO(255, 246, 246, 1),
//                    borderRadius: BorderRadius.circular(20),
//                  ),
//                  child: Text('学校',style: TextStyle(color: Color.fromRGBO(136, 136, 136, 1),fontSize: 14)),
//                ),
//              ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RepaintBoundary(
                      key: _globalKey,
                      child: QrImage(
                        backgroundColor: Colors.white,
                        data: '二维码',
                        size: 100,
                      ),
                    ),
                    _previewImage(),
                  ],
                ),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: 3,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        alignment: index % 2 == 0
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: WPopupMenu(
                          onValueChanged: (int value) {
                            if(value == 0){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => PopupMenuButtonPage()));
                            }else if(value == 1){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShaderMaskPage()));
                            }else if(value == 2){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => DropDownButtonPage()));
                            }else if(value == 3){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => GroupManage()));
                            }else if(value == 4){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Mark()));
                            }else if(value == 5){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => AboutUs()));
                            }else if(value == 6){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewPage()));
                            }else if(value == 7){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => HelpCenter()));
                            }else if(value == 8){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ShowDialog()));
                            }else if(value == 9){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyService()));
                            }
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(actions[value]),
                              duration: Duration(milliseconds: 500),
                            ));
                          },
                          pressType: PressType.longPress,
                          actions: actions,
                          child: UnconstrainedBox(
                            child: Container(
                              height: 40,
                              color: Colors.cyan,
                              alignment: Alignment.center,
                              child: Text(
                                '我是Title $index',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ],
            );
          }
        ),
    );
//    );
  }
}