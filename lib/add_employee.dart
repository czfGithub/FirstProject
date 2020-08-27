import 'package:flutter/material.dart';
import 'package:flutterapp/employee_role.dart';
import 'package:flutterapp/widget/common_appbar_widget.dart';

class AddEmployee extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddEmployee();
  }
}

class _AddEmployee extends State<AddEmployee>{

  String _employeeRole = '选择工作';

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
            width: double.infinity,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Text('员工名称',style: TextStyle(color: Color.fromRGBO(53, 53, 53, 1),fontSize: 16),),
              ),
              Expanded(
                child: TextField(
                  style: TextStyle(color: Color.fromRGBO(136, 136, 136, 1),fontSize: 16),
                  decoration: InputDecoration(
                    hintText: '请输入员工名称',
                    hintStyle: TextStyle(color: Color.fromRGBO(136, 136, 136, 1),fontSize: 16),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
                  ),
                ),
              ),
            ],
          ),
          Container(
            color: Color.fromRGBO(232, 232, 232, 1),
            height: 0.5,
            width: double.infinity,
            margin: EdgeInsets.only(left: 15,right: 15),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Text('手机号码',style: TextStyle(color: Color.fromRGBO(53, 53, 53, 1),fontSize: 16),),
              ),
              Expanded(
                child: TextField(
                  style: TextStyle(color: Color.fromRGBO(136, 136, 136, 1),fontSize: 16),
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    hintText: '请输入手机号码',
                    hintStyle: TextStyle(color: Color.fromRGBO(136, 136, 136, 1),fontSize: 16),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(top: 10,bottom: 10,left: 20,right: 20),
                  ),
                ),
              ),
            ],
          ),
          Container(
            color: Color.fromRGBO(232, 232, 232, 1),
            height: 0.5,
            width: double.infinity,
            margin: EdgeInsets.only(left: 15,right: 15),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 15,right: 15),
                child: Text('员工角色',style: TextStyle(color: Color.fromRGBO(53, 53, 53, 1),fontSize: 16),),
              ),
              Expanded(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () async{
                    var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => EmployeeRole()));
                    if(result != null){
                      setState(() {
                        _employeeRole = result;
                      });
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 15,bottom: 15),
                    child: Text(
                      _employeeRole,
                      style: TextStyle(color: Color.fromRGBO(136, 136, 136, 1),fontSize: 16),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15,right: 15),
                child: Image.asset('images/ic_route_right_arrow.png'),
              ),
            ],
          ),
          Container(
            color: Color.fromRGBO(232, 232, 232, 1),
            height: 0.5,
            width: double.infinity,
            margin: EdgeInsets.only(left: 15,right: 15),
          ),
          Container(
            margin: EdgeInsets.only(top: 30,left: 15,right: 15,bottom: 30),
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Color.fromRGBO(114, 198, 254, 1),Color.fromRGBO(30, 103, 228, 1),Color.fromRGBO(30, 103, 228, 1)]),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text('邀请',style: TextStyle(color: Colors.white,fontSize: 14),),
          )
        ],
      ),
    );
  }
}