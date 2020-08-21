import 'package:flutter/material.dart';
import 'package:flutterapp/widget/common_appbar_widget.dart';

class MoreProblem extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MoreProblem();
  }
}

class _MoreProblem extends State<MoreProblem>{

  List<String> problems = ['店铺认证','商品管理','店铺认证','商品管理','店铺认证','商品管理','店铺认证','商品管理','店铺认证','商品管理','店铺认证','商品管理'];

  Widget _getItemWidget(String problem){
    return Container(
      padding: EdgeInsets.all(5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(problem,style: TextStyle(color: Color.fromRGBO(53, 53, 53, 1),fontSize: 12),),
          ),
          Image.asset('images/ic_route_right_arrow.png'),
        ],
      ),
    );
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
        center: Text('更多问题',style: TextStyle(color: Color.fromRGBO(16, 16, 16, 1),fontSize: 18,fontWeight: FontWeight.bold),),
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
          Container(
            color: Color.fromRGBO(232, 232, 232, 1),
            width: double.infinity,
            height: 0.5,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              child: ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: problems.length,
                itemBuilder: (context, index){
                  return _getItemWidget(problems[index]);
                },
              ),
            )
          ),
        ],
      ),
    );
  }
}