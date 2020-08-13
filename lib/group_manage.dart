import 'package:flutter/material.dart';
import 'add_group.dart';
import 'widget/slide_button.dart';

class GroupManage extends StatefulWidget{
  @override
  _GroupManage createState() => _GroupManage();
}

class _GroupManage extends State<GroupManage>{

  List<String> groupNames = [];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      appBar: AppBar(
        title: Text('分组管理'),
      ),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.only(left: 20,right: 20,top: 20),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context,index){
                      var key = GlobalKey<SlideButtonState>();
                      return ItemGroup(key:key,name: groupNames[index],);
                    },childCount: groupNames.length),
                  ),
                ),
              ],
            ),
          ),
//          Expanded(
//            child: ListView.builder(
//              padding: EdgeInsets.all(20),
//              physics: BouncingScrollPhysics(),
//              itemCount: groupNames.length,
//              itemBuilder: (context, index){
//                return ItemGroup(name: groupNames[index],);
//              },
//            ),
//          ),
          Container(
            height: 1,
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: ()async{
              var result = await Navigator.push(context, MaterialPageRoute(builder: (context) => AddGroup()));
              if(result != null){
                setState(() {
                  groupNames.add(result);
                });
              }
            },
            child: Container(
              color: Colors.white,
              width: double.infinity,
              padding: EdgeInsets.all(15),
              child: Text('添加分组',style: TextStyle(color: Color.fromRGBO(53, 53, 53, 1),fontSize: 14),textAlign: TextAlign.center,),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemGroup extends StatefulWidget{

  String name;
  GlobalKey<SlideButtonState> key;

  ItemGroup({
    @required this.key,
    this.name
  });

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ItemGroup();
  }
}

class _ItemGroup extends State<ItemGroup>{
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        SlideButton(
          key: widget.key,
          singleButtonWidth: 60,
          buttons: [
            buildAction(widget.key, Colors.red, () {
              widget.key.currentState.close();
            })
          ],
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(widget.name,style: TextStyle(color: Color.fromRGBO(53, 53, 53, 1),fontSize: 14,fontWeight: FontWeight.bold),),
                ),
                Text('共10件',style: TextStyle(color: Color.fromRGBO(174, 174, 174, 1),fontSize: 12,)),
              ],
            ),
          ),
        ),
        Container(
          height: 10,
        ),
      ],
    );
  }

  InkWell buildAction(
      GlobalKey<SlideButtonState> key, Color color, GestureTapCallback tap) {
    return InkWell(
      onTap: tap,
      child: Container(
        alignment: Alignment.center,
        width: 60,
        color: color,
        child: Image.asset(
          'images/img_del_white.png',
          width: 15,
          height: 15,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}