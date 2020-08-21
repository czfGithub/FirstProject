import 'package:flutter/material.dart';
import 'package:flutterapp/widget/common_appbar_widget.dart';

class DemandFeedback extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DemandFeedback();
  }
}

class _DemandFeedback extends State<DemandFeedback>{

  List<String> imageList = [''];

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
        center: Text('需求反馈',style: TextStyle(color: Color.fromRGBO(16, 16, 16, 1),fontSize: 18,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  color: Color.fromRGBO(232, 232, 232, 1),
                  width: double.infinity,
                  height: 0.5,
                ),
                Container(
                  margin: EdgeInsets.only(left: 25,top: 25),
                  child: Text('请描述一下您的需求',style: TextStyle(color: Color.fromRGBO(53, 53, 53, 1),fontSize: 14),),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10,left: 25,right: 25,bottom: 20),
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(248, 248, 248, 1),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: TextField(
                    maxLines: 10,
                    maxLength: 500,
                    style: TextStyle(color: Color.fromRGBO(53, 53, 53, 1),fontSize: 12),
                    decoration: InputDecoration(
                        hintText: '说明您的需求',
                        hintStyle: TextStyle(color: Color.fromRGBO(95, 94, 94, 1),fontSize: 12)
                    ),
                  ),
                ),
                Container(
                  color: Color.fromRGBO(232, 232, 232, 1),
                  width: double.infinity,
                  height: 0.5,
                ),
                Container(
                  margin: EdgeInsets.only(top: 20,left: 25),
                  child: Text('图片上传（提供需求截图）',style: TextStyle(color: Color.fromRGBO(53, 53, 53, 1),fontSize: 14),),
                ),
              ],
            ),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            delegate: SliverChildBuilderDelegate((context,index){
              if(index == 0)
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: (){
                    
                  },
                  child: Image.asset('images/ic_add_photo.png',width: 60,height: 60,fit: BoxFit.fill,),
                );
              return Image.asset(imageList[index],width: 60,height: 60,fit: BoxFit.fill,);
            },childCount: imageList.length),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(top: 30,left: 15,right: 15,bottom: 30),
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Color.fromRGBO(114, 198, 254, 1),Color.fromRGBO(30, 103, 228, 1),Color.fromRGBO(30, 103, 228, 1)]),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text('提交',style: TextStyle(color: Colors.white,fontSize: 14),),
            ),
          ),
        ],
      ),
    );
  }
}