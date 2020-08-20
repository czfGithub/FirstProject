import 'package:flutter/material.dart';
import 'package:flutterapp/widget/rating_bar.dart';

class Mark extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Mark();
  }
}

class _Mark extends State<Mark>{

  double _score = 3;
  int _total = 5;

  List<Widget> _getGradeStar() {
    List<Widget> _list = List<Widget>();
    for (num i = 0; i < _total; i++) {
      double factor = (_score - i);
      if (factor >= 1) {
        factor = 1.0;
      }else if (factor < 0){
        factor = 0;
      }
      Stack _stack = Stack(
        children: <Widget>[
          Icon(
            Icons.star,
            color: Colors.grey,
          ),
          ClipRect(
              child: Align(
                alignment: Alignment.topLeft,
                widthFactor: factor,
                child: Icon(
                  Icons.star,
                  color: Colors.redAccent,
                ),
              )
          )
        ],
      );
      GestureDetector _detector = GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: (){
          setState(() {
            _score = i + 1.0;
          });
        },
        child: _stack,
      );
      _list.add(_detector);
    }
    return _list;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('评分',style: TextStyle(color: Color.fromRGBO(16, 16, 16, 1),fontSize: 18),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color.fromRGBO(232, 232, 232, 1),
              width: double.infinity,
              height: 0.5,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('产品满意度',style: TextStyle(color: Color.fromRGBO(16, 16, 16, 1),fontSize: 14),),
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20,bottom: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: _getGradeStar()
                        ),
                      ),
                      RatingBar(
                        value: 5,
                        size: 20,
                        padding: 5,
                        nomalImage: 'images/ic_star_uncheck.png',
                        selectImage: 'images/ic_star_check.png',
                        selectAble: true,
                        onRatingUpdate: (value) {},
                        maxRating: 10,
                        count: 5,
                      ),
                      Text('满意',style: TextStyle(color: Color.fromRGBO(16, 16, 16, 1),fontSize: 12),),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: Color.fromRGBO(232, 232, 232, 1),
              width: double.infinity,
              height: 0.5,
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('修改建议',style: TextStyle(color: Color.fromRGBO(16, 16, 16, 1),fontSize: 14),),
                  Container(
                    margin: EdgeInsets.only(top: 20,bottom: 20),
                    child: TextField(
                      style: TextStyle(color: Color.fromRGBO(53, 53, 53, 1),fontSize: 12),
                      maxLength: 500,
                      maxLines: 10,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        hintText: '请发表您的看法',
                        hintStyle: TextStyle(color: Color.fromRGBO(178, 178, 178, 1),fontSize: 12),
                        filled: true,
                        fillColor: Color.fromRGBO(245, 245, 245, 1),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Text('图片上传（提供需求截图）',style: TextStyle(color: Color.fromRGBO(53, 53, 53, 1),fontSize: 14),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}