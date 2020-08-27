import 'package:flutter/material.dart';

class ShowDialog extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ShowDialog();
  }
}

class _ShowDialog extends State<ShowDialog>{

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

  List<Widget> getRow(){
    List<Widget> widgets = [];
    for(int index = 0; index < selecteDiscount.length; index++){
      widgets.add(Row(
        children: [],
      ));
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Dialog'),
      ),
      body: Builder(
        builder: (context){
          return Column(
            children: [
              FlatButton(
                child: Text('会员卡'),
                onPressed: () async{
                  int type = await _showBottomSheet(context);
                  print('type:$type');
                },
              ),
              FlatButton(
                child: Text('优惠券'),
                onPressed: () async{
                  int type = await _showDiscountBottomSheet(context);
                  print('type:$type');
                },
              ),
            ],
          );
        },
      ),
    );
  }
}