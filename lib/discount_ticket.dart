import 'package:flutter/material.dart';
import 'package:flutterapp/widget/common_appbar_widget.dart';
import 'package:flutterapp/widget/loading.dart';
import 'package:flutterapp/widget/slide_button.dart';

class DiscountTicket extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DiscountTicket();
  }
}

class _DiscountTicket extends State<DiscountTicket> with TickerProviderStateMixin{

  bool _voucher = false;
  bool _isManage = false;
  bool _isAll = false;
  double _delta = 0;
  double itemWidth = 0;
  double _currentLeft = 0;
  Animation<double> animation;
  AnimationController controller;

  TabController _tabController;
  List _tabs = ['全部','优惠券','折扣券','抵用券'];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('DiscountTicket  initState');
    controller = new AnimationController(
        duration: const Duration(milliseconds: 100), vsync: this);
    Future.delayed(Duration.zero,(){
      setState(() {
        itemWidth = MediaQuery.of(context).size.width / _tabs.length;
        _delta = (itemWidth - 20) / 2;
        _currentLeft = _delta;
        //图片宽高从0变到300
        animation = new Tween(begin: 0.0, end: _currentLeft).animate(controller);
        //启动动画
        controller.forward();
      });
    });
    animation = new Tween(begin: 0.0, end: _currentLeft).animate(controller);
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      setState(() {
        var end = _delta + _tabController.index * itemWidth;
        animation = new Tween(begin: _currentLeft, end: end).animate(controller);
        //启动动画
        controller.forward();
        _currentLeft = end;
        print('${_tabController.index} : $end');
      });
      switch(_tabController.index){
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
        case 3:
          break;
      }
    });
  }

  showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: true, //点击遮罩关闭对话框
      barrierColor: Color.fromARGB(0, 0, 0, 255),
      builder: (context) {
        return UnconstrainedBox(
          constrainedAxis: Axis.vertical,
          child: SizedBox(
            width: 280,
            child: AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircularProgressIndicator(value: .8,),
                  Padding(
                    padding: const EdgeInsets.only(top: 26.0),
                    child: Text("正在加载，请稍后..."),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  dispose() {
    //路由销毁时需要释放动画资源
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: ActionBar(),
//      appBar: CommonAppBar(
//        leading: 'images/ic_title_back_black.png',
//        leftText: '取消',
//        leftListener: (){
//          Navigator.pop(context);
//        },
//        center: Text('优惠券列表',style: TextStyle(color: Color.fromRGBO(16, 16, 16, 1),fontSize: 18,fontWeight: FontWeight.bold),),
//        backgroundColor: Colors.white,
//      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 0.5,
            color: Color.fromRGBO(232, 232, 232, 1),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: (){
                    _tabController.animateTo(0);
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('全部',style: TextStyle(color: Color.fromRGBO(53, 53, 53, 1),fontSize: 14),),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Image.asset('images/ic_up_gray_arrow.png',width: 12,height: 6,),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: (){
                    _tabController.animateTo(1);
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('优惠券',style: TextStyle(color: Color.fromRGBO(53, 53, 53, 1),fontSize: 14),),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Image.asset('images/ic_up_gray_arrow.png',width: 12,height: 6,),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: (){
                    _tabController.animateTo(2);
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('折扣券',style: TextStyle(color: Color.fromRGBO(53, 53, 53, 1),fontSize: 14),),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Image.asset('images/ic_up_gray_arrow.png',width: 12,height: 6,),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: (){
                    setState(() {
                      _voucher = !_voucher;
                      _tabController.animateTo(3);
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('抵用券',style: TextStyle(color: Color.fromRGBO(53, 53, 53, 1),fontSize: 14),),
                        Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Image.asset('images/ic_all_group.png',width: 12,height: 6,),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          IndicatorTransition(
            animation: animation,
            child: Container(
              width: 20,
              height: 3,
              decoration: BoxDecoration(
                color: Color.fromRGBO(29, 103, 202, 1),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
//          Container(
//            width: 20,
//            height: 3,
//            color: Color.fromRGBO(29, 103, 202, 1),
//            margin: EdgeInsets.only(left: _currentLeft),
//          ),
          Visibility(
            visible: _voucher,
            child: Container(
              color: Color.fromRGBO(216, 216, 216, 1),
              padding: EdgeInsets.only(left: 15,right: 15),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Text('满减券',style: TextStyle(color: Color.fromRGBO(178, 178, 178, 1),fontSize: 12),),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Text('满减券',style: TextStyle(color: Color.fromRGBO(178, 178, 178, 1),fontSize: 12),),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Text('满减券',style: TextStyle(color: Color.fromRGBO(178, 178, 178, 1),fontSize: 12),),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Text('满减券',style: TextStyle(color: Color.fromRGBO(178, 178, 178, 1),fontSize: 12),),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 0.5,
            color: Color.fromRGBO(232, 232, 232, 1),
          ),
          Expanded(
            child: TabBarView(
                controller: _tabController,
                children: [
                  AllTicket(isManage: _isManage,isAll: _isAll,),
                  AllTicket(isManage: _isManage,isAll: _isAll,),
                  AllTicket(isManage: _isManage,isAll: _isAll,),
                  AllTicket(isManage: _isManage,isAll: _isAll,),
                ]
            ),
          ),
          Container(
            height: 0.5,
            color: Color.fromRGBO(232, 232, 232, 1),
          ),
          Visibility(
            visible: !_isManage,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: (){
                setState(() {
                  _isManage = true;
                });
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(15),
                child: Text('管理',style: TextStyle(color: Color.fromRGBO(16, 16, 16, 1),fontSize: 14),),
              ),
            ),
          ),
          Visibility(
            visible: _isManage,
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 4,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: (){
                            setState(() {
                              _isAll = !_isAll;
                            });
                          },
                          child: Container(
                              padding: EdgeInsets.all(20),
                              child: Image.asset(_isAll ? 'images/ic_selected.png' : 'images/ic_unselect.png',width: 20,height: 20,)
                          ),
                        ),
                        Text('全选',style: TextStyle(color: Color.fromRGBO(16, 16, 16, 1),fontSize: 14),),
                      ],
                    ),
                  ),
                  Container(
                    color: Color.fromRGBO(232, 232, 232, 1),
                    height: 20,
                    width: 0.5,
                  ),
                  Expanded(
                    flex: 3,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: (){
                        setState(() {
                          _isManage = !_isManage;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('images/ic_stop_user.png',width: 12,height: 12,),
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Text('停用',style: TextStyle(color: Color.fromRGBO(16, 16, 16, 1),fontSize: 14),),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: (){
                        showLoadingDialog();
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('images/ic_start_user.png',width: 12,height: 12,),
                            Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Text('启用',style: TextStyle(color: Color.fromRGBO(16, 16, 16, 1),fontSize: 14),),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ActionBar extends StatelessWidget implements PreferredSizeWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
              margin: EdgeInsets.only(left: 5),
              padding: EdgeInsets.all(12),
              child: Text('取消',style: TextStyle(color: Color.fromRGBO(136, 136, 136, 1),fontSize: 16),),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text('优惠券列表',style: TextStyle(color: Color.fromRGBO(16, 16, 16, 1),fontSize: 18),),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => new Size.fromHeight(56);

}

class IndicatorTransition extends StatefulWidget {
  IndicatorTransition({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _IndicatorTransition();
  }
}

class _IndicatorTransition extends State<IndicatorTransition>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new AnimatedBuilder(
        animation: widget.animation,
        builder: (BuildContext context, Widget child) {
          return new Container(
              margin: EdgeInsets.only(left: widget.animation.value),
              child: child
          );
        },
        child: widget.child
    );
  }
}

class AllTicket extends StatefulWidget{

  bool isManage = false;
  bool isAll = false;

  AllTicket({this.isManage,this.isAll});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AllTicket();
  }
}

class _AllTicket extends State<AllTicket>{

  List<bool> _manageList = [];
  List<GlobalKey<SlideButtonState>> _globalKeyList = [];

  void _initData() {
    _manageList.clear();
    _globalKeyList.clear();
    for (int i = 0; i < 3; i++) {
      _manageList.add(widget.isAll);
    }
    for (int i = 0; i < _manageList.length; i++) {
      _globalKeyList.add(new GlobalKey());
    }
  }

  InkWell buildAction(
      GlobalKey<SlideButtonState> key, Color color, GestureTapCallback tap) {
    return InkWell(
      onTap: tap,
      child: Container(
        alignment: Alignment.center,
        width: 60,
        color: color,
        child: Image.asset(
          'images/ic_delete_discount.png',
          width: 15,
          height: 15,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('initState');
    _initData();
  }

  @override
  void didUpdateWidget(AllTicket oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget');
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _manageList.length,
      itemBuilder: (ctx,index){
        return Container(
          padding: EdgeInsets.only(top: 10),
          child: SlideButton(
            key: _globalKeyList[index],
            singleButtonWidth: 120,
            buttons: [
              Container(
                margin: EdgeInsets.only(right: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        _globalKeyList[index].currentState.close();
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 10),
                        color: Colors.red,
                        child: Container(
                          width: 60,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'images/ic_stop_discount.png',
                                width: 12,
                                height: 12,
                                fit: BoxFit.contain,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 2),
                                child: Text('停用',style: TextStyle(color: Colors.white,fontSize: 8),),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      height: 20,
                      width: 0.5,
                    ),
                    InkWell(
                      onTap: (){
                        _globalKeyList[index].currentState.close();
                        Loading.showLoading(context);
                        Future.delayed(Duration(seconds: 2)).then((value) => setState(() {
                          _manageList.removeAt(index);
                          _globalKeyList.removeAt(index);
                          Loading.hideLoading(context);
                        }));
                      },
                      child: Container(
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.only(topRight: Radius.circular(10),bottomRight: Radius.circular(10)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'images/ic_delete_discount.png',
                              width: 12,
                              height: 12,
                              fit: BoxFit.contain,
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 2),
                              child: Text('删除',style: TextStyle(color: Colors.white,fontSize: 8),),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Visibility(
                    visible: widget.isManage,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: (){
                        // 此时context为对话框UI的根Element，我们
                        // 直接将对话框UI对应的Element标记为dirty
                        (context as Element).markNeedsBuild();
                        _manageList[index] = !_manageList[index];
                      },
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Image.asset(_manageList[index] ? 'images/ic_selected.png' : 'images/ic_unselect.png',width: 20,height: 20,),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 110,
                      margin: EdgeInsets.only(left: widget.isManage ? 0 : 20,right: 20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                offset: Offset(2.0,2.0),
                                blurRadius: 4.0
                            ),
                          ]
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 110,
                            padding: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(10),bottomLeft: Radius.circular(10)),
                              color: Color.fromRGBO(255, 116, 135, 1),
                            ),
                            child: Center(
                              child: Text('优\n惠\n券',style: TextStyle(color: Colors.white,fontSize: 12),),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(15),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Image.asset('images/ic_discount_price.png',width: 15,height: 15,),
                                                Container(
                                                  margin: EdgeInsets.only(left: 5),
                                                  child: Text('50',style: TextStyle(color: Color.fromRGBO(210, 1, 29, 1),fontSize: 28,fontWeight: FontWeight.bold),),
                                                ),
                                              ],
                                            ),
                                            Text('满189元可用',style: TextStyle(color: Color.fromRGBO(210, 1, 29, 1),fontSize: 14,fontWeight: FontWeight.bold),),
                                          ],
                                        ),
                                      ),
                                      Text('全场女装商品可用\n(特殊商品除外)',style: TextStyle(color: Color.fromRGBO(53, 53, 53, 1),fontSize: 10),textAlign: TextAlign.center,),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 15,right: 15),
                                  color: Color.fromRGBO(232, 232, 232, 1),
                                  height: 0.5,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5,bottom: 5,left: 15),
                                  child: Text('·有效期2020.04.16-04.19',style: TextStyle(color: Color.fromRGBO(136, 136, 136, 1),fontSize: 10),),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

