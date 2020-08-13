import 'package:flutter/material.dart';

class AddGroup extends StatefulWidget{
  @override
  _AddGroup createState() => _AddGroup();
}

class _AddGroup extends State<AddGroup>{

  TextEditingController _unameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('添加分组'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _unameController,
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: (){
              var groupName = _unameController.text;
              if(groupName == ''){
                return;
              }
              Navigator.pop(context,groupName);
            },
            child: Text('保存',style: TextStyle(color: Color.fromRGBO(53, 53, 53, 1),fontSize: 14),textAlign: TextAlign.center,),
          ),
        ],
      ),
    );
  }
}