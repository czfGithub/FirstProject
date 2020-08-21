import 'package:flutter/material.dart';
import 'package:flutterapp/more_problem.dart';
import 'package:flutterapp/widget/common_appbar_widget.dart';

class HelpCenter extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HelpCenter();
  }
}

class _HelpCenter extends State<HelpCenter>{

  List<String> _commonProblem = ['店铺认证','商品管理','店铺认证','商品管理'];
  List<String> _demandFeedback = ['反馈需求列表','客户在线反馈','表单反馈'];
  List<String> _faultRepair = ['图文保修'];

  List<Widget> _getItemWidgets(List<String> problems){
    List<Widget> problemWidgets = [];
    for(int i = 0; i < problems.length; i++){
      problemWidgets.add(Container(
        padding: EdgeInsets.all(5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(problems[i],style: TextStyle(color: Color.fromRGBO(53, 53, 53, 1),fontSize: 12),),
            ),
            Image.asset('images/ic_route_right_arrow.png'),
          ],
        ),
      ));
    }
    return problemWidgets;
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
        center: Text('帮助中心',style: TextStyle(color: Color.fromRGBO(16, 16, 16, 1),fontSize: 18,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 0.5,
            color: Color.fromRGBO(232, 232, 232, 1),
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
                          hintText: '输入问题进行搜索',
                          hintStyle: TextStyle(color: Color.fromRGBO(178, 178, 178, 1)),
                          contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 13),
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
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20,right: 20,bottom: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text('常见问题',style: TextStyle(color: Color.fromRGBO(16, 16, 16, 1),fontSize: 14,fontWeight: FontWeight.bold),),
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MoreProblem()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(216, 216, 216, 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Container(
                              padding: EdgeInsets.only(left: 10,top: 5,right: 10,bottom: 5),
                              child: Text('查看更多',style: TextStyle(color: Color.fromRGBO(53, 53, 53, 1),fontSize: 10),),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Color.fromRGBO(216, 216, 216, 1),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: _getItemWidgets(_commonProblem),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('需求反馈',style: TextStyle(color: Color.fromRGBO(16, 16, 16, 1),fontSize: 14,fontWeight: FontWeight.bold),),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text('产品不好用？反馈给研发同学改进',style: TextStyle(color: Color.fromRGBO(136, 136, 136, 1),fontSize: 10),),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Color.fromRGBO(216, 216, 216, 1),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: _getItemWidgets(_demandFeedback),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('故障报修',style: TextStyle(color: Color.fromRGBO(16, 16, 16, 1),fontSize: 14,fontWeight: FontWeight.bold),),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Text('商城出故障？反馈给技术小哥',style: TextStyle(color: Color.fromRGBO(136, 136, 136, 1),fontSize: 10),),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Color.fromRGBO(216, 216, 216, 1),
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: _getItemWidgets(_faultRepair),
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