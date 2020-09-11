import 'package:flutter/material.dart';
import 'package:flutterapp/models/popup_model.dart';
import 'package:flutterapp/widget/common_appbar_widget.dart';

import 'Popup.dart';

class CustomerList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CustomerList();
  }
}

class _CustomerList extends State<CustomerList> with SingleTickerProviderStateMixin{

  bool _isManage = false;
  bool _isAll = false;
  TabController _tabController;
  List _tabs = ['全部用户','普通用户','VIP用户'];

  GlobalKey _anchorKey = GlobalKey();

  final List<PopupModel> _items = [
    PopupModel(index: 0,value: '优惠券',icon: 'images/ic_discount_ticket.png'),
    PopupModel(index: 1,value: '会员卡',icon: 'images/ic_vip_card.png'),
  ];

  TextEditingController textEditingController = TextEditingController();
  List<bool> selected = [false,false,false,false,false,false,false,false,false,false];
  int _selectedCount = 0;

  TextEditingController textDiscountController = TextEditingController();
  List<bool> selecteDiscount = [false,false,false,false,false,false,false,false,false,false];
  int _selectDiscount = 0;

  Future<int> _showBottomSheet(BuildContext ctx) {
    return showModalBottomSheet<int>(
      context: ctx,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
      ),
      builder: (BuildContext context) {
        return Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: (){
                          Navigator.of(ctx).pop(-1);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text('取消',style: TextStyle(color: Color.fromRGBO(136, 136, 136, 1),fontSize: 14),),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Text('会员卡',style: TextStyle(color: Color.fromRGBO(16, 16, 16, 1),fontSize: 16,fontWeight: FontWeight.bold),),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: (){
                          Navigator.of(ctx).pop(0);
                        },
                        child: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.all(10),
                          child: Text('完成($_selectedCount)',style: TextStyle(color: Color.fromRGBO(136, 136, 136, 1),fontSize: 14),),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Color.fromRGBO(232, 232, 232, 1),
                width: double.infinity,
                height: 0.5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 25,right: 22),
                    child: Image.asset('images/ic_discount_search.png',width: 13,height: 13,),
                  ),
                  Container(
                    color: Color.fromRGBO(232, 232, 232, 1),
                    width: 0.5,
                    height: 12,
                    margin: EdgeInsets.only(right: 12),
                  ),
                  Expanded(
                    child: TextField(
                      maxLines: 1,
                      controller: textEditingController,
                      style: TextStyle(color: Color.fromRGBO(16, 16, 16, 1),fontSize: 14),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '输入会员卡名称',
                          hintStyle: TextStyle(color: Color.fromRGBO(194, 203, 202, 1),fontSize: 14),
                          contentPadding: EdgeInsets.all(10)
                      ),
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: (){
                      textEditingController.text = '';
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(right: 10),
                      child: Image.asset('images/ic_clear.png',width: 13,height: 13,),
                    ),
                  ),
                ],
              ),
              Container(
                color: Color.fromRGBO(232, 232, 232, 1),
                width: double.infinity,
                height: 0.5,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: selected.length,
                  itemBuilder: (ctx,index){
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: (){
                            // 此时context为对话框UI的根Element，我们
                            // 直接将对话框UI对应的Element标记为dirty
                            (context as Element).markNeedsBuild();
                            selected[index] = !selected[index];
                            if(selected[index]){
                              _selectedCount++;
                            }else{
                              _selectedCount--;
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(20),
                            child: Image.asset(selected[index] ? 'images/ic_selected.png' : 'images/ic_unselect.png',width: 20,height: 20,),
                          ),
                        ),
                        Container(
                          width: 0.5,
                          height: 110,
                          color: Color.fromRGBO(232, 232, 232, 1),
                        ),
                        Expanded(
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20,right: 20),
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: index % 2 == 0 ? [Color.fromRGBO(252, 239, 197, 1),Color.fromRGBO(246, 207, 142, 1)] : [Color.fromRGBO(212, 212, 212, 1),Color.fromRGBO(141, 132, 132, 1)]),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey,
                                          offset: Offset(2.0,2.0),
                                          blurRadius: 4.0
                                      ),
                                    ]
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Image.asset('images/ic_vip_discount.png',width: 25,height: 25,),
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text('$index',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 5),
                                          child: Text('宇宙无敌黄金圣斗士卡',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      alignment: Alignment.centerRight,
                                      margin: EdgeInsets.only(top: 10),
                                      child: Text('有效期至 2050-08-18',style: TextStyle(color: Colors.white,fontSize: 12),),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 30),
                                child: Image.asset('images/ic_discount_bg.png',width: 190,height: 60,fit: BoxFit.contain,),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<int> _showDiscountBottomSheet(BuildContext ctx) {
    return showModalBottomSheet<int>(
      context: ctx,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25)),
      ),
      builder: (BuildContext context) {
        return Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 10,right: 10,top: 15,bottom: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: (){
                          Navigator.of(ctx).pop(-1);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Text('取消',style: TextStyle(color: Color.fromRGBO(136, 136, 136, 1),fontSize: 14),),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: Text('优惠券',style: TextStyle(color: Color.fromRGBO(16, 16, 16, 1),fontSize: 16,fontWeight: FontWeight.bold),),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: (){
                          Navigator.of(ctx).pop(0);
                        },
                        child: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.all(10),
                          child: Text('完成($_selectDiscount)',style: TextStyle(color: Color.fromRGBO(136, 136, 136, 1),fontSize: 14),),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Color.fromRGBO(232, 232, 232, 1),
                width: double.infinity,
                height: 0.5,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 25,right: 22),
                    child: Image.asset('images/ic_discount_search.png',width: 13,height: 13,),
                  ),
                  Container(
                    color: Color.fromRGBO(232, 232, 232, 1),
                    width: 0.5,
                    height: 12,
                    margin: EdgeInsets.only(right: 12),
                  ),
                  Expanded(
                    child: TextField(
                      maxLines: 1,
                      controller: textDiscountController,
                      style: TextStyle(color: Color.fromRGBO(16, 16, 16, 1),fontSize: 14),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '输入优惠券名称',
                          hintStyle: TextStyle(color: Color.fromRGBO(194, 203, 202, 1),fontSize: 14),
                          contentPadding: EdgeInsets.all(10)
                      ),
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: (){
                      textDiscountController.text = '';
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(right: 10),
                      child: Image.asset('images/ic_clear.png',width: 13,height: 13,),
                    ),
                  ),
                ],
              ),
              Container(
                color: Color.fromRGBO(232, 232, 232, 1),
                width: double.infinity,
                height: 0.5,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: selecteDiscount.length,
                  itemBuilder: (ctx,index){
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: (){
                            // 此时context为对话框UI的根Element，我们
                            // 直接将对话框UI对应的Element标记为dirty
                            (context as Element).markNeedsBuild();
                            selecteDiscount[index] = !selecteDiscount[index];
                            if(selecteDiscount[index]){
                              _selectDiscount++;
                            }else{
                              _selectDiscount--;
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(20),
                            child: Image.asset(selecteDiscount[index] ? 'images/ic_selected.png' : 'images/ic_unselect.png',width: 20,height: 20,),
                          ),
                        ),
                        Container(
                          width: 0.5,
                          height: 120,
                          color: Color.fromRGBO(232, 232, 232, 1),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            height: 110,
                            margin: EdgeInsets.only(left: 20,right: 20),
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
                    );
                  },
                ),
              ),
