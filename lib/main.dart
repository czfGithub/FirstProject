import 'package:flutter/material.dart';

import 'widget/widget_w_popup_menu.dart';
import 'popup_menu_botton_page.dart';
import 'shader_mask_page.dart';
import 'drop_down_botton_page.dart';
import 'package:popup_window/popup_window.dart';
import 'package:flutterapp/Popup.dart';
import 'group_manage.dart';

void main(){
  runApp(MyApp());
}

class PopupItem extends StatelessWidget{

  PopupItem({
    @required this.model,
    this.lineVisible,
    this.onClick,
  });

  bool lineVisible = true;
  PopupModel model;
  Function onClick; //点击child事件

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: (){
        if(onClick != null){
          Navigator.pop(context);
          onClick();
        }
      },
      child: Container(
        width: 100,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (model.icon != null && model.icon != '') Image.asset(model.icon,width: 40,height: 40,),
                  Text(model.value,style: TextStyle(color: Color.fromRGBO(53, 53, 53, 1),fontSize: 12),),
                ],
              ),
            ),
            if(lineVisible) Container(
              margin: EdgeInsets.only(left: 20,right: 20),
              height: 0.5,color:
            Color.fromRGBO(248, 96, 144, 1),
            ),
          ],
        ),
      ),
    );
  }
}

class PopupModel{
  int index;
  String icon;
  String value;

  PopupModel({
    this.index,
    this.icon,
    this.value,
  });
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

  final List<String> actions = [
    '复制',
    '转发',
    '收藏',
    '删除',
    '多选',
    '提醒',
    '翻译',
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('PopupRoutePage'),
        ),
        body: Column(
          children: <Widget>[
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
//            TextField(),
            ListView.builder(
                shrinkWrap: true,
                itemCount: 40,
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
        ));
//    );
  }
}