import 'package:flutter/material.dart';
import 'package:flutterapp/widget/common_appbar_widget.dart';

class MyService extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyService();
  }
}

class _MyService extends State<MyService>{

  List<String> messages = [];

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
        center: Text('我的客服',style: TextStyle(color: Color.fromRGBO(16, 16, 16, 1),fontSize: 18,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            color: Color.fromRGBO(232, 232, 232, 1),
            height: 0.5,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: messages.length,
              itemBuilder: (context,index){
                return ;
              },
            ),
          ),
          Container(
            color: Color.fromRGBO(232, 232, 232, 1),
            height: 0.5,
          ),
          Container(
            margin: EdgeInsets.only(left: 15,right: 15,top: 10,bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    style: TextStyle(color: Color.fromRGBO(53, 53, 53, 1),fontSize: 12),
                    decoration: InputDecoration(
                        hintText: '新信息',
                        hintStyle: TextStyle(color: Color.fromRGBO(178, 178, 178, 1)),
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(114, 198, 254, 1),
                            width: 1
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Image.asset('images/ic_dialog_service.png',width: 20,height: 20,),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}