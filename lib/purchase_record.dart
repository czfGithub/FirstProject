import 'package:flutter/material.dart';
import 'package:flutterapp/widget/common_appbar_widget.dart';

class PurchaseRecord extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PurchaseRecord();
  }
}

class _PurchaseRecord extends State<PurchaseRecord> with SingleTickerProviderStateMixin{

  TabController _tabController;
  List _tabs = ['本周','一个月内','半年内','全部'];

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
        case 3:
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
        center: Text('购买记录',style: TextStyle(color: Color.fromRGBO(16, 16, 16, 1),fontSize: 18,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            height: 0.5,
            color: Color.fromRGBO(232, 232, 232, 1),
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
                  AllRecord(),
                  AllRecord(),
                  AllRecord(),
                  AllRecord(),
                ]
            ),
          )
        ],
      ),
    );
  }
}

class AllRecord extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context,index){
        return Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('images/ic_load_default_round.png',width: 50,height: 50,),
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text('2020春季爆款碎花连衣裙...',style: TextStyle(color: Color.fromRGBO(53, 53, 53, 1),fontSize: 12),),
                              ),
                              Text('昨天',style: TextStyle(color: Color.fromRGBO(136, 136, 136, 1),fontSize: 10),),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text('白色  S码  x1',style: TextStyle(color: Color.fromRGBO(136, 136, 136, 1),fontSize: 10),),
                                ),
                                Text('数量(件)：2',style: TextStyle(color: Color.fromRGBO(136, 136, 136, 1),fontSize: 10),),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text('粉色  L码  x1',style: TextStyle(color: Color.fromRGBO(136, 136, 136, 1),fontSize: 10),),
                                ),
                                Text('合计(元)：888',style: TextStyle(color: Color.fromRGBO(136, 136, 136, 1),fontSize: 10),),
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