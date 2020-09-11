import 'package:flutter/material.dart';
import 'package:flutterapp/models/popup_model.dart';

class PopupItem extends StatelessWidget{

  PopupItem({
    @required this.model,
    this.lineVisible,
    this.onClick,
  });

  bool lineVisible = true;
  PopupModel model;
  Function onClick; //点击child事件

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: (){
        if(onClick != null){
          Navigator.pop(context);
          onClick();
        }
      },
      child: Container(
        width: 100,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20,top: 10,right: 20,bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (model.icon != null && model.icon != '') Container(margin: EdgeInsets.only(right: 10),child: Image.asset(model.icon,width: 40,height: 40,),),
                  Text(model.value,style: TextStyle(color: Color.fromRGBO(53, 53, 53, 1),fontSize: 12),),
                ],
              ),
            ),
            if(lineVisible) Container(
              margin: EdgeInsets.only(left: 20,right: 20),
              height: 0.5,
              color: Color.fromRGBO(248, 96, 144, 1),
            ),
          ],
        ),
      ),
    );
  }
}