//              Expanded(
//                child: SingleChildScrollView(
//                  physics: BouncingScrollPhysics(),
//                  child: Column(
//                    children: getRow(),
//                  ),
//                ),
//              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> getWidgets(Function callBack){
    List<Widget> widgets = [];
    for(int i = 0; i < _items.length; i++){
      widgets.add(Column(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: (){
              callBack(i);
            },
            child: Container(
              padding: EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(_items[i].icon,width: 14,height: 12,),
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Text(_items[i].value,style: TextStyle(color: Color.fromRGBO(53, 53, 53, 1),fontSize: 12),),
                  ),
                ],
              ),
            ),
          ),
          if(i != _items.length - 1) Container(margin: EdgeInsets.only(left: 10,right: 10),color: Color.fromRGBO(248, 96, 134, 1),height: 0.5,),
        ],
      ),);
    }
    return widgets;
  }

  void _showPopup(BuildContext context){
    RenderBox renderBox = _anchorKey.currentContext.findRenderObject();
    var offset =  renderBox.localToGlobal(Offset.zero);
    print('${offset.dx} : ${offset.dy} , width: ${renderBox.size.width} height: ${renderBox.size.height}');
    Navigator.push(context, PopRoute(child: Popup(
      child: Container(
        width: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 4.0,
              offset: Offset(2.0,2.0),

            )
          ]
        ),
        child: Column(
          children: getWidgets((index){
            Navigator.pop(context);
            if(index == 0){
              _showDiscountBottomSheet(context);
            }else if(index == 1){
              _showBottomSheet(context);
            }
          }),
        ),
      ),
      left: offset.dx + (renderBox.size.width - 80) / 2,
      bottom: renderBox.size.height + 10,
    ),),);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
    _tabController.addListener(() {
      switch(_tabController.index){
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
      }
    });
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
        center: Text('客户列表',style: TextStyle(color: Color.fromRGBO(16, 16, 16, 1),fontSize: 18,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            color: Color.fromRGBO(232, 232, 232, 1),
            height: 0.5,
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Container(
              height: 36,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Color.fromRGBO(114, 198, 254, 1),width: 1),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: Color.fromRGBO(53, 53, 53, 1),fontSize: 12),
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                          isDense: true,
//                          counterText: '',
                          hintText: '输入昵称\\手机号查询',
                          hintStyle: TextStyle(color: Color.fromRGBO(178, 178, 178, 1)),
                          contentPadding: EdgeInsets.symmetric(horizontal: 15,),
                          border: InputBorder.none
                      ),
                    ),
                  ),
                  Container(
                    height: 36,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(left: 30,right: 30),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Color.fromRGBO(114, 198, 254, 1),Color.fromRGBO(30, 103, 228, 1),Color.fromRGBO(30, 103, 228, 1)]),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.transparent,width: 1),
                    ),
                    child: Text('搜索',style: TextStyle(color: Colors.white,fontSize: 14),),
                  ),
                ],
              ),
            ),
          ),
          TabBar(
            controller: _tabController,
            tabs: _tabs.map((e) => Tab(child: Text('$e',style: TextStyle(color: Color.fromRGBO(53, 53, 53, 1),fontSize: 14),),)).toList(),
          ),
          Container(
            height: 0.5,
            color: Color.fromRGBO(232, 232, 232, 1),
          ),
          Expanded(
            child: TabBarView(
                controller: _tabController,
                children: [
                  AllUser(isManage: _isManage,isAll: _isAll,),
                  CommonUser(isManage: _isManage,isAll: _isAll,),
                  VipUser(isManage: _isManage,isAll: _isAll,),
                ]
            ),
          ),
          Container(
            color: Color.fromRGBO(232, 232, 232, 1),
            height: 0.5,
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
            child: Column(
              children: [
                Container(
                  color: Color.fromRGBO(248, 248, 248, 1),
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
                          padding: EdgeInsets.all(15),
                          child: Image.asset(_isAll ? 'images/ic_selected.png' : 'images/ic_unselect.png',width: 20,height: 20,),
                        ),
                      ),
                      Text('全选',style: TextStyle(color: Color.fromRGBO(16, 16, 16, 1),fontSize: 14),),
                    ],
                  ),
                ),
                Container(
                  color: Color.fromRGBO(232, 232, 232, 1),
                  height: 0.5,
                ),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: (){
                          setState(() {
                            _isManage = false;
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(15),
                          child: Text('取消',style: TextStyle(color: Color.fromRGBO(178, 178, 178, 1),fontSize: 14),),
                        ),
                      ),
                    ),
                    Container(
                      height: 20,
                      width: 0.5,
                      color: Color.fromRGBO(232, 232, 232, 1),
                    ),
                    Expanded(
                      key: _anchorKey,
                      child: Builder(
                        builder: (context){
                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: (){
                              _showPopup(context);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(15),
                              child: Text('赠送',style: TextStyle(color: Color.fromRGBO(16, 16, 16, 1),fontSize: 14),),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AllUser extends StatefulWidget{

  bool isManage = false;
  bool isAll = false;

  AllUser({this.isManage,this.isAll});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AllUser();
  }
}

class _AllUser extends State<AllUser>{

  List<bool> _manageList = [];
  List<GlobalKey> _globalKeyList = [];

  void _initData(){
    _manageList.clear();
    _globalKeyList.clear();
    for(int i = 0; i < 5; i++){
      _manageList.add(widget.isAll);
    }
    for(int i = 0; i < _manageList.length; i++){
      _globalKeyList.add(new GlobalKey());
    }
  }

  void showMoreFunction(GlobalKey globalKey){
    RenderBox renderBox = globalKey.currentContext.findRenderObject();
    var offset =  renderBox.localToGlobal(Offset.zero);
    print('${offset.dx} : ${offset.dy} , width: ${renderBox.size.width} height: ${renderBox.size.height}');
    Navigator.push(context, PopRoute(child: Popup(
      child: Container(
        width: 130,
        height: 50,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/ic_more_function_bg.png'),
              fit: BoxFit.contain
          ),
        ),
        child: Container(
          margin: EdgeInsets.only(bottom: 2),
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('images/ic_edit_white.png',width: 12,height: 12,),
                    Text('编辑',style: TextStyle(color: Colors.white,fontSize: 8),),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('images/ic_stick_white.png',width: 12,height: 12,),
                    Text('置顶',style: TextStyle(color: Colors.white,fontSize: 8),),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('images/ic_discount_ticket_white.png',width: 12,height: 12,),
                    Text('优惠券',style: TextStyle(color: Colors.white,fontSize: 8),),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('images/ic_vip_card_white.png',width: 12,height: 12,),
                    Text('会员卡',style: TextStyle(color: Colors.white,fontSize: 8),),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      left: offset.dx - 105,
      top: offset.dy - 45,
    ),),);
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('initState');
    _initData();
  }

  @override
  void didUpdateWidget(AllUser oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget');
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print('build');
    return ListView.builder(
      itemCount: _manageList.length,
      itemBuilder: (context,index){
        return Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if(widget.isManage) GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: (){
                      setState(() {
                        _manageList[index] = !_manageList[index];
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 15,bottom: 15,right: 15),
                      child: Image.asset(_manageList[index] ? 'images/ic_selected.png' : 'images/ic_unselect.png',width: 20,height: 20,),
                    ),
                  ),
                  Image.asset('images/ic_load_default_round.png',width: 40,height: 40,),
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('可可呀可可',style: TextStyle(color: Color.fromRGBO(53, 53, 53, 1),fontSize: 12,fontWeight: FontWeight.bold),),
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              padding: EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 2),
                              decoration: BoxDecoration(
                                border: Border.all(color: Color.fromRGBO(4, 50, 157, 1)),
                                borderRadius: BorderRadius.circular(5)
                              ),
                              child: Text('三天内消费',style: TextStyle(color: Color.fromRGBO(4, 50, 157, 1),fontSize: 10),),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              padding: EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 2),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color.fromRGBO(4, 50, 157, 1)),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Text('VIP',style: TextStyle(color: Color.fromRGBO(4, 50, 157, 1),fontSize: 10),),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('累计下单(笔)：999999',style: TextStyle(color: Color.fromRGBO(136, 136, 136, 1),fontSize: 10),),
                              Container(
                                margin: EdgeInsets.only(left: 5,right: 5),
                                child: Text('累计消费(元)：888888',style: TextStyle(color: Color.fromRGBO(136, 136, 136, 1),fontSize: 10),),
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: (){
                                  showMoreFunction(_globalKeyList[index]);
                                },
                                child: Container(
                                  key: _globalKeyList[index],
                                  padding: EdgeInsets.all(5),
                                  child: Image.asset('images/ic_more_function.png',width: 15,height: 3,),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15,right: 15),
              color: Color.fromRGBO(232, 232, 232, 1),
              height: 0.5,
            ),
          ],
        );
      },
    );
  }
}

