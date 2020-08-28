import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/widget/common_appbar_widget.dart';

import 'date_util.dart';

class MyService extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyService();
  }
}

class _MyService extends State<MyService>{

  List<Message> messages = [
    Message(isReceive: true,message: '您好，我是您的客服可可，您可以直接描述问题给我哦~',time: '2020-08-28 15:08:15'),
    Message(isReceive:false,message: '没事没事，就是没事无聊找你聊聊天~~',time: '2020-08-28 15:08:30'),
  ];

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
            child: Container(
              padding: EdgeInsets.all(15),
              child: ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: messages.length,
                itemBuilder: (context,index){
                  return ItemMessage(message: messages[index],);
                },
              ),
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
                    textInputAction: TextInputAction.send,
                    decoration: InputDecoration(
                        hintText: '新信息',
                        hintStyle: TextStyle(color: Color.fromRGBO(178, 178, 178, 1)),
                        contentPadding: EdgeInsets.all(10),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromRGBO(114, 198, 254, 1),
                            width: 1
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromRGBO(114, 198, 254, 1),
                              width: 1
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                    ),
                    onSubmitted: (value){
                      setState(() {
                        messages.add(Message(isReceive:false,message: value,time: DateUtil.getNowDateStr()));
                      });
                    },
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

class ItemMessage extends StatelessWidget{

  Message message;
  ItemMessage({@required this.message});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if(message.isReceive){
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('images/ic_image_loading.png',width: 40,height: 40,),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 5,right: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
//                        color: Color.fromRGBO(242, 242, 242, 1),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/ic_message.9.png'),
                              fit: BoxFit.fill
                            )
                        ),
                        child: Text(message.message,style: TextStyle(color: Color.fromRGBO(53, 53, 53, 1),fontSize: 14),),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(message.time,style: TextStyle(color: Color.fromRGBO(178, 178, 178, 1),fontSize: 10),),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(height: 10,),
        ],
      );
    }else{
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 40,right: 5),
                  alignment: Alignment.centerRight,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
//                        color: Color.fromRGBO(242, 242, 242, 1),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/ic_message.9.png'),
                              fit: BoxFit.fill
                            )
                        ),
                        child: Text(message.message,style: TextStyle(color: Color.fromRGBO(53, 53, 53, 1),fontSize: 14),),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(message.time,style: TextStyle(color: Color.fromRGBO(178, 178, 178, 1),fontSize: 10),),
                      ),
                    ],
                  ),
                ),
              ),
              Image.asset('images/ic_image_loading.png',width: 40,height: 40,),
            ],
          ),
          Container(height: 10,)
        ],
      );
    }
  }
}

class Message{
  bool isReceive = false;
  String message = '';
  String time = '';

  Message({
    this.isReceive,
    this.message,
    this.time
  });
}