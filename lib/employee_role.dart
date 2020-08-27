import 'package:flutter/material.dart';
import 'package:flutterapp/widget/common_appbar_widget.dart';

class EmployeeRole extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EmployeeRole();
  }
}

class _EmployeeRole extends State<EmployeeRole>{

  List<String> _employees = ['高级管理员','中级管理员','普通管理员',];
  List<String> _searchList = [];

  Widget _getItemWidget(String employee){
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: (){
        Navigator.pop(context,employee);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 10,bottom: 10),
            child: Text(employee,style: TextStyle(color: Color.fromRGBO(53, 53, 53, 1),fontSize: 12),),
          ),
          Container(
            color: Color.fromRGBO(232, 232, 232, 1),
            height: 0.5,
            width: double.infinity,
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i = 0; i < _employees.length; i++){
      _searchList.add(_employees[i]);
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
        center: Text('添加员工',style: TextStyle(color: Color.fromRGBO(16, 16, 16, 1),fontSize: 18,fontWeight: FontWeight.bold),),
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
                          hintText: '输入工作名称搜索',
                          hintStyle: TextStyle(color: Color.fromRGBO(178, 178, 178, 1)),
                          contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 13),
                          border: InputBorder.none
                      ),
                      onChanged: (value){
                        setState(() {
                          _searchList.clear();
                          if(value.trim() == ''){
                            for(int i = 0; i < _employees.length; i++){
                              _searchList.add(_employees[i]);
                            }
                          }else{
                            for(int i = 0; i < _employees.length; i++){
                              if(_employees[i].contains(value.trim())){
                                _searchList.add(_employees[i]);
                              }
                            }
                          }
                        });
                      },
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
              child: Container(
                margin: EdgeInsets.only(left: 20,right: 20),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemCount: _searchList.length,
                  itemBuilder: (context, index){
                    return _getItemWidget(_searchList[index]);
                  },
                ),
              )
          ),
        ],
      ),
    );
  }
}