class CommonUser extends StatefulWidget{

  bool isManage = false;
  bool isAll = false;

  CommonUser({this.isManage,this.isAll});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CommonUser();
  }
}

class _CommonUser extends State<CommonUser>{

  List<bool> _manageList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('initState');
    _manageList.clear();
    for(int i = 0; i < 5; i++){
      _manageList.add(widget.isAll);
    }
  }

  @override
  void didUpdateWidget(CommonUser oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget');
    _manageList.clear();
    for(int i = 0; i < 5; i++){
      _manageList.add(widget.isAll);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print('build');
    return ListView.builder(
      itemCount: _manageList.length,
      itemBuilder: (context,index){
        return Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if(widget.isManage) GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: (){
                      setState(() {
                        _manageList[index] = !_manageList[index];
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 15,bottom: 15,right: 15),
                      child: Image.asset(_manageList[index] ? 'images/ic_selected.png' : 'images/ic_unselect.png',width: 20,height: 20,),
                    ),
                  ),
                  Image.asset('images/ic_load_default_round.png',width: 40,height: 40,),
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('可可呀可可',style: TextStyle(color: Color.fromRGBO(53, 53, 53, 1),fontSize: 12,fontWeight: FontWeight.bold),),
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              padding: EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 2),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color.fromRGBO(4, 50, 157, 1)),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Text('三天内消费',style: TextStyle(color: Color.fromRGBO(4, 50, 157, 1),fontSize: 10),),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              padding: EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 2),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color.fromRGBO(4, 50, 157, 1)),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Text('VIP',style: TextStyle(color: Color.fromRGBO(4, 50, 157, 1),fontSize: 10),),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('累计下单(笔)：999999',style: TextStyle(color: Color.fromRGBO(136, 136, 136, 1),fontSize: 10),),
                              Container(
                                margin: EdgeInsets.only(left: 5,right: 5),
                                child: Text('累计消费(元)：888888',style: TextStyle(color: Color.fromRGBO(136, 136, 136, 1),fontSize: 10),),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                child: Image.asset('images/ic_more_function.png',width: 15,height: 3,),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15,right: 15),
              color: Color.fromRGBO(232, 232, 232, 1),
              height: 0.5,
            ),
          ],
        );
      },
    );
  }
}

class VipUser extends StatefulWidget{

  bool isManage = false;
  bool isAll = false;

  VipUser({this.isManage,this.isAll});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VipUser();
  }
}

class _VipUser extends State<VipUser>{

  List<bool> _manageList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('initState');
    _manageList.clear();
    for(int i = 0; i < 5; i++){
      _manageList.add(widget.isAll);
    }
  }

  @override
  void didUpdateWidget(VipUser oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget');
    _manageList.clear();
    for(int i = 0; i < 5; i++){
      _manageList.add(widget.isAll);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print('build');
    return ListView.builder(
      itemCount: _manageList.length,
      itemBuilder: (context,index){
        return Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if(widget.isManage) GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: (){
                      setState(() {
                        _manageList[index] = !_manageList[index];
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.only(top: 15,bottom: 15,right: 15),
                      child: Image.asset(_manageList[index] ? 'images/ic_selected.png' : 'images/ic_unselect.png',width: 20,height: 20,),
                    ),
                  ),
                  Image.asset('images/ic_load_default_round.png',width: 40,height: 40,),
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('可可呀可可',style: TextStyle(color: Color.fromRGBO(53, 53, 53, 1),fontSize: 12,fontWeight: FontWeight.bold),),
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              padding: EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 2),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color.fromRGBO(4, 50, 157, 1)),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Text('三天内消费',style: TextStyle(color: Color.fromRGBO(4, 50, 157, 1),fontSize: 10),),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              padding: EdgeInsets.only(left: 5,right: 5,top: 2,bottom: 2),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color.fromRGBO(4, 50, 157, 1)),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Text('VIP',style: TextStyle(color: Color.fromRGBO(4, 50, 157, 1),fontSize: 10),),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('累计下单(笔)：999999',style: TextStyle(color: Color.fromRGBO(136, 136, 136, 1),fontSize: 10),),
                              Container(
                                margin: EdgeInsets.only(left: 5,right: 5),
                                child: Text('累计消费(元)：888888',style: TextStyle(color: Color.fromRGBO(136, 136, 136, 1),fontSize: 10),),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                child: Image.asset('images/ic_more_function.png',width: 15,height: 3,),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 15,right: 15),
              color: Color.fromRGBO(232, 232, 232, 1),
              height: 0.5,
            ),
          ],
        );
      },
    );
  }
}